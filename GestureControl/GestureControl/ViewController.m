//
//  ViewController.m
//  GestureControl
//
//  Created by Meg Grasse on 11/18/16.
//  Copyright © 2016 Meg Grasse. All rights reserved.
//

#import "ViewController.h"
#import "ClarifaiApp.h"

@implementation ViewController 

typedef void (^ClarifaiPredictionsCompletion)(NSArray <ClarifaiOutput *> *outputs, NSError *error);
static NSString * const modelID = @"general";
static NSString * const versionID = @"";

ClarifaiApp *app;
- (IBAction)image:(id)sender {
    
}

- (void)viewDidLoad {
    [super viewDidLoad];

    // Do any additional setup after loading the view.
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(captureStateChanged:) name:AVCaptureSessionRuntimeErrorNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(captureStateChanged:) name:AVCaptureSessionDidStartRunningNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(captureStateChanged:) name:AVCaptureSessionDidStopRunningNotification object:nil];
    [self accessCamera];
    
    app = [[ClarifaiApp alloc] initWithAppID:@"O-lRr8yaf-2co6U5NvsCekAvL1QlsdXveH5Db8E9" appSecret:@"E0U4dPa1klxionbwfD3reRviXWmSvqjr7M1frCSe"];

}


- (void)setRepresentedObject:(id)representedObject {
    [super setRepresentedObject:representedObject];

    // Update the view, if already loaded.
}

AVCaptureSession *session;


- (void)accessCamera {
    session = [[AVCaptureSession alloc] init];
    AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    NSError *error;
    AVCaptureDeviceInput *deviceInput = [AVCaptureDeviceInput deviceInputWithDevice:device error:&error];
    if (error) {
        NSLog(@"%@", error);
    }
    [session addInput:deviceInput];
    [session startRunning];

    AVCaptureVideoDataOutput *output = [[AVCaptureVideoDataOutput alloc] init];
    [output setVideoSettings:[NSDictionary dictionaryWithObject:[NSNumber numberWithUnsignedInt:kCVPixelFormatType_32BGRA] forKey:(NSString*)kCVPixelBufferPixelFormatTypeKey]];

    dispatch_queue_t queue = dispatch_queue_create("camera", 0);
    [output setSampleBufferDelegate:self queue:queue];
    [session addOutput:output];
}



- (void)captureStateChanged:(NSNotification *)notification {
    NSLog(@"%@", notification);
}
int i;
NSImage * image;
- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputSampleBuffer:(CMSampleBufferRef)sampleBuffer fromConnection:(AVCaptureConnection *)connection;
{
    NSData *data = imageToBuffer(sampleBuffer);
    NSLog(@"%@", data);

    if (!image) {
        if (i > 7) {
            image = [self imageFromBuffer:sampleBuffer];
            [self recognizeImage:image];
            _imageView.image = image;
        }
        i++;
    }
}

NSData* imageToBuffer( CMSampleBufferRef source) {
    CVImageBufferRef imageBuffer = CMSampleBufferGetImageBuffer(source);
    CVPixelBufferLockBaseAddress(imageBuffer,0);

    size_t bytesPerRow = CVPixelBufferGetBytesPerRow(imageBuffer);
    size_t width = CVPixelBufferGetWidth(imageBuffer);
    size_t height = CVPixelBufferGetHeight(imageBuffer);
    void *src_buff = CVPixelBufferGetBaseAddress(imageBuffer);

    NSData *data = [NSData dataWithBytes:src_buff length:bytesPerRow * height];

    CVPixelBufferUnlockBaseAddress(imageBuffer, 0);
    return data;
}

- (NSImage *) imageFromBuffer:(CMSampleBufferRef)buffer {
    CVImageBufferRef imageBuffer = CMSampleBufferGetImageBuffer(buffer);
    CVPixelBufferLockBaseAddress(imageBuffer, 0);

    void *baseAddress = CVPixelBufferGetBaseAddress(imageBuffer);
    size_t bytesPerRow = CVPixelBufferGetBytesPerRow(imageBuffer);

    size_t width = CVPixelBufferGetWidth(imageBuffer);
    size_t height = CVPixelBufferGetHeight(imageBuffer);

    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef context = CGBitmapContextCreate(baseAddress, width, height, 8, bytesPerRow, colorSpace, kCGBitmapByteOrder32Little |kCGImageAlphaNoneSkipFirst);

    CGImageRef image = CGBitmapContextCreateImage(context);

    CVPixelBufferUnlockBaseAddress(imageBuffer, 0);

    return [[NSImage alloc] initWithCGImage:image size:CGSizeMake(720, 1280)];
}

- (void)recognizeImage:(NSImage *)image {
    // Fetch Clarifai's general model.
    [app getModelByName:@"general-v1.3" completion:^(ClarifaiModel *model, NSError *error) {
        // Create a Clarifai image from a uiimage.
        ClarifaiImage *clarifaiImage = [[ClarifaiImage alloc] initWithImage:image];
        
        // Use Clarifai's general model to pedict tags for the given image.
        [model predictOnImages:@[clarifaiImage] completion:^(NSArray<ClarifaiOutput *> *outputs, NSError *error) {
            if (!error) {
                ClarifaiOutput *output = outputs[0];
                
                // Loop through predicted concepts (tags), and display them on the screen.
                NSMutableArray *tags = [NSMutableArray array];
                for (ClarifaiConcept *concept in output.concepts) {
                    [tags addObject:concept.conceptName];
                }
                NSLog(@"tags: %@", tags);
            }
        }];
    }];
}

@end

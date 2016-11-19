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
    dispatch_queue_t queue = dispatch_queue_create("camera", 0);
    [output setSampleBufferDelegate:self queue:queue];
    [session addOutput:output];
    NSLog(@"video settings: %@", output.videoSettings);
}



- (void)captureStateChanged:(NSNotification *)notification {
    NSLog(@"%@", notification);
}

- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputSampleBuffer:(CMSampleBufferRef)sampleBuffer  fromConnection:(AVCaptureConnection *)connection
{
    //... just an example of how to get an image out of this ...
    
    CGImageRef cgImage = [self imageFromSampleBuffer:sampleBuffer];
    if (cgImage) {
        NSLog(@"works");
    }
    CGImageRelease( cgImage );
}

- (CGImageRef) imageFromSampleBuffer:(CMSampleBufferRef) sampleBuffer // Create a CGImageRef from sample buffer data
{
    CVImageBufferRef imageBuffer = CMSampleBufferGetImageBuffer(sampleBuffer);
    CVPixelBufferLockBaseAddress(imageBuffer,0);        // Lock the image buffer
    
    uint8_t *baseAddress = (uint8_t *)CVPixelBufferGetBaseAddressOfPlane(imageBuffer, 0);   // Get information of the image
    size_t bytesPerRow = CVPixelBufferGetBytesPerRow(imageBuffer);
    NSLog(@"size: %zu", bytesPerRow);
    size_t width = CVPixelBufferGetWidth(imageBuffer);
    size_t height = CVPixelBufferGetHeight(imageBuffer);
    NSLog(@"height:, %zu", height);
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    
    CGContextRef newContext = CGBitmapContextCreate(baseAddress, width, height, 8, 0, colorSpace, kCGImageAlphaNone);
    CGImageRef newImage = CGBitmapContextCreateImage(newContext);
    CGContextRelease(newContext);
    
    CGColorSpaceRelease(colorSpace);
    CVPixelBufferUnlockBaseAddress(imageBuffer,0);
    /* CVBufferRelease(imageBuffer); */  // do not call this!
    
    return newImage;
}

@end

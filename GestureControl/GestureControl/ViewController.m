//
//  ViewController.m
//  GestureControl
//
//  Created by Meg Grasse on 11/18/16.
//  Copyright © 2016 Meg Grasse. All rights reserved.
//

#import "ViewController.h"

@implementation ViewController 

typedef void (^ClarifaiPredictionsCompletion)(NSArray <ClarifaiOutput *> *outputs, NSError *error);
static NSString * const modelID = @"general";
static NSString * const versionID = @"";

- (void)viewDidLoad {
    [super viewDidLoad];

    // Do any additional setup after loading the view.
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(captureStateChanged:) name:AVCaptureSessionRuntimeErrorNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(captureStateChanged:) name:AVCaptureSessionDidStartRunningNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(captureStateChanged:) name:AVCaptureSessionDidStopRunningNotification object:nil];
    [self accessCamera];
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
}



- (void)captureStateChanged:(NSNotification *)notification {
    NSLog(@"%@", notification);
}

- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputSampleBuffer:(CMSampleBufferRef)sampleBuffer fromConnection:(AVCaptureConnection *)connection;
{
    NSData *data = imageToBuffer(sampleBuffer);
    NSLog(@"%@", data);
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

@end

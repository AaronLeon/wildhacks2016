//
//  ViewController.m
//  GestureControl
//
//  Created by Meg Grasse on 11/18/16.
//  Copyright © 2016 Meg Grasse. All rights reserved.
//

#import "ViewController.h"
#import "ClarifaiApp.h"
#import <Carbon/Carbon.h>

@implementation ViewController

ClarifaiApp *app;
AVCaptureSession *session;
int counter;

- (void)viewDidLoad {
    [super viewDidLoad];
    [[NSRunningApplication runningApplicationsWithBundleIdentifier:@"com.apple.iChat"][0] activateWithOptions:NSApplicationActivateIgnoringOtherApps];
//    [NSThread sleepForTimeInterval:5];
//    [self toggleDictation];
//    [NSThread sleepForTimeInterval:5];
//    [self toggleDictation];
    [NSThread sleepForTimeInterval:5];
    [self accessCamera];

//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(captureStateChanged:) name:AVCaptureSessionRuntimeErrorNotification object:nil];
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(captureStateChanged:) name:AVCaptureSessionDidStartRunningNotification object:nil];
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(captureStateChanged:) name:AVCaptureSessionDidStopRunningNotification object:nil];
//    [self accessCamera];
    
    app = [[ClarifaiApp alloc] initWithAppID:@"qdHhhfxf4lygaKAq3RQYXN1TsbDryc6q4uLhRtV7" appSecret:@"rEG51ukIcp0sq4G52xQWLaM8DoDYRSiFFM6rhW-m"];
}

- (void)accessCamera {
    NSError *error;
    session = [[AVCaptureSession alloc] init];
    AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    AVCaptureDeviceInput *deviceInput = [AVCaptureDeviceInput deviceInputWithDevice:device error:&error];
    if (error)
        NSLog(@"%@", error);
    [session addInput:deviceInput];
    [session startRunning];

    AVCaptureVideoDataOutput *output = [[AVCaptureVideoDataOutput alloc] init];
    [output setVideoSettings:[NSDictionary dictionaryWithObject:[NSNumber numberWithUnsignedInt:kCVPixelFormatType_32BGRA] forKey:(NSString*)kCVPixelBufferPixelFormatTypeKey]];

    dispatch_queue_t queue = dispatch_queue_create("camera", 0);
    [output setSampleBufferDelegate:self queue:queue];
    [session addOutput:output];
}

//- (void)captureStateChanged:(NSNotification *)notification {
//    NSLog(@"%@", notification);
//}

- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputSampleBuffer:(CMSampleBufferRef)sampleBuffer fromConnection:(AVCaptureConnection *)connection {

    if (counter == 30) {
        NSImage* image = [self imageFromBuffer:sampleBuffer];
        [self recognizeImage:image];
        _imageView.image = image;
        counter = 0;
    }
    
    counter++;
}

- (NSImage *)imageFromBuffer:(CMSampleBufferRef)buffer {
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
    [app getModelByName:@"multiple_gestures2" completion:^(ClarifaiModel *model, NSError *error) {
        // Create a Clarifai image from a uiimage.
        ClarifaiImage *clarifaiImage = [[ClarifaiImage alloc] initWithImage:image];
        
        // Use Clarifai's general model to pedict tags for the given image.
        [model predictOnImages:@[clarifaiImage] completion:^(NSArray<ClarifaiOutput *> *outputs, NSError *error) {
            if (!error) {
                ClarifaiOutput *output = outputs[0];
                
                // Loop through predicted concepts (tags), and display them on the screen.
                NSLog(@"%@: %f", output.concepts[0].conceptName, output.concepts[0].score);
                NSLog(@"%@: %f", output.concepts[1].conceptName, output.concepts[1].score);
                NSLog(@"%@: %f", output.concepts[2].conceptName, output.concepts[2].score);
                NSLog(@"break");
                if ([output.concepts[0].conceptName isEqualToString:@"tongue"] && output.concepts[0].score > 0.35) {
                    [self sendEmojiToMessages:@"tongue"];
                }
                if ([output.concepts[0].conceptName isEqualToString:@"poop"] && output.concepts[0].score > 0.3) {
                    [self sendEmojiToMessages:@"poop"];
                }
            }
        }];
    }];
}

- (void)sendEmojiToMessages:(NSString*)emoji {
    pid_t pid = [(NSRunningApplication*)[[NSRunningApplication runningApplicationsWithBundleIdentifier:@"com.apple.iChat"] objectAtIndex:0] processIdentifier];
    ProcessSerialNumber psn;
    OSStatus err = GetProcessForPID(pid, &psn);
    if (err == noErr) {
        CGEventSourceRef src =
        CGEventSourceCreate(kCGEventSourceStateHIDSystemState);
        if ([emoji isEqualToString:@"smile"]) {
            CGEventRef semicolonKeyDown = CGEventCreateKeyboardEvent(src, kVK_ANSI_Semicolon, YES);
            CGEventRef semicolonKeyUp = CGEventCreateKeyboardEvent(src, kVK_ANSI_Semicolon, NO);
            CGEventRef parenKeyDown = CGEventCreateKeyboardEvent(src, kVK_ANSI_0, YES);
            CGEventRef parenKeyUp = CGEventCreateKeyboardEvent(src, kVK_ANSI_0, NO);
            CGEventRef spaceKeyDown = CGEventCreateKeyboardEvent(src, kVK_Space, YES);
            CGEventRef spaceKeyUp = CGEventCreateKeyboardEvent(src, kVK_Space, NO);
            CGEventSetFlags(semicolonKeyDown, kCGEventFlagMaskShift);
            CGEventSetFlags(parenKeyDown, kCGEventFlagMaskShift);
            CGEventPostToPSN(&psn, semicolonKeyDown);
            CGEventPostToPSN(&psn, semicolonKeyUp);
            CGEventPostToPSN(&psn, parenKeyDown);
            CGEventPostToPSN(&psn, parenKeyUp);
            CGEventPostToPSN(&psn, spaceKeyDown);
            CGEventPostToPSN(&psn, spaceKeyUp);
            CFRelease(semicolonKeyDown);
            CFRelease(semicolonKeyUp);
            CFRelease(parenKeyDown);
            CFRelease(parenKeyUp);
            CFRelease(spaceKeyDown);
            CFRelease(spaceKeyUp);
        } else if ([emoji isEqualToString:@"wink"]) {
            CGEventRef semicolonKeyDown = CGEventCreateKeyboardEvent(src, kVK_ANSI_Semicolon, YES);
            CGEventRef semicolonKeyUp = CGEventCreateKeyboardEvent(src, kVK_ANSI_Semicolon, NO);
            CGEventRef parenKeyDown = CGEventCreateKeyboardEvent(src, kVK_ANSI_0, YES);
            CGEventRef parenKeyUp = CGEventCreateKeyboardEvent(src, kVK_ANSI_0, NO);
            CGEventRef spaceKeyDown = CGEventCreateKeyboardEvent(src, kVK_Space, YES);
            CGEventRef spaceKeyUp = CGEventCreateKeyboardEvent(src, kVK_Space, NO);
            CGEventSetFlags(parenKeyDown, kCGEventFlagMaskShift);
            CGEventPostToPSN(&psn, semicolonKeyDown);
            CGEventPostToPSN(&psn, semicolonKeyUp);
            CGEventPostToPSN(&psn, parenKeyDown);
            CGEventPostToPSN(&psn, parenKeyUp);
            CGEventPostToPSN(&psn, spaceKeyDown);
            CGEventPostToPSN(&psn, spaceKeyUp);
            CFRelease(semicolonKeyDown);
            CFRelease(semicolonKeyUp);
            CFRelease(parenKeyDown);
            CFRelease(parenKeyUp);
            CFRelease(spaceKeyDown);
            CFRelease(spaceKeyUp);
        } else if ([emoji isEqualToString:@"frowny"]) {
            CGEventRef semicolonKeyDown = CGEventCreateKeyboardEvent(src, kVK_ANSI_Semicolon, YES);
            CGEventRef semicolonKeyUp = CGEventCreateKeyboardEvent(src, kVK_ANSI_Semicolon, NO);
            CGEventRef parenKeyDown = CGEventCreateKeyboardEvent(src, kVK_ANSI_9, YES);
            CGEventRef parenKeyUp = CGEventCreateKeyboardEvent(src, kVK_ANSI_9, NO);
            CGEventRef spaceKeyDown = CGEventCreateKeyboardEvent(src, kVK_Space, YES);
            CGEventRef spaceKeyUp = CGEventCreateKeyboardEvent(src, kVK_Space, NO);
            CGEventSetFlags(semicolonKeyDown, kCGEventFlagMaskShift);
            CGEventSetFlags(parenKeyDown, kCGEventFlagMaskShift);
            CGEventPostToPSN(&psn, semicolonKeyDown);
            CGEventPostToPSN(&psn, semicolonKeyUp);
            CGEventPostToPSN(&psn, parenKeyDown);
            CGEventPostToPSN(&psn, parenKeyUp);
            CGEventPostToPSN(&psn, spaceKeyDown);
            CGEventPostToPSN(&psn, spaceKeyUp);
            CFRelease(semicolonKeyDown);
            CFRelease(semicolonKeyUp);
            CFRelease(parenKeyDown);
            CFRelease(parenKeyUp);
            CFRelease(spaceKeyDown);
            CFRelease(spaceKeyUp);
        } else if ([emoji isEqualToString:@"tongue"]) {
            CGEventRef semicolonKeyDown = CGEventCreateKeyboardEvent(src, kVK_ANSI_Semicolon, YES);
            CGEventRef semicolonKeyUp = CGEventCreateKeyboardEvent(src, kVK_ANSI_Semicolon, NO);
            CGEventRef pKeyDown = CGEventCreateKeyboardEvent(src, kVK_ANSI_P, YES);
            CGEventRef pKeyUp = CGEventCreateKeyboardEvent(src, kVK_ANSI_P, NO);
            CGEventRef spaceKeyDown = CGEventCreateKeyboardEvent(src, kVK_Space, YES);
            CGEventRef spaceKeyUp = CGEventCreateKeyboardEvent(src, kVK_Space, NO);
            CGEventSetFlags(semicolonKeyDown,kCGEventFlagMaskShift);
            CGEventSetFlags(pKeyDown,kCGEventFlagMaskShift);
            CGEventPostToPSN(&psn, semicolonKeyDown);
            CGEventPostToPSN(&psn, semicolonKeyUp);
            CGEventPostToPSN(&psn, pKeyDown);
            CGEventPostToPSN(&psn, pKeyUp);
            CGEventPostToPSN(&psn, spaceKeyDown);
            CGEventPostToPSN(&psn, spaceKeyUp);
            CFRelease(semicolonKeyDown);
            CFRelease(semicolonKeyUp);
            CFRelease(pKeyDown);
            CFRelease(pKeyUp);
            CFRelease(spaceKeyDown);
            CFRelease(spaceKeyUp);
        } else if ([emoji isEqualToString:@"sunglasses"]) {
            CGEventRef bKeyDown = CGEventCreateKeyboardEvent(src, kVK_ANSI_B, YES);
            CGEventRef bKeyUp = CGEventCreateKeyboardEvent(src, kVK_ANSI_B, NO);
            CGEventRef parenKeyDown = CGEventCreateKeyboardEvent(src, kVK_ANSI_0, YES);
            CGEventRef parenKeyUp = CGEventCreateKeyboardEvent(src, kVK_ANSI_0, NO);
            CGEventRef spaceKeyDown = CGEventCreateKeyboardEvent(src, kVK_Space, YES);
            CGEventRef spaceKeyUp = CGEventCreateKeyboardEvent(src, kVK_Space, NO);
            CGEventSetFlags(bKeyDown, kCGEventFlagMaskShift);
            CGEventSetFlags(parenKeyDown, kCGEventFlagMaskShift);
            CGEventPostToPSN(&psn, bKeyDown);
            CGEventPostToPSN(&psn, bKeyUp);
            CGEventPostToPSN(&psn, parenKeyDown);
            CGEventPostToPSN(&psn, parenKeyUp);
            CGEventPostToPSN(&psn, spaceKeyDown);
            CGEventPostToPSN(&psn, spaceKeyUp);
            CFRelease(bKeyDown);
            CFRelease(bKeyUp);
            CFRelease(parenKeyDown);
            CFRelease(parenKeyUp);
            CFRelease(spaceKeyDown);
            CFRelease(spaceKeyUp);
        } else if ([emoji isEqualToString:@"laughing"]) {
            CGEventRef semicolonKeyDown = CGEventCreateKeyboardEvent(src, kVK_ANSI_Semicolon, YES);
            CGEventRef semicolonKeyUp = CGEventCreateKeyboardEvent(src, kVK_ANSI_Semicolon, NO);
            CGEventRef dKeyDown = CGEventCreateKeyboardEvent(src, kVK_ANSI_D, YES);
            CGEventRef dKeyUp = CGEventCreateKeyboardEvent(src, kVK_ANSI_D, NO);
            CGEventRef spaceKeyDown = CGEventCreateKeyboardEvent(src, kVK_Space, YES);
            CGEventRef spaceKeyUp = CGEventCreateKeyboardEvent(src, kVK_Space, NO);
            CGEventSetFlags(semicolonKeyDown, kCGEventFlagMaskShift);
            CGEventSetFlags(dKeyDown, kCGEventFlagMaskShift);
            CGEventPostToPSN(&psn, semicolonKeyDown);
            CGEventPostToPSN(&psn, semicolonKeyUp);
            CGEventPostToPSN(&psn, dKeyDown);
            CGEventPostToPSN(&psn, dKeyUp);
            CGEventPostToPSN(&psn, spaceKeyDown);
            CGEventPostToPSN(&psn, spaceKeyUp);
            CFRelease(semicolonKeyDown);
            CFRelease(semicolonKeyUp);
            CFRelease(dKeyDown);
            CFRelease(dKeyUp);
            CFRelease(spaceKeyDown);
            CFRelease(spaceKeyUp);
        } else if ([emoji isEqualToString:@"poop"]) {
            CGEventRef pKeyDown = CGEventCreateKeyboardEvent(src, kVK_ANSI_P, YES);
            CGEventRef pKeyUp = CGEventCreateKeyboardEvent(src, kVK_ANSI_P, NO);
            CGEventRef oKeyDown = CGEventCreateKeyboardEvent(src, kVK_ANSI_O, YES);
            CGEventRef oKeyUp = CGEventCreateKeyboardEvent(src, kVK_ANSI_O, NO);
            CGEventRef spaceKeyDown = CGEventCreateKeyboardEvent(src, kVK_Space, YES);
            CGEventRef spaceKeyUp = CGEventCreateKeyboardEvent(src, kVK_Space, NO);
            CGEventPostToPSN(&psn, pKeyDown);
            CGEventPostToPSN(&psn, pKeyUp);
            CGEventPostToPSN(&psn, oKeyDown);
            CGEventPostToPSN(&psn, oKeyUp);
            CGEventPostToPSN(&psn, oKeyDown);
            CGEventPostToPSN(&psn, oKeyUp);
            CGEventPostToPSN(&psn, pKeyDown);
            CGEventPostToPSN(&psn, pKeyUp);
            CGEventPostToPSN(&psn, spaceKeyDown);
            CGEventPostToPSN(&psn, spaceKeyUp);
            CFRelease(pKeyDown);
            CFRelease(pKeyUp);
            CFRelease(oKeyDown);
            CFRelease(oKeyUp);
            CFRelease(spaceKeyDown);
            CFRelease(spaceKeyUp);
        }
        CFRelease(src);
        [self sendMessage];
    }
}

- (void)toggleDictation {
    pid_t pid = [(NSRunningApplication*)[[NSRunningApplication runningApplicationsWithBundleIdentifier:@"com.apple.iChat"] objectAtIndex:0] processIdentifier];
    ProcessSerialNumber psn;
    OSStatus err = GetProcessForPID(pid, &psn);
    if (err == noErr) {
        CGEventSourceRef src =
        CGEventSourceCreate(kCGEventSourceStateHIDSystemState);
        CGEventRef fnKeyDown = CGEventCreateKeyboardEvent(src, kVK_Function, YES);
        CGEventRef fnKeyUp = CGEventCreateKeyboardEvent(src, kVK_Function, NO);
        CGEventPostToPSN(&psn, fnKeyDown);
        CGEventPostToPSN(&psn, fnKeyUp);
        CGEventPostToPSN(&psn, fnKeyDown);
        CGEventPostToPSN(&psn, fnKeyUp);
        CFRelease(fnKeyDown);
        CFRelease(fnKeyUp);
        CFRelease(src);
    }
}

- (void)sendMessage {
    pid_t pid = [(NSRunningApplication*)[[NSRunningApplication runningApplicationsWithBundleIdentifier:@"com.apple.iChat"] objectAtIndex:0] processIdentifier];
    ProcessSerialNumber psn;
    OSStatus err = GetProcessForPID(pid, &psn);
    if (err == noErr) {
        CGEventSourceRef src =
        CGEventSourceCreate(kCGEventSourceStateHIDSystemState);
        CGEventRef returnKeyDown = CGEventCreateKeyboardEvent(src, kVK_Return, YES);
        CGEventRef returnKeyUp = CGEventCreateKeyboardEvent(src, kVK_Return, NO);
        CGEventPostToPSN(&psn, returnKeyDown);
        CGEventPostToPSN(&psn, returnKeyUp);
        CFRelease(returnKeyDown);
        CFRelease(returnKeyUp);
        CFRelease(src);
    }
}

@end

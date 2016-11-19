//
//  ViewController.h
//  GestureControl
//
//  Created by Meg Grasse on 11/18/16.
//  Copyright © 2016 Meg Grasse. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <AVFoundation/AVFoundation.h>

@interface ViewController : NSViewController <AVCaptureVideoDataOutputSampleBufferDelegate>

@property (weak) IBOutlet NSImageView *imageView;


@end


//
//  ViewController.m
//  GestureControl
//
//  Created by Meg Grasse on 11/18/16.
//  Copyright © 2016 Meg Grasse. All rights reserved.
//

#import "ViewController.h"
#import <Carbon/Carbon.h>

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setMessageToMessages:@"smile"];

    // Do any additional setup after loading the view.
}


- (void)setRepresentedObject:(id)representedObject {
    [super setRepresentedObject:representedObject];

    // Update the view, if already loaded.
}

- (void)setMessageToMessages:(NSString*)emoji {
    pid_t pid = [(NSRunningApplication*)[[NSRunningApplication runningApplicationsWithBundleIdentifier:@"com.apple.iChat"] objectAtIndex:0] processIdentifier];
    ProcessSerialNumber psn;
    OSStatus err = GetProcessForPID(pid, &psn);
    if (err == noErr) {
        
        CGEventSourceRef src =
        CGEventSourceCreate(kCGEventSourceStateHIDSystemState);

        if ([emoji isEqualToString:@"smile"]) {
            CGEventRef sKeyDown = CGEventCreateKeyboardEvent(src, kVK_ANSI_S, YES);
            CGEventRef sKeyUp = CGEventCreateKeyboardEvent(src, kVK_ANSI_S, NO);
            CGEventRef mKeyDown = CGEventCreateKeyboardEvent(src, kVK_ANSI_M, YES);
            CGEventRef mKeyUp = CGEventCreateKeyboardEvent(src, kVK_ANSI_M, NO);
            CGEventRef iKeyDown = CGEventCreateKeyboardEvent(src, kVK_ANSI_I, YES);
            CGEventRef iKeyUp = CGEventCreateKeyboardEvent(src, kVK_ANSI_I, NO);
            CGEventRef lKeyDown = CGEventCreateKeyboardEvent(src, kVK_ANSI_L, YES);
            CGEventRef lKeyUp = CGEventCreateKeyboardEvent(src, kVK_ANSI_L, NO);
            CGEventRef eKeyDown = CGEventCreateKeyboardEvent(src, kVK_ANSI_E, YES);
            CGEventRef eKeyUp = CGEventCreateKeyboardEvent(src, kVK_ANSI_E, NO);
            CGEventRef spaceKeyDown = CGEventCreateKeyboardEvent(src, kVK_Space, YES);
            CGEventRef spaceKeyUp = CGEventCreateKeyboardEvent(src, kVK_Space, NO);
            
            CGEventPostToPSN(&psn, sKeyDown);
            CGEventPostToPSN(&psn, sKeyUp);
            CGEventPostToPSN(&psn, mKeyDown);
            CGEventPostToPSN(&psn, mKeyUp);
            CGEventPostToPSN(&psn, iKeyDown);
            CGEventPostToPSN(&psn, iKeyUp);
            CGEventPostToPSN(&psn, lKeyDown);
            CGEventPostToPSN(&psn, lKeyUp);
            CGEventPostToPSN(&psn, eKeyDown);
            CGEventPostToPSN(&psn, eKeyUp);
            CGEventPostToPSN(&psn, spaceKeyDown);
            CGEventPostToPSN(&psn, spaceKeyUp);
            
            CFRelease(sKeyDown);
            CFRelease(sKeyUp);
            CFRelease(mKeyDown);
            CFRelease(mKeyUp);
            CFRelease(iKeyDown);
            CFRelease(iKeyUp);
            CFRelease(lKeyDown);
            CFRelease(lKeyUp);
            CFRelease(eKeyDown);
            CFRelease(eKeyUp);
            CFRelease(spaceKeyDown);
            CFRelease(spaceKeyUp);
            CFRelease(src);
        }
    }
}


@end

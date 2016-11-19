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
    }
        CFRelease(src);
    }
}


@end

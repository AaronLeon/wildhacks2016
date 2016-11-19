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
            CGEventRef wKeyDown = CGEventCreateKeyboardEvent(src, kVK_ANSI_W, YES);
            CGEventRef wKeyUp = CGEventCreateKeyboardEvent(src, kVK_ANSI_W, NO);
            CGEventRef iKeyDown = CGEventCreateKeyboardEvent(src, kVK_ANSI_I, YES);
            CGEventRef iKeyUp = CGEventCreateKeyboardEvent(src, kVK_ANSI_I, NO);
            CGEventRef nKeyDown = CGEventCreateKeyboardEvent(src, kVK_ANSI_N, YES);
            CGEventRef nKeyUp = CGEventCreateKeyboardEvent(src, kVK_ANSI_N, NO);
            CGEventRef kKeyDown = CGEventCreateKeyboardEvent(src, kVK_ANSI_K, YES);
            CGEventRef kKeyUp = CGEventCreateKeyboardEvent(src, kVK_ANSI_K, NO);
            CGEventRef spaceKeyDown = CGEventCreateKeyboardEvent(src, kVK_Space, YES);
            CGEventRef spaceKeyUp = CGEventCreateKeyboardEvent(src, kVK_Space, NO);
            CGEventPostToPSN(&psn, wKeyDown);
            CGEventPostToPSN(&psn, wKeyUp);
            CGEventPostToPSN(&psn, iKeyDown);
            CGEventPostToPSN(&psn, iKeyUp);
            CGEventPostToPSN(&psn, nKeyDown);
            CGEventPostToPSN(&psn, nKeyUp);
            CGEventPostToPSN(&psn, kKeyDown);
            CGEventPostToPSN(&psn, kKeyUp);
            CGEventPostToPSN(&psn, spaceKeyDown);
            CGEventPostToPSN(&psn, spaceKeyUp);
            CFRelease(wKeyDown);
            CFRelease(wKeyUp);
            CFRelease(iKeyDown);
            CFRelease(iKeyUp);
            CFRelease(nKeyDown);
            CFRelease(nKeyUp);
            CFRelease(kKeyDown);
            CFRelease(kKeyUp);
            CFRelease(spaceKeyDown);
            CFRelease(spaceKeyUp);
        } else if ([emoji isEqualToString:@"tongue"]) {
            CGEventRef tKeyDown = CGEventCreateKeyboardEvent(src, kVK_ANSI_T, YES);
            CGEventRef tKeyUp = CGEventCreateKeyboardEvent(src, kVK_ANSI_T, NO);
            CGEventRef oKeyDown = CGEventCreateKeyboardEvent(src, kVK_ANSI_O, YES);
            CGEventRef oKeyUp = CGEventCreateKeyboardEvent(src, kVK_ANSI_O, NO);
            CGEventRef nKeyDown = CGEventCreateKeyboardEvent(src, kVK_ANSI_N, YES);
            CGEventRef nKeyUp = CGEventCreateKeyboardEvent(src, kVK_ANSI_N, NO);
            CGEventRef gKeyDown = CGEventCreateKeyboardEvent(src, kVK_ANSI_G, YES);
            CGEventRef gKeyUp = CGEventCreateKeyboardEvent(src, kVK_ANSI_G, NO);
            CGEventRef uKeyDown = CGEventCreateKeyboardEvent(src, kVK_ANSI_U, YES);
            CGEventRef uKeyUp = CGEventCreateKeyboardEvent(src, kVK_ANSI_U, NO);
            CGEventRef eKeyDown = CGEventCreateKeyboardEvent(src, kVK_ANSI_E, YES);
            CGEventRef eKeyUp = CGEventCreateKeyboardEvent(src, kVK_ANSI_E, NO);
            CGEventRef spaceKeyDown = CGEventCreateKeyboardEvent(src, kVK_Space, YES);
            CGEventRef spaceKeyUp = CGEventCreateKeyboardEvent(src, kVK_Space, NO);
            CGEventPostToPSN(&psn, tKeyDown);
            CGEventPostToPSN(&psn, tKeyUp);
            CGEventPostToPSN(&psn, oKeyDown);
            CGEventPostToPSN(&psn, oKeyUp);
            CGEventPostToPSN(&psn, nKeyDown);
            CGEventPostToPSN(&psn, nKeyUp);
            CGEventPostToPSN(&psn, gKeyDown);
            CGEventPostToPSN(&psn, gKeyUp);
            CGEventPostToPSN(&psn, uKeyDown);
            CGEventPostToPSN(&psn, uKeyUp);
            CGEventPostToPSN(&psn, eKeyDown);
            CGEventPostToPSN(&psn, eKeyUp);
            CGEventPostToPSN(&psn, spaceKeyDown);
            CGEventPostToPSN(&psn, spaceKeyUp);
            CFRelease(tKeyDown);
            CFRelease(tKeyUp);
            CFRelease(oKeyDown);
            CFRelease(oKeyUp);
            CFRelease(nKeyDown);
            CFRelease(nKeyUp);
            CFRelease(gKeyDown);
            CFRelease(gKeyUp);
            CFRelease(uKeyDown);
            CFRelease(uKeyUp);
            CFRelease(eKeyDown);
            CFRelease(eKeyUp);
            CFRelease(spaceKeyDown);
            CFRelease(spaceKeyUp);
        } else if ([emoji isEqualToString:@"tongue"]) {
        CGEventRef tKeyDown = CGEventCreateKeyboardEvent(src, kVK_ANSI_T, YES);
        CGEventRef tKeyUp = CGEventCreateKeyboardEvent(src, kVK_ANSI_T, NO);
        CGEventRef oKeyDown = CGEventCreateKeyboardEvent(src, kVK_ANSI_O, YES);
        CGEventRef oKeyUp = CGEventCreateKeyboardEvent(src, kVK_ANSI_O, NO);
        CGEventRef nKeyDown = CGEventCreateKeyboardEvent(src, kVK_ANSI_N, YES);
        CGEventRef nKeyUp = CGEventCreateKeyboardEvent(src, kVK_ANSI_N, NO);
        CGEventRef gKeyDown = CGEventCreateKeyboardEvent(src, kVK_ANSI_G, YES);
        CGEventRef gKeyUp = CGEventCreateKeyboardEvent(src, kVK_ANSI_G, NO);
        CGEventRef uKeyDown = CGEventCreateKeyboardEvent(src, kVK_ANSI_U, YES);
        CGEventRef uKeyUp = CGEventCreateKeyboardEvent(src, kVK_ANSI_U, NO);
        CGEventRef eKeyDown = CGEventCreateKeyboardEvent(src, kVK_ANSI_E, YES);
        CGEventRef eKeyUp = CGEventCreateKeyboardEvent(src, kVK_ANSI_E, NO);
        CGEventRef spaceKeyDown = CGEventCreateKeyboardEvent(src, kVK_Space, YES);
        CGEventRef spaceKeyUp = CGEventCreateKeyboardEvent(src, kVK_Space, NO);
        CGEventPostToPSN(&psn, tKeyDown);
        CGEventPostToPSN(&psn, tKeyUp);
        CGEventPostToPSN(&psn, oKeyDown);
        CGEventPostToPSN(&psn, oKeyUp);
        CGEventPostToPSN(&psn, nKeyDown);
        CGEventPostToPSN(&psn, nKeyUp);
        CGEventPostToPSN(&psn, gKeyDown);
        CGEventPostToPSN(&psn, gKeyUp);
        CGEventPostToPSN(&psn, uKeyDown);
        CGEventPostToPSN(&psn, uKeyUp);
        CGEventPostToPSN(&psn, eKeyDown);
        CGEventPostToPSN(&psn, eKeyUp);
        CGEventPostToPSN(&psn, spaceKeyDown);
        CGEventPostToPSN(&psn, spaceKeyUp);
        CFRelease(tKeyDown);
        CFRelease(tKeyUp);
        CFRelease(oKeyDown);
        CFRelease(oKeyUp);
        CFRelease(nKeyDown);
        CFRelease(nKeyUp);
        CFRelease(gKeyDown);
        CFRelease(gKeyUp);
        CFRelease(uKeyDown);
        CFRelease(uKeyUp);
        CFRelease(eKeyDown);
        CFRelease(eKeyUp);
        CFRelease(spaceKeyDown);
        CFRelease(spaceKeyUp);
    }
        CFRelease(src);
    }
}


@end

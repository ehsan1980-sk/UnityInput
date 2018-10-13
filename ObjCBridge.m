//
//  Types.m
//  Unity-iPhone
//
//  Created by LuzanovRoman on 24.10.2017.
//

#import "ObjCBridge.h"
#import "UnityInterface.h"
#import "InputManager.h"

// MARK:- Private
NSString * nsString (const char * cString) {
    if (cString) {
        return [NSString stringWithUTF8String:cString];
    }
    return nil;
}

const char * cString (NSString * nsString) {
    return [nsString cStringUsingEncoding:NSUTF8StringEncoding];
}

void callUnityObject(NSString * object, NSString * method, NSString * parameter) {
    UnitySendMessage(cString(object), cString(method), cString(parameter));
}

// MARK:- Public
void inputEnable() {
    [[InputManager sharedInstance] enable];
}

void inputDisable() {
    [[InputManager sharedInstance] disable];
}

bool inputIsMouseCursorHidden() {
    return [[InputManager sharedInstance] isMouseCursorHidden];
}

void inputSetMouseCursorHidden(bool value) {
    [InputManager sharedInstance].isMouseCursorHidden = value;
}

const char * inputMousePosition() {
    CGPoint position = [InputManager sharedInstance].mousePosition;
    return cString([NSString stringWithFormat:@"%f,%f", position.x, position.y]);
}

void inputSetMousePosition(const char * mousePosition) {
    NSString * point = nsString(mousePosition);
    NSArray * components = [point componentsSeparatedByString:@","];
    
    if (components.count == 2) {
        float x = [components.firstObject floatValue] / UIScreen.mainScreen.scale;
        float y = [components.lastObject floatValue] / UIScreen.mainScreen.scale;
        [InputManager sharedInstance].mousePosition = CGPointMake(x, y);
    }
}

bool inputIsKeyPressed(const char * keyName) {
    return [[InputManager sharedInstance] isKeyPressed:nsString(keyName)];
}

bool inputIsMouseButtonPressed(int button) {
    return [[InputManager sharedInstance] isMouseButtonPressed:button];
}

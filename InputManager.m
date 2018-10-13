//
//  InputManager.m
//  Unity-iPhone
//
//  Created by LuzanovRoman on 26.04.2018.
//

#import "InputManager.h"
#import "ObjCBridge.h"
@import Input;

@interface InputManager () <InputDelegate>
@end

@implementation InputManager

+ (InputManager *)sharedInstance {
    static InputManager * sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [InputManager new];
    });
    return sharedInstance;
}

- (id)init {
    self = [super init];
    
    if (self) {
        [Input addDelegate:self];
    }
    return self;
}

- (BOOL)isMouseCursorHidden {
    return Input.isMouseCursorHidden;
}

- (void)setIsMouseCursorHidden:(BOOL)isMouseCursorHidden {
    Input.isMouseCursorHidden = isMouseCursorHidden;
}

- (CGPoint)mousePosition {
    return Input.mousePosition;
}

- (void)setMousePosition:(CGPoint)mousePosition {
    Input.mousePosition = mousePosition;
}

- (BOOL)isKeyPressed:(NSString *)key {
    return [Input isKeyPressed:key];
}

- (BOOL)isMouseButtonPressed:(NSInteger)button {
    return [Input isMouseButtonPressed:button];
}

- (void)enable {
    [Input enable];
}

- (void)disable {
    [Input disable];
}

// MARK: - InputDelegate
- (void)didMoveMouseWithOffset:(CGPoint)offset {
    callUnityObject(@"InputManager", @"didMoveMouse", [NSString stringWithFormat:@"%f,%f", offset.x, offset.y]);
}

- (void)didPressMouseButton:(enum SwiftEnum)button {
    callUnityObject(@"InputManager", @"didPressMouseButton", [NSString stringWithFormat:@"%li", (long)button]);
}

- (void)didReleaseMouseButton:(enum SwiftEnum)button {
    callUnityObject(@"InputManager", @"didReleaseMouseButton", [NSString stringWithFormat:@"%li", (long)button]);
}

- (void)didPressKeyboardKey:(NSString * _Nonnull)key {
    callUnityObject(@"InputManager", @"didPressKeyboardKey", key);
}

- (void)didReleaseKeyboardKey:(NSString * _Nonnull)key {
    callUnityObject(@"InputManager", @"didReleaseKeyboardKey", key);
}
@end

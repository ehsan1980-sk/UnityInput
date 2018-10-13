//
//  InputManager.h
//  Unity-iPhone
//
//  Created by LuzanovRoman on 26.04.2018.
//

#import <UIKit/UIKit.h>

@interface InputManager : NSObject
@property (nonatomic, assign) BOOL isMouseCursorHidden;
@property (nonatomic, assign) CGPoint mousePosition;

+ (InputManager *)sharedInstance;

- (void)enable;
- (void)disable;

- (BOOL)isKeyPressed:(NSString *)key;
- (BOOL)isMouseButtonPressed:(NSInteger)button;

@end

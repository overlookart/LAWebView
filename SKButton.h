//
//  SKButton.h
//  gamePlayKit
//
//  Created by xzh on 2018/12/10.
//  Copyright © 2018 xzh. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef enum : NSUInteger {
    SKButtonStateNormal,
    SKButtonStateSelect,
} SKButtonState;

@interface SKButton : SKSpriteNode
@property (nonatomic,assign,readonly) BOOL isHighlighted;
@property (nonatomic,assign) BOOL selected;//用来记录半自动按钮的状态
@property (nonatomic,strong,getter=titleLab) SKLabelNode *titleLab;


/**
 按钮的初始化方法，创建一个灰色按钮
 @param size 按钮的大小
 */
+(instancetype)buttonWithSize:(CGSize)size;

/**
 为按钮添加点击事件
 @param target 目标
 @param action 事件
 */
-(void)addTarget:(id)target action:(SEL)action;

/**
 设置按钮的高亮状态
 */
-(void)setHighlighted:(BOOL)highlighted;

/**
 设置按钮不同状态下的颜色
 @param color 按钮的颜色
 @param state 按钮的状态
 */
-(void)setColor:(UIColor *)color forState:(SKButtonState)state;

/**
 设置按钮不同状态下的标题
 @param title 按钮的标题
 @param state 按钮的状态
 */
-(void)setTitle:(NSString *)title forState:(SKButtonState)state;

/**
 设置按钮不同状态下的标题颜色
 @param titleColor 按钮的标题颜色
 @param state 按钮的状态
 */
-(void)setTitleColor:(UIColor *)titleColor forState:(SKButtonState)state;

/**
 设置按钮不同状态下的纹理
 @param texture 按钮的纹理
 @param state 按钮的状态
 */
-(void)setTexture:(SKTexture *)texture forState:(SKButtonState)state;
@end

NS_ASSUME_NONNULL_END

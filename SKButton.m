//
//  SKButton.m
//  gamePlayKit
//
//  Created by xzh on 2018/12/10.
//  Copyright © 2018 xzh. All rights reserved.
//

#import "SKButton.h"

@interface SKButton (){
    SKTexture *_normalTexture;
    SKTexture *_selectTexture;
    
    UIColor *_normalColor;
    UIColor *_selectColor;
    
    NSString *_normalTitle;
    NSString *_selectTitle;
    
    UIColor *_normalTitleColor;
    UIColor *_selectTitleColor;
    
    id _target;
    SEL _action;
}
@end

@implementation SKButton

+(instancetype)buttonWithSize:(CGSize)size{
    SKButton *button = [[SKButton alloc] initWithColor:[UIColor grayColor] size:size];
    if (button) {
        
    }
    return button;
}

-(instancetype)initWithColor:(UIColor *)color size:(CGSize)size{
    self = [super initWithColor:color size:size];
    if (self) {
        _normalColor = color;
        _selectColor = [UIColor blackColor];
        [self setUserInteractionEnabled:YES];
        [self.titleLab setPosition:CGPointZero];
        [self addChild:self.titleLab];
    }
    return self;
}


-(SKLabelNode *)titleLab{
    if (!_titleLab) {
        _titleLab = [[SKLabelNode alloc] init];
        [_titleLab setVerticalAlignmentMode:SKLabelVerticalAlignmentModeCenter];
        [_titleLab setHorizontalAlignmentMode:SKLabelHorizontalAlignmentModeCenter];
    }
    return _titleLab;
}

-(void)setColor:(UIColor *)color forState:(SKButtonState)state{
    switch (state) {
        case SKButtonStateNormal:{
            _normalColor = color;
            [self setColor:_normalColor];
            _selectColor = color;
        }break;
        case SKButtonStateSelect:{
            _selectColor = color;
        }break;
        default:
            break;
    }
}

-(void)setTitle:(NSString *)title forState:(SKButtonState)state{
    switch (state) {
        case SKButtonStateNormal:{
            _normalTitle = title;
            [self.titleLab setText:title];
            _selectTitle = title;
        }break;
        case SKButtonStateSelect:{
            _selectTitle = title;
        }break;
        default:
            break;
    }
}

-(void)setTitleColor:(UIColor *)titleColor forState:(SKButtonState)state{
    switch (state) {
        case SKButtonStateNormal:{
            _normalTitleColor = titleColor;
            [self.titleLab setFontColor:_normalTitleColor];
            _selectTitleColor = titleColor;
        }break;
        case SKButtonStateSelect:{
            _selectTitleColor = titleColor;
        }break;
        default:
            break;
    }
}

-(void)setTexture:(SKTexture *)texture forState:(SKButtonState)state{
    switch (state) {
        case SKButtonStateNormal:{
            _normalTexture = texture;
            [self setTexture:_normalTexture];
        }break;
        case SKButtonStateSelect:{
            _selectTexture = texture;
        }break;
        default:
            break;
    }
}


-(void)addTarget:(id)target action:(SEL)action{
    _target = target;
    _action = action;
}

-(void)setHighlighted:(BOOL)highlighted{
    _isHighlighted = highlighted;
    [self buttonStateAction:NO];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    _isHighlighted = YES;
    [self buttonStateAction:YES];
//    NSLog(@"SKButton_touchesBegan");

}
-(void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
//    NSLog(@"SKButton_touchesMoved");
}

-(void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
//    NSLog(@"SKButton_touchesCancelled");
}

-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
//    NSLog(@"SKButton_touchesEnded");
    _isHighlighted = NO;
    [self buttonStateAction:YES];
    [self targetPerformSelector];
}

-(void)buttonStateAction:(BOOL)animation{
    UIColor *titleColor = _isHighlighted ? _selectTitleColor : _normalTitleColor;
    [self.titleLab setFontColor:titleColor];
    NSString *title = _isHighlighted ? _selectTitle : _normalTitle;
    [self.titleLab setText:title];
    
    if (_selectTexture && _normalTexture) {
        SKTexture *texture = _isHighlighted ? _selectTexture : _normalTexture;
        [self setTexture:texture];
    }
    
    if (animation) {
        [self removeAllActions];
        CGFloat scaleValue = _isHighlighted ? 0.99 : 1.01;
        SKAction *scaleAction = [SKAction scaleBy:scaleValue duration:0.1];
        CGFloat colorBlendFactor = _isHighlighted ? 0.65 : 0.0;
        UIColor *color = _isHighlighted ? _selectColor : _normalColor;
        if (_normalTexture && _selectTexture) {
            color = _normalColor;
            colorBlendFactor = 0.0;
        }
        SKAction *colorAction = [SKAction colorizeWithColor:color colorBlendFactor:colorBlendFactor duration:0.1];
        [self runAction:[SKAction group:@[scaleAction,colorAction]]];
    }else{
        UIColor *color = _isHighlighted ? _selectColor : _normalColor;
        [self setColor:color];
    }
    
}

-(void)targetPerformSelector{
//[_target performSelector:_action];
//PerformSelector may cause a leak because its selector is unknown
    if (!_target) {
        return;
    }
    IMP imp = [_target methodForSelector:_action];
    void (*func)(id, SEL) = (void *)imp;
    func(_target, _action);
}

-(BOOL)containsTouches:(NSSet<UITouch *> *)touches{
    if (!self.scene) {
        NSLog(@"button 没有加到场景上");
        return NO;
    }
    for (UITouch *touch in touches) {
        CGPoint touchPoint = [touch locationInNode:self.scene];
        SKNode *touchedNode = [self.scene nodeAtPoint:touchPoint];
        return touchedNode == self || [touchedNode inParentHierarchy:self];
    }
    return NO;
}
@end

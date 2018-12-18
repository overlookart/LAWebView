//
//  AnimationUtils.h
//  gamePlayKit
//
//  Created by xzh on 2018/12/18.
//  Copyright © 2018 xzh. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <SpriteKit/SpriteKit.h>
NS_ASSUME_NONNULL_BEGIN

typedef enum : NSUInteger {
    UP,            //上
    RIGHT_UP,      //右上
    RIGHT,         //右
    RIGHT_DOWN,    //右下
    DOWN,          //下
    LEFT_DOWN,     //左下
    LEFT,          //左
    LEFT_UP,       //左上
    NO_DIRECTION,  //没方向
} AnimationDirection;


@interface AnimationUtils : NSObject
+(SKAction *)animateActionWithAtlasNamed:(NSString *)atlasNamed Direction:(AnimationDirection)direction;
@end

NS_ASSUME_NONNULL_END

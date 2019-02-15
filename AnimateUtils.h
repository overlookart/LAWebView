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

///从纹理集生成纹理动画

typedef enum : NSUInteger {
    NO_DIRECTION,  //没方向
    UP,            //上
    RIGHT_UP,      //右上
    RIGHT,         //右
    RIGHT_DOWN,    //右下
    DOWN,          //下
    LEFT_DOWN,     //左下
    LEFT,          //左
    LEFT_UP,       //左上
} AnimateDirection;


@interface AnimateUtils : NSObject


+(SKAction *)animateActionWithAtlasNamed:(NSString *)atlasNamed Direction:(AnimateDirection)direction;
@end

NS_ASSUME_NONNULL_END

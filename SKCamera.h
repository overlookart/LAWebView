//
//  SKCamera.h
//  gamePlayKit
//
//  Created by xzh on 2018/12/13.
//  Copyright © 2018 xzh. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SKCamera : SKCameraNode

/**
 执行一个抖动效果
 @param direction 0-横向抖动，1-纵向抖动 ，默认为0
 @param extent 抖动幅度
 */
-(void)runShakeActionWithDirection:(int)direction extent:(CGFloat)extent;

@end

NS_ASSUME_NONNULL_END

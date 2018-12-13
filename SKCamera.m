//
//  SKCamera.m
//  gamePlayKit
//
//  Created by xzh on 2018/12/13.
//  Copyright © 2018 xzh. All rights reserved.
//

#import "SKCamera.h"

@implementation SKCamera
-(void)runShakeActionWithDirection:(int)direction extent:(CGFloat)extent{
    int expandX,expandY,reduceX,reduceY;
    if (direction) {
        expandX = 0;
        reduceX = 0;
        expandY = extent;
        reduceY = -extent;
    }else{
        expandX = extent;
        reduceX = -extent;
        expandY = 0;
        reduceY = 0;
    }
    SKAction *expand1 = [SKAction moveByX:expandX y:expandY duration:0.05];
    SKAction *reduce2 = [SKAction moveByX:reduceX y:reduceY duration:0.05];
    SKAction *expand3 = [SKAction moveByX:expandX/3.0*2 y:expandY/3.0*2 duration:0.05];
    SKAction *reduce4 = [SKAction moveByX:reduceX/3.0*2 y:reduceY/3.0*2 duration:0.05];
    SKAction *expand5 = [SKAction moveByX:expandX/3.0 y:expandY/3.0 duration:0.05];
    SKAction *reduce6 = [SKAction moveByX:reduceX/3.0 y:reduceY/3.0 duration:0.05];
    SKAction *group = [SKAction sequence:@[expand1,reduce2,expand3,reduce4,expand5,reduce6]];
    
//    SKAction *rep = [SKAction repeatAction:group count:3];
    
    [self runAction:group];
}
@end

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
        expandY = extend;
        reduceY = -extend;
    }else{
        expandX = extend;
        reduceX = -extend;
        expandY = 0;
        reduceY = 0;
    }
    SKAction *expand= [SKAction moveByX:expandX y:expandY duration:0.05];
    SKAction *reduce = [SKAction moveByX:reduceX y:reduceY duration:0.05];
    SKAction *group = [SKAction sequence:@[expand,reduce]];
    SKAction *rep = [SKAction repeatAction:group count:3];
    [self runAction:rep];
}
@end

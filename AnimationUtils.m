//
//  AnimationUtils.m
//  gamePlayKit
//
//  Created by xzh on 2018/12/18.
//  Copyright © 2018 xzh. All rights reserved.
//

#import "AnimationUtils.h"

@implementation AnimationUtils
+(SKAction *)animateActionWithAtlasNamed:(NSString *)atlasNamed  Direction:(AnimationDirection)direction{
    NSMutableArray<SKTexture *> *textureFrames = [NSMutableArray array];
    SKTextureAtlas *textureAtlas = [SKTextureAtlas atlasNamed:atlasNamed];
    NSString *textureName = [atlasNamed stringByAppendingString:@"_%d_%d_%d"];
    for (int i = 0; i<textureAtlas.textureNames.count; i++) {
        int roleid = 0;
        NSString *texturename = [NSString stringWithFormat:textureName,roleid,direction,i];
        SKTexture *texture = [textureAtlas textureNamed:texturename];
        if (texture) {
            NSLog(@"%@",texture.description);
            if ([texture.description rangeOfString:atlasNamed].location == NSNotFound) {
                break;
            }
            [textureFrames addObject:texture];
        }else{
            break;
        }
    }
    SKAction *action = [SKAction animateWithTextures:textureFrames timePerFrame:1.0/(textureFrames.count+1) resize:YES restore:NO];
    return action;
}
@end

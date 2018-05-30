//
//  OverScrollHelper.m
//  GridView
//
//  Created by ryan on 2018/5/30.
//

#import "OverScrollHelper.h"

@implementation OverScrollHelper {
    
    CGPoint _lastPanPoint; /// This is to prevent using setTranslation which resets velocity
    
    NSTimeInterval _decelerationLastTime;
    CADisplayLink  *_decelerationDisplayLink;
    CGPoint _decelerationVelocity;

}


- (void)stopDeceleration {
    if (_decelerationDisplayLink != nil)
    {
        [_decelerationDisplayLink removeFromRunLoop:NSRunLoop.mainRunLoop forMode:NSRunLoopCommonModes];
        _decelerationDisplayLink = nil;
    }
}

- (void)decelerationLoop {
    _decelerationVelocity.x *= self.dragDecelerationFrictionCoef;
    _decelerationVelocity.y *= self.dragDecelerationFrictionCoef;

//    CGPoint distance = CGPointMake(_decelerationVelocity.x * timeInterval, _decelerationVelocity.y * timeInterval);

}

@end

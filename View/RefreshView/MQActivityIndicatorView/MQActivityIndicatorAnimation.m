//
//  MQActivityIndicatorAnimation.m
//  NVActivityIndicatorViewDemo
//
//  Created by yzh on 15/9/1.
//  Copyright © 2015年 Nguyen Vinh. All rights reserved.
//

#import "MQActivityIndicatorAnimation.h"

@interface MQActivityIndicatorAnimation ()

@property(nonatomic,strong) NSArray *colors;

@end

@implementation MQActivityIndicatorAnimation


-(instancetype) initWithColors:(NSArray *)colors{
    if (self = [super init]) {
        self.colors = colors;
    }
    return self;
}

-(void) setUpAnimationInLayer:(CALayer *)layer size:(CGSize)size color:(UIColor *)color{
    CGFloat circleSpacing = 8;
    CGFloat circleSize = (size.width - circleSpacing/2) / 3;
    CGFloat x = (layer.bounds.size.width - size.width) / 2;
    CGFloat y = (layer.bounds.size.height - circleSize) / 2;
    CFTimeInterval duration = 0.75;
    CFTimeInterval beginTime = CACurrentMediaTime();
    
    NSArray *beginTimes = @[@0.12, @0.24, @0.36];
    CAMediaTimingFunction *timingFunction = [CAMediaTimingFunction functionWithControlPoints:0.2 :0.68 :0.18 :1.08];
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"transform.scale"];
    // Animation
    animation.keyTimes = @[@0, @0.3, @1];
    animation.timingFunctions = @[timingFunction, timingFunction];
    animation.values = @[@1, @0.3, @1];
    animation.duration = duration;
    animation.repeatCount = HUGE;
    animation.removedOnCompletion = false;
    
    // Draw circles
    for(NSInteger i = 0; i < 3; i++ ){
        UIColor *tempColor = color;
        if ([self.colors isKindOfClass:[NSArray class]]) {
            tempColor = self.colors[i];
        }
        CALayer *circle = [self createLayerWithSize:CGSizeMake(circleSize, circleSize) color:tempColor];
        CGRect frame = CGRectMake(x + circleSize * i + circleSpacing * i,
                           y,
                           circleSize,
                                  circleSize);
        
        animation.beginTime = beginTime + [[beginTimes objectAtIndex:i] doubleValue];
        circle.frame = frame;
        [circle addAnimation:animation forKey:@"animation"];
        [layer addSublayer:circle];
    }

}

-(CALayer *) createLayerWithSize:(CGSize) size color:(UIColor *) color{
    CAShapeLayer *layer = [[CAShapeLayer alloc] init];
    UIBezierPath *path  = [[UIBezierPath alloc] init];
    
    [path addArcWithCenter:CGPointMake(size.width/2, size.height/2) radius:size.width/2 startAngle:0 endAngle:2*M_PI clockwise:false];
    layer.fillColor       = color.CGColor;
    layer.backgroundColor = nil;
    layer.path            = path.CGPath;
    return layer;
}

@end

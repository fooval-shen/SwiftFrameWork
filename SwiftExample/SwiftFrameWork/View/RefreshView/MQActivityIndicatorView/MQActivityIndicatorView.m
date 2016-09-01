//
//  MQActivityIndicatorView.m
//  NVActivityIndicatorViewDemo
//
//  Created by yzh on 15/9/6.
//  Copyright © 2015年 Nguyen Vinh. All rights reserved.
//

#import "MQActivityIndicatorView.h"
#import "MQActivityIndicatorAnimation.h"

@interface MQActivityIndicatorView ()

@property(nonatomic,strong) UIColor *color;

@property(nonatomic,strong) NSArray *colors;

@property(nonatomic,assign) BOOL hidesWhenStopped;

@property(nonatomic,assign) BOOL animating;

@property(nonatomic,assign) CGSize size;

@end

@implementation MQActivityIndicatorView

-(instancetype) initWithCoder:(nonnull NSCoder *)aDecoder{
    if (self = [super initWithCoder:aDecoder]) {
        self.color = [UIColor whiteColor];
        self.size = CGSizeMake(30, 30);
    }
    return self;
}

-(instancetype) initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.color = [UIColor whiteColor];
        self.size = CGSizeMake(30,30);
    }
    return self;
}

-(void) startAnimation{
    if (self.hidesWhenStopped && self.hidden) {
        self.hidden = NO;
    }
    if (self.layer.sublayers == nil) {
        [self setUpAnimation];
    }
    self.layer.speed = 1;
    self.animating = YES;
}

-(void) stopAnimation{
    self.layer.speed = 0;
    self.animating = NO;
    if (self.hidesWhenStopped && !self.hidden) {
        self.hidden = YES;
    }
}

-(void) setUpAnimation{
    MQActivityIndicatorAnimation *animation = [[MQActivityIndicatorAnimation alloc] initWithColors:@[[self rgbColor:0xFF1D84],[self rgbColor:0xFFA800],[self rgbColor:0x909090]]];
   
    [animation setUpAnimationInLayer:self.layer size:self.size color:self.color];
}

-(UIColor *)rgbColor:(NSUInteger)rgbValue {
    return [UIColor colorWithRed:((rgbValue & 0xFF0000)>>16)/255.0 green:((rgbValue & 0xFF0000)>>8)/255.0 blue:(rgbValue & 0xFF0000)/255.0 alpha:1];
}

@end

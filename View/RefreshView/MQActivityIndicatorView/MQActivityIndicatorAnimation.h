//
//  MQActivityIndicatorAnimation.h
//  NVActivityIndicatorViewDemo
//
//  Created by yzh on 15/9/1.
//  Copyright © 2015年 Nguyen Vinh. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MQActivityIndicatorAnimation: NSObject

-(instancetype) initWithColors:(NSArray *) colors;

-(void) setUpAnimationInLayer:(CALayer *)layer size:(CGSize)size color:(UIColor *)color;

@end

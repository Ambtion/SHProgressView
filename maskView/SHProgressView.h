//
//  SHProgressView.h
//  maskView
//
//  Created by sohu on 13-8-27.
//  Copyright (c) 2013年 sohu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SHProgressView : UIView
{
    UIImageView * drawLineView;
}

@property (nonatomic, strong) UIColor *progressBackgroundColor;
@property(assign,nonatomic)CGFloat percentage;

- (id)initWithCenter:(CGPoint)center radius:(CGFloat)radius lineWidth:(CGFloat)lineWidth  progressBackgroundColor:(UIColor *)progressBackgroundColor percentage:(CGFloat)percentage;
- (void)startScaning;
- (void)stopScaning;
- (BOOL)isStartScaning;
- (void)setPercentage:(CGFloat)percentage WithAnimation:(BOOL)animation;
@end

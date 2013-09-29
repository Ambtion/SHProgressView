//
//  SHProgressView.m
//  maskView
//
//  Created by sohu on 13-8-27.
//  Copyright (c) 2013年 sohu. All rights reserved.
//

#import "SHProgressView.h"
#import <QuartzCore/QuartzCore.h>

#define CGPointCenterPointOfRect(rect) CGPointMake(rect.origin.x + rect.size.width / 2.0f, rect.origin.y + rect.size.height / 2.0f)


@interface SHProgressView()
{
    BOOL _isUp;
    NSTimer * _sacningtimer;
    NSTimer * _percentageTimer;
    CGFloat  _finalPercentage;
}
@property CGPoint center;
@property CGFloat radius;
@property CGFloat lineWidth;
@property CGFloat percenLine;

@end

@implementation SHProgressView
@synthesize percentage = _percentage,center = _center,radius = _radius,lineWidth = _lineWidth;
@synthesize progressBackgroundColor = _progressBackgroundColor;

- (id)initWithCenter:(CGPoint)center radius:(CGFloat)radius lineWidth:(CGFloat)lineWidth
progressBackgroundColor:(UIColor *)progressBackgroundColor percentage:(CGFloat)percentage
{
    CGRect rect = CGRectMake(center.x - radius, center.y - radius, 2 * radius, 2 * radius);
    self = [super initWithFrame:rect];
    if (self) {
        self.backgroundColor = [UIColor colorWithRed:236.f/255 green:240.f/255 blue:241.f/255 alpha:1.f];
        self.radius = radius;
        self.lineWidth = lineWidth;
        self.percentage = percentage;
        self.progressBackgroundColor = progressBackgroundColor;
        self.layer.cornerRadius = self.radius;
        self.layer.borderColor = [[UIColor whiteColor] CGColor];
        self.layer.borderWidth = 1.f;
        self.clipsToBounds = YES;
        self.percenLine = 0.f;
        self.percentage = 0.f;
        _isUp = YES;
    }
    return self;
}

- (void)drawRect:(CGRect)rect
{
    [self drawBackground:rect];
    [self drawProgress];
    [self drawLineinside];
    [self drawPhone];
    [self drawPhoneperline];

}
- (void)drawBackground:(CGRect)rect
{
    CGFloat radiusMinusLineWidth = self.radius - self.lineWidth/2.f;
    UIBezierPath *progressCircle = [UIBezierPath bezierPathWithArcCenter:CGPointCenterPointOfRect(rect)
                                                                  radius:radiusMinusLineWidth
                                                              startAngle:0
                                                                endAngle:2 * M_PI
                                                               clockwise:NO];
    [self.progressBackgroundColor setStroke];
    progressCircle.lineWidth = self.lineWidth;
    [progressCircle stroke];
    
}
- (void)drawProgress
{
    CGFloat radiusMinusLineWidth = self.radius - self.lineWidth / 2;
    CGFloat startAngle = - M_PI / 2;
    CGFloat endAngle = startAngle + (1 - self.percentage * 2) * M_PI;
    endAngle = startAngle + (1- self.percentage) * 2 * M_PI;
    if (self.percentage != 0 && self.percentage != 1)
        [self drawProgressArcWithStartAngle:startAngle endAngle:endAngle radius:radiusMinusLineWidth];
}

- (void)drawProgressArcWithStartAngle:(CGFloat)startAngle endAngle:(CGFloat)endAngle radius:(CGFloat)radius
{
    [self.layer.sublayers makeObjectsPerformSelector:@selector(removeFromSuperlayer)];
    CAShapeLayer * gradientMask = [CAShapeLayer layer];
    gradientMask.fillColor = [[UIColor clearColor] CGColor];
    gradientMask.strokeColor = [[UIColor blackColor] CGColor];
    
    gradientMask.lineWidth = self.lineWidth;
    gradientMask.frame = self.bounds;
    CGMutablePathRef t = CGPathCreateMutable();
    CGPathAddArc(t, NULL,CGPointCenterPointOfRect(self.bounds).x,CGPointCenterPointOfRect(self.bounds).x, radius,startAngle, endAngle,YES);
    gradientMask.path = t;
    CAGradientLayer * gradientLayer = [CAGradientLayer layer];
    gradientLayer.frame = self.bounds;
    gradientLayer.contents = (id)[[UIImage imageNamed:@"progess_wheel_bg.png"] CGImage];
    [gradientLayer setMask:gradientMask];
    [self.layer addSublayer:gradientLayer];
    
   
    //绘制内区域
    
    CGFloat radiusMinusLineWidth = (self.radius - self.lineWidth - 1)/2.f  ;
    UIBezierPath *progressCircle = [UIBezierPath bezierPathWithArcCenter:CGPointCenterPointOfRect(self.bounds)
                                                                  radius:radiusMinusLineWidth
                                                              startAngle:startAngle                                                                endAngle:endAngle
                                                               clockwise:NO];
    [[UIColor whiteColor] setStroke];
    progressCircle.lineWidth = radiusMinusLineWidth * 2;
    [progressCircle stroke];
  
}
- (void)drawLineinside
{
    //绘制内边线
    CGFloat onlinewidth = self.radius - self.lineWidth ;
    UIBezierPath *progressWhiteCircle = [UIBezierPath bezierPathWithArcCenter:CGPointCenterPointOfRect(self.bounds)
                                                                       radius:onlinewidth
                                                                   startAngle:0
                                                                     endAngle:M_PI * 2
                                                                    clockwise:NO];
    [[UIColor whiteColor] setStroke];
    progressWhiteCircle.lineWidth = 1.f;
    [progressWhiteCircle stroke];

}
- (void)drawPhone
{
    CGPoint point = CGPointCenterPointOfRect(self.bounds);
    CGFloat width = 46.f;
    CGFloat heigth = 75.f;
    CGFloat cornius = 5.f;
    CGRect rect = CGRectMake(point.x - width/2.f, point.y - heigth/2.f, width, heigth);
    UIBezierPath * path = [UIBezierPath bezierPathWithRoundedRect:rect cornerRadius:cornius];
    [[UIColor colorWithRed:127.f/255 green:140.f/255 blue:141.f/255 alpha:1] setFill];
    [path fill];
   
    CGFloat width2 = 36.f;
    CGFloat heigth2 = 55.f;
    CGFloat cornius2 = 5.f;
    CGRect rect2 = CGRectMake(point.x - width2/2.f, point.y - heigth/2.f + 5, width2, heigth2);
    UIBezierPath * path2 = [UIBezierPath bezierPathWithRoundedRect:rect2 cornerRadius:cornius2];
    [[UIColor colorWithRed:236.f/255 green:240.f/255 blue:241.f/255 alpha:1] setFill];
    [path2 fill];
    
    CGPoint arcCenter = CGPointMake(CGRectGetMidX(rect2), CGRectGetHeight(rect) + rect.origin.y - 8);
    UIBezierPath * roundPath = [UIBezierPath bezierPathWithArcCenter:arcCenter radius:3.f startAngle:0 endAngle:M_PI * 2 clockwise:NO];
    [[UIColor colorWithRed:236.f/255 green:240.f/255 blue:241.f/255 alpha:1] setFill];
    [roundPath fill];
}

#pragma mark - percentage
- (void)setPercentage:(CGFloat)percentage WithAnimation:(BOOL)animation
{
    if (animation) {
        _finalPercentage = percentage;
        _percentageTimer = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(setPercentageOneStep) userInfo:nil repeats:YES];
    }else{
        self.percentage = percentage;
    }
}
- (void)setPercentageOneStep
{
    if (self.percentage < _finalPercentage) {
        self.percentage += 0.01;
    }else{
        [_percentageTimer invalidate];
    }
}
#pragma mark  scaning
- (void)startScaning
{
    _sacningtimer = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(runOneStep) userInfo:nil repeats:YES];
    
}
- (void)stopScaning
{
    [_sacningtimer invalidate];
    [self setNeedsDisplay];
}
- (BOOL)isStartScaning
{
    return [_sacningtimer isValid];
}
- (void)runOneStep
{
    CGFloat onestep = 0.01;
    if (_isUp) {
        self.percenLine += onestep;
    }else{
        self.percenLine -= onestep;
    }
    if (self.percenLine >= 1) {
        self.percenLine = 1;
        _isUp = NO;
    }else if(self.percenLine <= 0.0){
        self.percenLine = 0.f;
        _isUp = YES;
    }
    [self setNeedsDisplay];
}
- (void)drawPhoneperline
{
    CGRect  rect = CGRectMake(85.f, 70.5, 36, 55.f);
    rect.origin.y += 5.f;
    rect.size.height -= 10.f;
    CGRect lineRect = rect;
    lineRect.size.height = 3.f;
    lineRect.origin.y += self.percenLine * (rect.size.height - 4);

    CGContextSetFillColorWithColor(UIGraphicsGetCurrentContext(), [[UIColor colorWithRed:23.f/255 green:152.f/255 blue:255.f/255 alpha:1] CGColor]);
    CGContextAddRect(UIGraphicsGetCurrentContext(), lineRect);
    CGContextFillPath(UIGraphicsGetCurrentContext());
}

#pragma mark - Public
- (void)setProgressBackgroundColor:(UIColor *)progressBackgroundColor
{
    _progressBackgroundColor = progressBackgroundColor;
    [self setNeedsDisplay];
}

- (void)setPercentage:(CGFloat)percentage
{
    _percentage = fminf(fmax(percentage, 0), 1);
    [self setNeedsDisplay];
}
@end

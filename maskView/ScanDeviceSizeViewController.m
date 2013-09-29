//
//  ViewController.m
//  maskView
//
//  Created by sohu on 13-8-26.
//  Copyright (c) 2013年 sohu. All rights reserved.
//

#import "ScanDeviceSizeViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "SHProgressView.h"

@interface ScanDeviceSizeViewController ()
@property (strong,nonatomic)SHProgressView * progressView;
@property (strong,nonatomic)UIView * actionView;
@property (strong,nonatomic)UILabel * titleLabel;
@property (strong,nonatomic)UILabel * subLabel;
@property (strong,nonatomic)UILabel * photoNumber;
@property (strong,nonatomic)UILabel * sizeNumber;
@property (strong,nonatomic)UILabel * sizeTitle;
@property (strong,nonatomic)UILabel * unitLabel;
@end

@implementation ScanDeviceSizeViewController
@synthesize progressView = _progressView;
@synthesize actionView = _actionView;
@synthesize titleLabel = _titleLabel;
@synthesize subLabel = _subLabel;
@synthesize sizeNumber = _sizeNumber;
@synthesize sizeTitle = _sizeTitle;
@synthesize unitLabel = _unitLabel;

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithRed:236.f/255 green:240.f/255 blue:241.f/255 alpha:1];
    [self addProgressView];
    [self addTitleLabel];
    [self addActionView];
    
}
- (void)addProgressView
{
    self.progressView = [[SHProgressView alloc] initWithCenter:CGPointMake(160, 123) radius:103 lineWidth:20 progressBackgroundColor:[UIColor colorWithRed:210.f/255 green:210.f/255 blue:210.f/255 alpha:1.f] percentage:0.0];
    [self.progressView startScaning];
    [self.view addSubview:self.progressView];
    double delayInSeconds = 2.0;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        [self.progressView setPercentage:0.8 WithAnimation:YES];
    });
}

- (void)addTitleLabel
{
    _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, self.progressView.frame.origin.y + self.progressView.frame.size.height + 20, 300, 20)];
    _titleLabel.text  = @"相册数据正在检查...";
    _titleLabel.textAlignment  = 12.f;
    _titleLabel.textAlignment = UITextAlignmentCenter;
    _titleLabel.textColor = [UIColor colorWithRed:44.f/255 green:62.f/255 blue:80.f/255 alpha:1.f];
    _titleLabel.backgroundColor = [UIColor clearColor];
    [self.view addSubview:_titleLabel];
    
    _subLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, _titleLabel.frame.origin.y + _titleLabel.frame.size.height, 300, 20)];
    _subLabel.textAlignment  = 12.f;
    _subLabel.textAlignment = UITextAlignmentCenter;
    _subLabel.textColor = [UIColor colorWithRed:44.f/255 green:62.f/255 blue:80.f/255 alpha:1.f];
    _subLabel.backgroundColor = [UIColor clearColor];
    [self.view addSubview:_subLabel];
}

- (void)addActionView
{
    self.actionView = [[UIView alloc] initWithFrame:CGRectMake(0, self.view.bounds.size.height - 159, 320, 159)];
    self.actionView.autoresizingMask = UIViewAutoresizingFlexibleTopMargin;
    UIView * lineView = [[UIView alloc] initWithFrame:CGRectMake(20, 0, 280, 1)];
    lineView.backgroundColor = [UIColor colorWithRed:44.f/255 green:62.f/255 blue:80.f/255 alpha:1.f];
    [self.actionView addSubview:lineView];
    self.actionView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:self.actionView];
    [self addPhotoNumberLabel];
    [self addSizeNumberLabel];
    [self addAutonUploadButton];
    [self addunAutoUploadButton];
}
- (void)addPhotoNumberLabel
{
    UILabel * title = [[UILabel alloc] initWithFrame:CGRectMake(20, 10, 140, 14)];
    title.textAlignment  = 12.f;
    title.textAlignment = UITextAlignmentCenter;
    title.textColor = [UIColor colorWithRed:44.f/255 green:62.f/255 blue:80.f/255 alpha:1.f];
    title.backgroundColor = [UIColor clearColor];
    title.text = @"照片数量";
    title.font = [UIFont systemFontOfSize:12.f];
    [self.actionView addSubview:title];
    self.photoNumber = [[UILabel alloc] initWithFrame:CGRectMake(title.frame.origin.x, title.frame.size.height + title.frame.origin.y, 140, 35)];
    self.photoNumber.font  = [UIFont fontWithName:@"SinhalaSangamMN" size:45.f];

    self.photoNumber.textAlignment = UITextAlignmentCenter;
    self.photoNumber.textColor = [UIColor colorWithRed:44.f/255 green:62.f/255 blue:80.f/255 alpha:1.f];
    self.photoNumber.backgroundColor = [UIColor clearColor];
    self.photoNumber.text = @"25";
    [self.actionView addSubview:self.photoNumber];

}
- (void)addSizeNumberLabel
{
    
    _sizeTitle = [[UILabel alloc] initWithFrame:CGRectMake(20 + 140, 10, 140, 14)];
    _sizeTitle.textAlignment  = 12.f;
    _sizeTitle.textAlignment = UITextAlignmentCenter;
    _sizeTitle.textColor = [UIColor colorWithRed:44.f/255 green:62.f/255 blue:80.f/255 alpha:1.f];
    _sizeTitle.backgroundColor = [UIColor clearColor];
    _sizeTitle.font = [UIFont systemFontOfSize:12.f];
    _sizeTitle.text = @"占用空间";
    [self.actionView addSubview:_sizeTitle];
    self.sizeNumber = [[UILabel alloc] initWithFrame:CGRectMake(_sizeTitle.frame.origin.x, _sizeTitle.frame.size.height + _sizeTitle.frame.origin.y, 140, 35)];
    self.sizeNumber.backgroundColor = [UIColor clearColor];
    self.sizeNumber.font  = [UIFont fontWithName:@"SinhalaSangamMN" size:45.f];
//    self.sizeNumber.font = [UIFont systemFontOfSize:32.f];
    self.sizeNumber.textAlignment = UITextAlignmentCenter;
    self.sizeNumber.textColor = [UIColor colorWithRed:44.f/255 green:62.f/255 blue:80.f/255 alpha:1.f];
    [self.actionView addSubview:self.sizeNumber];
    
    _unitLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    _unitLabel.text = @"G";
    _unitLabel.font  = [UIFont systemFontOfSize:12.f];
    _unitLabel.textColor = [UIColor colorWithRed:44.f/255 green:62.f/255 blue:80.f/255 alpha:1.f];
    _unitLabel.backgroundColor = [UIColor clearColor];
    [self.actionView addSubview:_unitLabel];
    [self setSizeNumberText:@"123"];
    
}
- (void)setSizeNumberText:(NSString *)text
{
    self.sizeNumber.text = text;
    [self.sizeNumber sizeToFit];
    self.photoNumber.center = CGPointMake(self.photoNumber.center.x, self.sizeNumber.center.y);
    self.sizeNumber.center = CGPointMake(_sizeTitle.center.x,self.sizeNumber.center.y);
    _unitLabel.frame = CGRectMake(_sizeNumber.frame.origin.x + _sizeNumber.frame.size.width, _sizeNumber.frame.origin.y + 10, 20, 15);
}
- (void)addAutonUploadButton
{
    UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(20, self.sizeNumber.frame.origin.y + self.sizeNumber.frame.size.height + 2, 280, 50.f);
    button.tag = 100;
    [button setImage:[UIImage imageNamed:@"autouploadButton.png"] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.actionView addSubview:button];
}

- (void)addunAutoUploadButton
{
    UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(20, self.sizeNumber.frame.origin.y + self.sizeNumber.frame.size.height + 60, 280, 20);
    button.tag = 200;
    [button setTitleColor:[UIColor colorWithRed:149.f/255 green:165.f/255 blue:166.f/255 alpha:1] forState:UIControlStateNormal];
    [button setTitle:@"手动选择备份" forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:12.f];
    [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.actionView addSubview:button];
}

- (void)buttonClick:(UIButton *)button
{
    NSLog(@"tttt");
}
@end

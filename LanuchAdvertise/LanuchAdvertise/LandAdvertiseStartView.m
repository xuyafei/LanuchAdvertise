//
//  LandAdvertiseStartView.m
//  LanuchAdvertise
//
//  Created by polycom on 2017/6/1.
//  Copyright © 2017年 com.polycom. All rights reserved.
//

#import "LandAdvertiseStartView.h"
#import "LaunchClickImageView.h"
#import "GetLaunchImage.h"

@interface LandAdvertiseStartView()

@property(nonatomic, strong) UIImageView *backgroundImageViewDefault;
@property(nonatomic, strong) LaunchClickImageView *backgoundImageView;
@property(nonatomic, strong) UIButton *timeButton;
@property(nonatomic, assign) BOOL isImageDownLoaded;

@property(nonatomic, copy) void(^imageClickAction)();
@property(nonatomic, copy) void(^adsViewCompletion)(LandAdvertiseStartView *startView);

@property(nonatomic, strong) NSTimer *timer;
@property(nonatomic, assign) NSUInteger timeNum;

@end

@implementation LandAdvertiseStartView

- (instancetype)initWithBackGroundImage:(NSString *)imageUrl withClickImageAction:(void(^)())action {
    self = [super initWithFrame:[UIScreen mainScreen].bounds];
    if(self) {
        _isImageDownLoaded = NO;
        _imageClickAction = action;
        
        _backgroundImageViewDefault = [[UIImageView alloc] initWithFrame:[UIScreen mainScreen].bounds];
        _backgroundImageViewDefault.contentMode = UIViewContentModeScaleToFill;
        [self addSubview:_backgroundImageViewDefault];
        _backgroundImageViewDefault.image = [GetLaunchImage getTheLaunchImage];
        
        _backgoundImageView = [[LaunchClickImageView alloc] initWithFrame:[UIScreen mainScreen].bounds];
        _backgoundImageView.alpha = 0.0;
        _backgoundImageView.contentMode = UIViewContentModeScaleToFill;
        [_backgoundImageView addTarget:self action:@selector(imageClick:)];
        [self addSubview:_backgoundImageView];
        
        _timeButton = [[UIButton alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width - 13 - 52, 20, 52, 25)];
        _timeButton.layer.cornerRadius = 25/2.0f;
        [_timeButton setClipsToBounds:YES];
        _timeButton.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.3];
        _timeButton.titleLabel.font = [UIFont systemFontOfSize:13];
        [_timeButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_timeButton addTarget:self action:@selector(jumpClick:) forControlEvents:UIControlEventTouchUpInside];
        [_backgoundImageView addSubview:_timeButton];
    }
    
    return self;
}
@end

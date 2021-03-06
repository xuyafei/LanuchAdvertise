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
#import "LanuchAdvertiseDataManager.h"

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

- (instancetype)initWithBackGroundImage:(NSString *)imageUrl withImageFilePath:(NSString *)filePath
                   withClickImageAction:(void(^)())action {
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
        [_backgoundImageView addTarget:self action:@selector(_ImageClick:)];
        _backgoundImageView.image = [UIImage imageWithContentsOfFile:filePath];
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

- (void)removeMyAdvertiseView {
    if(_timer.isValid) {
        [_timer invalidate];
    }
    _timer = nil;
    
    __weak typeof(self) weakSelf = self;
    [UIView animateWithDuration:0.7 delay:0.0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        __strong typeof(weakSelf) strongSelf = weakSelf;
        strongSelf.backgoundImageView.alpha = 0.0;
        [strongSelf.backgoundImageView setFrame:CGRectMake(-[UIScreen mainScreen].bounds.size.width/20, -[UIScreen mainScreen].bounds.size.height/20, 1.1*[UIScreen mainScreen].bounds.size.width, 1.1*[UIScreen mainScreen].bounds.size.height)];
        strongSelf.alpha = 0.0;
    } completion:^(BOOL finished) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        [strongSelf removeFromSuperview];
        if(_adsViewCompletion) {
            _adsViewCompletion(strongSelf);
        }
    }];
}


+ (instancetype)startAdvertiseViewWithBgImageUrl:(NSString *)imageUrl withImageFilePath:(NSString *)filePath withClickImageAciton:(void (^)())action {
    return [[self alloc] initWithBackGroundImage:imageUrl withImageFilePath:filePath withClickImageAction:action];
}

- (void)startAnimationTime:(NSUInteger)time withCompletionBlock:(void (^)(LandAdvertiseStartView *))completionHandler {
    _timeNum = time;
    _adsViewCompletion = completionHandler;
    
    [[UIApplication sharedApplication].keyWindow addSubview:self];
    [[UIApplication sharedApplication].keyWindow bringSubviewToFront:self];
    [UIView animateWithDuration:0.5 animations:^{
        _backgoundImageView.alpha = 1;
    }];
    
    [_timeButton setTitle:[NSString stringWithFormat:@"跳过%zd",_timeNum] forState:UIControlStateNormal];
    _timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timerAction:) userInfo:nil repeats:YES];
}

- (void)_ImageClick:(UIImageView *)sender {
    if(self.imageClickAction) {
        self.imageClickAction();
        [self removeMyAdvertiseView];
    }
}

- (void)jumpClick:(id)sender {
    [self removeMyAdvertiseView];
}

- (void)timerAction:(NSTimer *)timer {
    if(_timeNum == 0) {
        [self removeMyAdvertiseView];
        return;
    }
    _timeNum --;
    
    [_timeButton setTitle:[NSString stringWithFormat:@"跳过%zd",_timeNum] forState:UIControlStateNormal];
}

@end

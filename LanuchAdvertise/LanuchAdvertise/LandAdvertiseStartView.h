//
//  LandAdvertiseStartView.h
//  LanuchAdvertise
//
//  Created by polycom on 2017/6/1.
//  Copyright © 2017年 com.polycom. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LandAdvertiseStartView : UIView

+ (instancetype)startAdvertiseViewWithBgImageUrl:(NSString *)imageUrl
                            withClickImageAciton:(void(^)())action;

- (void)startAnimationTime:(NSUInteger)time
       withCompletionBlock:(void(^)(LandAdvertiseStartView *advertiseView))completionHandler;

- (void)downloadStartImage:(NSString *)imageUrl;


@end
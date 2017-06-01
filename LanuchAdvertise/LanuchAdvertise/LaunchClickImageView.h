//
//  LaunchClickImageView.h
//  LanuchAdvertise
//
//  Created by polycom on 2017/6/1.
//  Copyright © 2017年 com.polycom. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LaunchClickImageView : UIImageView

@property (nonatomic, assign) id target;
@property (nonatomic, assign) SEL action;

- (void)addTarget:(id)target action:(SEL)action;

@end

//
//  LanuchAdvertiseDataManager.h
//  LanuchAdvertise
//
//  Created by polycom on 2017/6/2.
//  Copyright © 2017年 com.polycom. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface LanuchAdvertiseDataManager : NSObject

@property(nonatomic, strong) NSArray *resultArray;
@property(nonatomic, strong) NSString *documentPath;
@property(nonatomic, strong) UIImageView *splashIamgeView;
@property(nonatomic, copy)   NSString *imageUrl;

+ (void)downloadAdvertiseImageWithUrl:(NSString *)imageUrl iamgeName:(NSString *)imageName imageLinkUrl:(NSString *)imageLinkUrl imageDeadLine:(NSString *)imageDeadLine;

+ (BOOL)isFileExistWithFilePath:(NSString *)filePath;

+ (void)getAdvertisingImageData;

+ (NSString *)getFilePathWithImageName:(NSString *)imageName;

@end

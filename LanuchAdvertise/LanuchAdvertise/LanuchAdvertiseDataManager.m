//
//  LanuchAdvertiseDataManager.m
//  LanuchAdvertise
//
//  Created by polycom on 2017/6/2.
//  Copyright © 2017年 com.polycom. All rights reserved.
//

#import "LanuchAdvertiseDataManager.h"
#import "LandAdvertiseStartView.h"

@implementation LanuchAdvertiseDataManager

+ (BOOL)isFileExistWithFilePath:(NSString *)filePath {
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL isDirectory = NO;
    
    return [fileManager fileExistsAtPath:filePath isDirectory:&isDirectory];
}

+ (void)getAdvertisingImageData {
    NSString *imageUrl = @"http://785j3g.com1.z0.glb.clouddn.com/d659db60-f.jpg";
    NSArray *stringArr = [imageUrl componentsSeparatedByString:@"/"];
    NSString *imageName = stringArr.lastObject;
    
    NSString *filePath = [self getFilePathWithImageName:imageName];
    BOOL isExist = [self isFileExistWithFilePath:filePath];
    
    if(!isExist) {
        [self downloadAdvertiseImageWithUrl:imageUrl iamgeName:imageName];
    }
}

+ (void)downloadAdvertiseImageWithUrl:(NSString *)imageUrl iamgeName:(NSString *)imageName {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:imageUrl]];
        UIImage *image = [UIImage imageWithData:data];
        
        NSString *filePath = [self getFilePathWithImageName:imageName];
        [UIImageJPEGRepresentation(image, 0) writeToFile:filePath atomically:YES];
        if([UIImageJPEGRepresentation(image, 0) writeToFile:filePath atomically:YES]) {
            if(![imageName isEqualToString:[[NSUserDefaults standardUserDefaults] objectForKey:advertiseImageName]]) {
                [self deleteOldImage];
            }
            
            [[NSUserDefaults standardUserDefaults] setValue:imageName forKey:advertiseImageName];
           // [[NSUserDefaults standardUserDefaults] setValue:imageUrl forKey:advertiseUrl];
        } else {
            NSLog(@"保存失败");
        }
    });
}

+ (void)deleteOldImage {
    NSString *imageName = [[NSUserDefaults standardUserDefaults] valueForKey:advertiseImageName];
    
    if(imageName) {
        NSString *filePath = [self getFilePathWithImageName:imageName];
        
        NSFileManager *fileManager = [NSFileManager defaultManager];
        [fileManager removeItemAtPath:filePath error:nil];
        
        [[NSUserDefaults standardUserDefaults] setValue:@"" forKey:advertiseImageName];
        [[NSUserDefaults standardUserDefaults] setValue:@"" forKey:advertiseUrl];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
}

+ (NSString *)getFilePathWithImageName:(NSString *)imageName {
    if(imageName) {
        NSString *paths = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
        NSString *filePath = [paths stringByAppendingPathComponent:imageName];
        
        return filePath;
    }
    
    return nil;
}

@end

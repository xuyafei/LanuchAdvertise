//
//  AppDelegate.m
//  LanuchAdvertise
//
//  Created by polycom on 2017/6/1.
//  Copyright © 2017年 com.polycom. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"
#import "LanuchAdvertiseDataManager.h"
#import "LandAdvertiseStartView.h"
#import "LauchWebViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    ViewController *tempViewController = [[ViewController alloc] init];
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:tempViewController];

    self.window.rootViewController = navigationController;
    
    NSString *picUrl = @"http://785j3g.com1.z0.glb.clouddn.com/d659db60-f.jpg";
    
    NSString *filePath = [LanuchAdvertiseDataManager getFilePathWithImageName:[[NSUserDefaults standardUserDefaults] valueForKey:advertiseImageName]];
    BOOL isExist = [LanuchAdvertiseDataManager isFileExistWithFilePath:filePath];
    
    if(isExist) {
        LandAdvertiseStartView *advertiseStartView = [LandAdvertiseStartView startAdvertiseViewWithBgImageUrl:picUrl withImageFilePath:filePath withClickImageAciton:^{
            LauchWebViewController *advertiseViewController = [[LauchWebViewController alloc] init];
            advertiseViewController.title = @"这是一个广告页";
            [(UINavigationController *)self.window.rootViewController pushViewController:advertiseViewController animated:YES];
        }];
        
        [advertiseStartView startAnimationTime:3 withCompletionBlock:^(LandAdvertiseStartView *advertiseView) {
             NSLog(@"广告结束后，执行事件");
        }];
    } else {
        [LanuchAdvertiseDataManager getAdvertisingImageData];
    }
    
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end

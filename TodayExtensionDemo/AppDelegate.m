//
//  AppDelegate.m
//  TodayExtensionDemo
//
//  Created by Mr.GCY on 2018/8/9.
//  Copyright © 2018年 Mr.GCY. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"
#import "CYSubViewController.h"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
     self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
     self.window.backgroundColor = [UIColor whiteColor];
     self.window.rootViewController = [[UINavigationController alloc] initWithRootViewController:[ViewController new]];
     [self.window makeKeyAndVisible];
     return YES;
}
- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey,id> *)options {
     // 可以先回到应用首页，在跳转
     if ([url.absoluteString hasPrefix:@"TodayExtensionDemo"]) {
          if ([url.host isEqualToString:@"enterApp"]) {
               //进入APP
          }else if ([url.host isEqualToString:@"feedback"]) {
               //进入反馈
               [self jumpSubVCWithNameTitle:@"反馈"];
          }else if ([url.host isEqualToString:@"userInfo"]) {
               //进入个人用户信息
               [self jumpSubVCWithNameTitle:@"个人信息"];
          }else if ([url.host isEqualToString:@"customerService"]) {
               //进入客服
               [self jumpSubVCWithNameTitle:@"客服"];
          }else if ([url.host isEqualToString:@"set"]) {
               //打印参数
               NSLog(@"%@",url.relativePath);
               //进入设置
               [self jumpSubVCWithNameTitle:@"设置"];
          }else if ([url.host isEqualToString:@"help"]) {
               //进入帮助
               [self jumpSubVCWithNameTitle:@"帮助"];
          }
     }
     return YES;
}
-(void)jumpSubVCWithNameTitle:(NSString *)nameTitle{
     CYSubViewController * subVC = [CYSubViewController new];
     subVC.title = nameTitle;
     if ([self.window.rootViewController isKindOfClass:[UINavigationController class]]) {
          UINavigationController * nav = (UINavigationController *)self.window.rootViewController;
          [nav pushViewController:subVC animated:YES];
     }else if ([self.window.rootViewController isKindOfClass:[ViewController class]]){
          [self.window.rootViewController.navigationController pushViewController:subVC animated:YES];
     }
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

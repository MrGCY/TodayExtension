//
//  TodayViewController.m
//  TodayExtentsion
//
//  Created by Mr.GCY on 2018/8/9.
//  Copyright © 2018年 Mr.GCY. All rights reserved.
//

#import "TodayViewController.h"
#import <NotificationCenter/NotificationCenter.h>
#define NewHeight 400
@interface TodayViewController () <NCWidgetProviding>

@end

@implementation TodayViewController

- (void)viewDidLoad {
     [super viewDidLoad];
     // 将小部件展现模型设置为可展开
     if (@available(iOS 10.0, *)) {
          self.extensionContext.widgetLargestAvailableDisplayMode = NCWidgetDisplayModeExpanded;
     } else {
          // Fallback on earlier versions
     }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
     //点击跳转到APP
     [self.extensionContext openURL:[NSURL URLWithString:@"TodayExtensionDemo://touch"] completionHandler:nil];
}
- (void)widgetPerformUpdateWithCompletionHandler:(void (^)(NCUpdateResult))completionHandler {
    // Perform any setup necessary in order to update the view.
    
    // If an error is encountered, use NCUpdateResultFailed
    // If there's no update required, use NCUpdateResultNoData
    // If there's an update, use NCUpdateResultNewData

    completionHandler(NCUpdateResultNewData);
}

- (void)widgetActiveDisplayModeDidChange:(NCWidgetDisplayMode)activeDisplayMode withMaximumSize:(CGSize)maxSize  API_AVAILABLE(ios(10.0)){
     if (@available(iOS 10.0, *)) {
          if (activeDisplayMode == NCWidgetDisplayModeExpanded) {
               // 设置展开的新高度
               self.preferredContentSize = CGSizeMake(0, NewHeight);
          }else{
               self.preferredContentSize = maxSize;
          }
     } else {
          
     }
}
@end

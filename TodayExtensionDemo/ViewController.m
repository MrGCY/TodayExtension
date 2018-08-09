//
//  ViewController.m
//  TodayExtensionDemo
//
//  Created by Mr.GCY on 2018/8/9.
//  Copyright © 2018年 Mr.GCY. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
     [super viewDidLoad];
     // 存储数据
     [[[NSUserDefaults alloc] initWithSuiteName:@"group.com.mrgcy.appExtension"] setValue:@"这是共享数据" forKey:@"myShareData"];
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
     [[[NSUserDefaults alloc] initWithSuiteName:@"group.com.mrgcy.appExtension"] setValue:@"点击首页进行数据传递" forKey:@"myShareData"];
}
- (void)didReceiveMemoryWarning {
     [super didReceiveMemoryWarning];
     // Dispose of any resources that can be recreated.
}


@end

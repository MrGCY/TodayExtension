//
//  TodayItemModel.h
//  TodayExtentsion
//
//  Created by Mr.GCY on 2018/8/13.
//  Copyright © 2018年 Mr.GCY. All rights reserved.
//

#import "JSONModel.h"

@interface TodayItemModel : JSONModel
@property (nonatomic, strong) NSString * icon;
@property (nonatomic, strong) NSString * handerUrl;
@property (nonatomic, strong) NSString * title;
@end

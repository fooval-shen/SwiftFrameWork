//
//  MQRefreshHeaderView.h
//  meiqu
//
//  Created by shenfh on 15/7/3.
//  Copyright (c) 2015年 com.meiqu.com. All rights reserved.
//

#import "MJRefreshComponent.h"

@interface MQRefreshHeaderView : MJRefreshComponent
/** 创建header */
+ (instancetype)headerWithRefreshingBlock:(MJRefreshComponentRefreshingBlock)refreshingBlock;
@end

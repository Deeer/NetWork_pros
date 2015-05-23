//
//  netWorkStateTool.m
//  网络质量检测
//
//  Created by Dee on 15/5/23.
//  Copyright (c) 2015年 zjsruxxxy7. All rights reserved.
//

#import "netWorkStateTool.h"
#import "Reachability.h"

@implementation netWorkStateTool
+(BOOL)isEnableWiFi{
    
    return ([[Reachability reachabilityForLocalWiFi]currentReachabilityStatus] != NotReachable);
}
+(BOOL)isEnable3G
{
    return ([[Reachability reachabilityForInternetConnection]currentReachabilityStatus]!= NotReachable);
}

@end

//
//  DeeModel.m
//  SDWebImage
//
//  Created by Dee on 15/5/12.
//  Copyright (c) 2015年 zjsruxxxy7. All rights reserved.
//

#import "DeeModel.h"

@implementation DeeModel
+(instancetype)appsWithDic:(NSDictionary *)dic
{
 return [[self alloc]initWithDic:dic
         ];
}
-(instancetype)initWithDic:(NSDictionary *)dic
{
    if (self =[super init]) {
        
        [self setValuesForKeysWithDictionary:dic];
    }
    return self;
    
}


@end

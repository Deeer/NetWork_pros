//
//  DeeModel.h
//  SDWebImage
//
//  Created by Dee on 15/5/12.
//  Copyright (c) 2015年 zjsruxxxy7. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DeeModel : NSObject
@property (nonatomic,copy)NSString *name;
@property (nonatomic,copy)NSString *icon;
@property (nonatomic,copy)NSString *download;
+(instancetype)appsWithDic:(NSDictionary*)dic;
-(instancetype)initWithDic:(NSDictionary*)dic;
@end

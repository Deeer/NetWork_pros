//
//  ViewController.m
//  AFN-网络质量检测
//
//  Created by Dee on 15/5/25.
//  Copyright (c) 2015年 zjsruxxxy7. All rights reserved.
//

#import "ViewController.h"
#import "AFNetworking.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.

    AFNetworkReachabilityManager *mage= [AFNetworkReachabilityManager sharedManager];
    //当网络状态发生改变的时候调用这个block
    [mage setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
       
        switch (status) {
            case AFNetworkReachabilityStatusReachableViaWiFi:
                NSLog(@"wifi");
                break;
            case AFNetworkReachabilityStatusReachableViaWWAN:
                NSLog(@"wlan");
                break;
            case AFNetworkReachabilityStatusNotReachable:
                NSLog(@"not");
                break;
            case AFNetworkReachabilityStatusUnknown:
                NSLog(@"unknow");
            default:
                break;
        }
        
        
        
    }];
    
    [mage startMonitoring];
    
}
-(void)dealloc
{
    [[AFNetworkReachabilityManager sharedManager]stopMonitoring];
}



@end

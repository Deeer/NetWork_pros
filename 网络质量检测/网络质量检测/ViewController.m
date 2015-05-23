//
//  ViewController.m
//  网络质量检测
//
//  Created by Dee on 15/5/23.
//  Copyright (c) 2015年 zjsruxxxy7. All rights reserved.
//

#import "ViewController.h"
#import "Reachability.h"
#import "netWorkStateTool.h"

@interface ViewController ()
@property (nonatomic,strong)Reachability *reachability;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    //监听网络状态发生改变的通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(netWorkStateChange) name:kReachabilityChangedNotification object:nil];
    //获取reachAbility对象
    self.reachability = [Reachability reachabilityForInternetConnection];
    //开始监控网络
    [self.reachability startNotifier];
    
    
    
    
    
 // 1.主动监听网络改变对象
//    Reachability *wifi  = [Reachability reachabilityForLocalWiFi];
//    NetworkStatus status =wifi.currentReachabilityStatus;
//    if (status !=NotReachable) {
//        NSLog(@"wifi");
//    }
    
}


-(void)dealloc
{
    //停止监听
    [self.reachability stopNotifier];
    //在通知中心去除观察着
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}
-(void)netWorkStateChange
{
    NSLog(@"network changed");
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

//
//  ViewController.m
//  小文件下载
//
//  Created by Dee on 15/5/23.
//  Copyright (c) 2015年 zjsruxxxy7. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.

    
    //下载小文件
    //1.NSData dataWithURL
    //2.NSURL Connection
    
    
    
    



}


/**
 *  以下两种只适合最小文件下载
 * 原因：1.不能监听下载进度2.不内存过大（主要是data太大）
 */
-(void)loadFile
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        //一个GET请求
        NSURL*url =[NSURL URLWithString:@"http://localhost:8080/MJServer/resources/images/minion_01.png"];
        NSData *data =[NSData dataWithContentsOfURL:url];
        NSLog(@"%d",(int)data.length);

    });
    

}

-(void)loadFile2
{
    NSURL*url =[NSURL URLWithString:@"http://localhost:8080/MJServer/resources/images/minion_01.png"];
    NSURLRequest *request =[NSURLRequest requestWithURL:url];
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        
        
        
    }];
    
    
}



@end

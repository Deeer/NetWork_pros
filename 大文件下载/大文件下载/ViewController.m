//
//  ViewController.m
//  大文件下载
//
//  Created by Dee on 15/5/23.
//  Copyright (c) 2015年 zjsruxxxy7. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<NSURLConnectionDataDelegate>
@property (nonatomic,strong)NSMutableData *fileData;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
    
}

-(void)downLoad
{
    NSURL*url =[NSURL URLWithString:@"http://localhost:8080/MJServer/resources/images/minion_01.png"];
    NSURLRequest *request =[NSURLRequest requestWithURL:url];
    
    
    
    //delegate 检测下载进度
    
    //下载（创建完connect对象后，会自动发起一个异步请求）
    [NSURLConnection connectionWithRequest:request delegate:self];
//    NSURLConnection *conn = [NSURLConnection connectionWithRequest:request delegate:self];
    //一样的方法
//    [[NSURLConnection alloc]initWithRequest:request delegate:self];
    
    //多个参数，马上开始发起请求
//    [[NSURLConnection alloc]initWithRequest:request delegate:self; startImmediately:YES];
    
    //仅仅创建连接，但是不发起请求
//    [[NSURLConnection alloc]initWithRequest:request delegate:self; startImmediately:NO];
    
    //开始发起请求
//    [conn start];
    
}
#pragma mark  - NSURLConnectionDataDelegate

-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    
    
}

//先接收到响应，然后在接收到数据，最后数据接收完毕调用finishloading方法。所以以下调用有一定的顺序
/**
 *  当接收到服务器返回的实体内容数据时调用（具体内容，可能会调用多次）
 */

-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    self.fileData =[NSMutableData data];
    
    //取出文件总长度
    //取出文件的响应头
    NSHTTPURLResponse *rep =(NSHTTPURLResponse*)response;
    

    
}
-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [self.fileData appendData:data];
}

    //服务器的数据完全返回时才会调用
-(void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    NSLog(@"finished");
    
    //拼接路径
    NSString *cachepPath =[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)lastObject];
    
    NSString *file =[cachepPath stringByAppendingString:@"text.mp4"];
    //写到沙盒中
    [self.fileData writeToFile:file atomically:YES];
    
}


@end

//
//  ViewController.m
//  大文件下载（合理方式）
//
//  Created by Dee on 15/5/23.
//  Copyright (c) 2015年 zjsruxxxy7. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<NSURLConnectionDataDelegate>

@property (nonatomic,strong) NSFileHandle *writeHandle;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    
    
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    NSURL * url = [NSURL URLWithString:@"http://localhost:8080/MJServer/resource/videos.zip"];
    
    NSURLRequest *request =[NSURLRequest requestWithURL:url];
    
    
    [NSURLConnection connectionWithRequest:request delegate:self];
    
    
}

-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
 //文件路径
    NSString * caches =[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
    NSString * filePath =[caches stringByAppendingString:@"vides.zip"];
    
  //创建一个空的文件到沙盒中
    NSFileManager *mgr =[NSFileManager defaultManager];
    [mgr createFileAtPath:filePath contents:nil attributes:nil];
    //创建一个用来写数据的文件句柄
    self.writeHandle = [NSFileHandle fileHandleForReadingAtPath:filePath];
    
    
    
}

-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    //移动到文件的最后
    [self.writeHandle seekToEndOfFile];
    //写入数据到沙盒
    [self.writeHandle writeData:data];
    
    
}


-(void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    [self.writeHandle closeFile];
    self.writeHandle =nil;
}

@end

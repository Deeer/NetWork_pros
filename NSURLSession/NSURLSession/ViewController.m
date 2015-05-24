//
//  ViewController.m
//  NSURLSession
//
//  Created by Dee on 15/5/24.
//  Copyright (c) 2015年 zjsruxxxy7. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<NSURLSessionDownloadDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    
    
}
//   NSURLSessionDataTask :普通的GET/POST请求
//    NSURLSessionDownloadTask ：文件下载
//    NSURLSessionUploadTask :文件上传
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    
    
    [self downTask2];
   
    
    
    
}
-(void)dataTask
{
    //1得到session对象
    NSURLSession* session =[NSURLSession sharedSession];
    //任务：任何请求都是一个任务
    //普通的GET/POST/文件下载/文件上传
    
    //2.创建一个task任务(get)======================
    //    NSURL *url =[NSURL URLWithString:@"http://localhost:8080/MJServer/video"];
    //    NSURLSessionDataTask *task =[session dataTaskWithURL:url completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
    //
    //        NSLog(@"%d",(int)data.length);
    //
    //    }];
    //============================================
    //    2.1(post)
    NSURL * url =[NSURL URLWithString:@"http://localhost:8080/MJServer/login"];
    
    NSMutableURLRequest *request =[NSMutableURLRequest requestWithURL:url];
    
    request.HTTPMethod =@"POST";
    
    request.HTTPBody = [@"username=123&pwd=123" dataUsingEncoding:NSUTF8StringEncoding];
    
    NSURLSessionDataTask *task =[session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        
        
        NSDictionary *dic=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
        NSLog(@"%@",dic);
        
    }];
    //开始任务
    [task resume];
}



//下载任务，不能监听下载任务
-(void)downtask
{
    
    //拿到session对象
    NSURLSession *session =[NSURLSession sharedSession];
    //创建下载任务。。没有传data，但是默认将数据写入沙盒的tmp文件夹中
    NSURL *url =[NSURL URLWithString:@"http://localhost:8080/MJServer/resources/videos/minion_01.mp4"];
    NSURLSessionDownloadTask *task  = [session downloadTaskWithURL:url completionHandler:^(NSURL *location, NSURLResponse *response, NSError *error) {
        //location :临时文件的路径
        NSString *caches = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)lastObject];
        //response.suggestedFilename建议要使用的文件名，一般与服务器端的文件名一致
        NSString *parh =[caches stringByAppendingString:response.suggestedFilename];
        
        //将临时文件剪切或复制到caches文件中
        
        NSFileManager *mage =[NSFileManager defaultManager];
        //剪切文件到指定路径
        [mage moveItemAtPath:location.path toPath:parh error:nil];
        //
        
        //下载完毕会调用这个block
        
        
        
    }];
    [task resume];
}
    //可以监听下载进度
-(void)downTask2
{
    
    NSURLSessionConfiguration * config =[NSURLSessionConfiguration defaultSessionConfiguration];
    //1. 得到session对象
    NSURLSession * session =[NSURLSession sessionWithConfiguration:config delegate:self delegateQueue:[NSOperationQueue mainQueue]];
    //2.创建下载任务
    NSURL *url =[NSURL URLWithString:@"http://localhost:8080/MJServer/resources/videos/minion_01.mp4"];
    NSURLSessionDownloadTask *task  = [session downloadTaskWithURL:url];
    //3.开始下载任务
    [task resume];
    
}
#warning  --------
// 如果给下载任务设置了completionHandler这个block，如果实现了下载的代理方法，优先执行block

#pragma mark - NSURLSessionDownDelegate
/**
 *  下载完毕后调用
 *  @param location     临时文件的路径 （下载好的文件）
 */
-(void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didFinishDownloadingToURL:(NSURL *)location
{
    
    //location :临时文件的路径
    NSString *caches = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)lastObject];
 
    //response.suggestedFilename建议要使用的文件名，一般与服务器端的文件名一致
    NSString *parh =[caches stringByAppendingPathComponent:downloadTask.response.suggestedFilename];
    
    //将临时文件剪切或复制到caches文件中
    
    NSFileManager *mage =[NSFileManager defaultManager];
    //剪切文件到指定路径
    [mage moveItemAtPath:location.path toPath:parh error:nil];
    
}
/**
 *  恢复下载时调用
 */
-(void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didResumeAtOffset:(int64_t)fileOffset expectedTotalBytes:(int64_t)expectedTotalBytes
{
    
}
/**
 *  每当下载完（一部分）就会被调用一次，所以对于整个下载过程，会调用多次
 *  @param bytesWritten              这次调用写了多少
 *  @param totalBytesWritten         累计写了多少长度到沙盒中
 *  @param totalBytesExpectedToWrite 文件的总长度
 */

-(void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didWriteData:(int64_t)bytesWritten totalBytesWritten:(int64_t)totalBytesWritten totalBytesExpectedToWrite:(int64_t)totalBytesExpectedToWrite
{
    double progress= (double)totalBytesWritten /totalBytesExpectedToWrite;
    NSLog(@"%f",progress);
}




@end

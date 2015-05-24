//
//  ViewController.m
//  文件解压缩
//
//  Created by Dee on 15/5/24.
//  Copyright (c) 2015年 zjsruxxxy7. All rights reserved.
//

#import "ViewController.h"
#import "SSZipArchive.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
   
    NSURL *url =[NSURL URLWithString:@"http://localhost:8080/MJServer/resources/images.zip"];
    
    //执行下载任务---下载到的是tmp文件
    NSURLSession *session =[NSURLSession sharedSession];
    NSURLSessionDownloadTask *task =[session downloadTaskWithURL:url completionHandler:^(NSURL *location, NSURLResponse *response, NSError *error) {
       
        NSString *caches= [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)lastObject];
        
        //下载后直接解压---解压到caches文件
        [SSZipArchive unzipFileAtPath:location.path toDestination:caches];
        
        
    }];
    
    [task resume];
    
    
    
}

-(void)unzip
{
    
    NSURL *url =[NSURL URLWithString:@"http://localhost:8080/MJServer/resources/images.zip"];
    
    NSURLSessionDownloadTask *task= [[NSURLSession sharedSession]downloadTaskWithURL:url completionHandler:^(NSURL *location, NSURLResponse *response, NSError *error) {
        
        NSString *caches= [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)lastObject];
        [SSZipArchive unzipFileAtPath:location.path toDestination:caches];
    }];
    
    [task resume];
}



@end

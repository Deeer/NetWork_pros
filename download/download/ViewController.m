//
//  ViewController.m
//  download
//
//  Created by Dee on 15/5/24.
//  Copyright (c) 2015年 zjsruxxxy7. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<NSURLConnectionDataDelegate>
@property (nonatomic,strong)NSFileHandle *writeHandler;

@end

@implementation ViewController
-(void)viewDidLoad
{
    [super viewDidLoad];
    
}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    NSURL *url =[NSURL URLWithString:@"http://localhost:8080/MJServer/resources/videos/minion_02.mp4"];
    NSURLRequest *quest = [NSURLRequest requestWithURL:url];
    
    [NSURLConnection connectionWithRequest:quest delegate:self];
    
    
}

#pragma mark 
-(void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    
}
-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [self.writeHandler seekToEndOfFile];
    [self.writeHandler writeData:data];
    
    
}
-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    NSString* caches =[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)lastObject];
    NSString*path =[caches stringByAppendingPathComponent:@"ca.cp"];
    
    NSFileManager *mag =[NSFileManager defaultManager];
    [mag createFileAtPath:path contents:nil attributes:nil];
    
    self.writeHandler =[NSFileHandle fileHandleForWritingAtPath:path];
    
}
@end

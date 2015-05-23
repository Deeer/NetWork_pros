//
//  ViewController.m
//  fileDownLaod
//
//  Created by Dee on 15/5/23.
//  Copyright (c) 2015年 zjsruxxxy7. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<NSURLConnectionDataDelegate>

@property (nonatomic,strong)NSFileHandle *writeHandle;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    NSURL *url =[NSURL URLWithString:@"http://localhost:8080/MJServer/resources/videos/minion_02.mp4"];
    NSURLRequest *request =[NSURLRequest requestWithURL:url];
    
    
    [NSURLConnection connectionWithRequest:request delegate:self];
    
    
    
}
#pragma mark -  NSURLConnectionDataDelegate

-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    NSLog(@"%@",error);
    
}


-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    NSString *caches  =[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
    NSLog(@"%@",caches);
    NSString *filePath =[caches stringByAppendingPathComponent:@"minion_01.png"];
    
    NSFileManager *mgr = [NSFileManager defaultManager];
    [mgr createFileAtPath:filePath contents:nil attributes:nil];
    
    self.writeHandle =[NSFileHandle fileHandleForWritingAtPath:filePath];
    
}

-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [self.writeHandle seekToEndOfFile];
    
    [self.writeHandle writeData:data];
    
    
}


-(void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    
    [self.writeHandle closeFile];

    self.writeHandle =nil;

}



@end

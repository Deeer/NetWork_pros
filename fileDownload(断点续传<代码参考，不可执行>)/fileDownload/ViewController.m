//
//  ViewController.m
//  fileDownload
//
//  Created by Dee on 15/5/24.
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
#pragma mark -Delegate

-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    NSString *cache =[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)lastObject];
    NSString *path =[cache stringByAppendingPathComponent:@"videos.mp4"];
    NSFileManager *mage =[NSFileManager defaultManager];
    [mage createFileAtPath:path contents:nil attributes:nil];
   
    self.writeHandle = [NSFileHandle fileHandleForWritingAtPath:path];
    
}


-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data

{
    [self.writeHandle seekToEndOfFile];
    [self.writeHandle  writeData:data];
}
-(void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    [self.writeHandle closeFile];
    self.writeHandle =nil;
    
}

-(IBAction)downLoadSwitch:(id)sender
{
    //button取反
    sender.selected =!sender.isSelected;
    //如果被选中，发出原来的request
    if (sender.selected) {
    NSURL *url =[NSURL URLWithString:@"http://localhost:8080/MJServer/resources/videos/minion_02.mp4"];
    
    NSMutableURLRequest *request =[NSMutableURLRequest requestWithURL:url];
    
    //在一定大小之后继续下载
    NSString *rang  =[NSString stringWithFormat:@"bytes=%lld-",self.currentLength];
    [request setValue:rang forHTTPHeaderField:@"Range"];
    
        self.conm =[NSURLConnection connectionWithRequest:request delegate:self];
        
    }else{
        
        [self.conn cancle];
        self.conn = nil;
    }
    
    
}





@end

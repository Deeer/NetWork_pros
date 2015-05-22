//
//  ViewController.m
//  加载bundle文件
//
//  Created by Dee on 15/5/22.
//  Copyright (c) 2015年 zjsruxxxy7. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (strong , nonatomic) IBOutlet UIWebView *webView;
@end

@implementation ViewController


-(UIWebView *)webView
{
    if (!_webView) {
        _webView = [[UIWebView alloc]initWithFrame:self.view.bounds];
        _webView.dataDetectorTypes   = UIDataDetectorTypeAll;
    }
    return _webView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self.view addSubview:self.webView];
    [self loadFile];
    
    
    
    
}

-(void)loadFile
{
    NSURL *fileURl =[[NSBundle mainBundle]URLForResource:@"《iOS 人机界面准则》中文版.pdf" withExtension:nil];
    
    NSURLRequest *requset =[NSURLRequest requestWithURL:fileURl];
    //服务器的响应对象，服务器接收到请求返回给客户端的
    NSURLResponse *reponce = nil;
    
    NSData *data  = [NSURLConnection sendSynchronousRequest:requset returningResponse:&reponce error:nil];
    
    [self.webView loadData:data MIMEType:reponce.MIMEType textEncodingName:@"UTF8" baseURL:nil];
    
    NSLog(@"%@",reponce.MIMEType);
    
}


@end

//
//  ViewController.m
//  多值参数
//
//  Created by Dee on 15/5/18.
//  Copyright (c) 2015年 zjsruxxxy7. All rights reserved.
//

#import "ViewController.h"
#import "MBProgressHUD+MJ.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    
    NSURL *url = [NSURL URLWithString:@"http://localhost:8080/MJServer/weather"];
    
    NSMutableURLRequest *requset =[NSMutableURLRequest requestWithURL:url];
    requset.HTTPMethod = @"POST";
    
    NSMutableString *param = [NSMutableString string];
    [param appendString:@"place=beijing"];
    [param appendString:@"&palce=tianjin"];
    [param appendString:@"&place=meizhou"];
    [param appendString:@"&place=guangzhou"];
    requset.HTTPBody  =[param dataUsingEncoding:NSUTF8StringEncoding];
    
    [NSURLConnection sendAsynchronousRequest:requset queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        NSDictionary *dic= [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
        NSString *error =dic[@"error"];
        if (error) {
            [MBProgressHUD showError:error];
        
        }else
        {
            NSString *success =dic[@"weathers"];
            NSLog(@"%@",dic);
        }
        
        
        
    }];
    
    
}
@end

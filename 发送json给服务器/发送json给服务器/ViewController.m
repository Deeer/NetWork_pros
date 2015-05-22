//
//  ViewController.m
//  发送json给服务器
//
//  Created by Dee on 15/5/18.
//  Copyright (c) 2015年 zjsruxxxy7. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    NSURL *url =[NSURL URLWithString:@"http://localhost:8080/MJServer/order"];
    
    NSMutableURLRequest *request =[NSMutableURLRequest requestWithURL:url];
    
    request.HTTPMethod =@"POST";
    
    //设置请求头，因为请求体的数据不在是普通参数，而是json数据
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    
    //设置请求参数
    //创建一个json
    NSDictionary *orderInfo = @{ @"shop_id":@"1",
                                 @"shop_prise":@"123",
                                 @"shop_user":@"dee"
                                 };
    NSData *json =[NSJSONSerialization dataWithJSONObject:orderInfo options:NSJSONWritingPrettyPrinted error:nil];
    
    request.HTTPBody =json;
    
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        
        
        if (data ==nil ||connectionError) return ;
        NSDictionary * dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
        
      NSString *err =  dic[@"error"];
        
        NSLog(@"%@",err);
        
        NSString *success =dic[@"success"];
        
        NSLog(@"%@",success);
        
    }];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

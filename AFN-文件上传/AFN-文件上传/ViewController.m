//
//  ViewController.m
//  AFN-文件上传
//
//  Created by Dee on 15/5/24.
//  Copyright (c) 2015年 zjsruxxxy7. All rights reserved.
//

#import "ViewController.h"
#import "AFNetworking.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}


-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{

    //创建一个管理者
    AFHTTPRequestOperationManager *mage= [AFHTTPRequestOperationManager manager];
    
    //封装参数//这个字典只能方非文件参数
    NSMutableDictionary *dic= [NSMutableDictionary dictionary];
    dic[@"username"] =@"123";
    dic[@"age"] =@20;
    dic[@"pwd"] =@"345";
    dic[@"height"] =@1.99;
    //发送一个请求
    NSString*url = @"http://localhost:8080/MJServer/upload";
    
    [mage  POST:url parameters:dic  constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        //发送之前会自动调用这个block
        //在这个block中添加文件参数到formdata中
        //FielURL : 需要上传的文件路径
        //name : 服务器端接收的文件名
        //filename  : 所上传的文件名
        //mineType :所上传文件的文件类型
        UIImage*image =[UIImage imageNamed:@"minion_15"];
        NSData *data =UIImagePNGRepresentation(image);
        [formData appendPartWithFileData:data name:@"file" fileName:@"llal.png" mimeType:@"image/png"];
        
        
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
       
        NSLog(@"success");
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"fail");
    }];
    
}



@end

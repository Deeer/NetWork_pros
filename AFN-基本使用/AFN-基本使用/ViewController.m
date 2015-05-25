//
//  ViewController.m
//  AFN-基本使用
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

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.

    [self AFN_PSOT_JSON];
    
}

-(void)AFN_PSOT_JSON
{
    AFHTTPRequestOperationManager *mage=[AFHTTPRequestOperationManager manager];
    //    序列化器
    //    注意，默认就是AFJSONResponseSerializer
    //    mage.responseSerializer= [AFJSONResponseSerializer serializer];
    
    NSString *url =[NSString stringWithFormat:@"http://localhost:8080/MJServer/login"];
    NSMutableDictionary*dic =[NSMutableDictionary dictionary];
    
    dic[@"username"]=@"123";
    dic[@"pwd"] =@"123";
    
    
    /**
     *  发送GET请求
     *
     *  @param responseObject 返回值类型是个id 但实际类型是个字典类型
     * 发送参数值会直接转码
     */
    [mage POST:url parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"success");
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];

}

-(void)AFN_GET_DATA
{
    AFHTTPRequestOperationManager *mage=[AFHTTPRequestOperationManager manager];
    
    //声明返回的数据不要解析，直接返回data，文件下载中一般用这个
    mage.responseSerializer= [AFHTTPResponseSerializer serializer];///added
    //    序列化器
    //    注意，默认就是AFJSONResponseSerializer
    //    mage.responseSerializer= [AFJSONResponseSerializer serializer];
    
    NSString *url =[NSString stringWithFormat:@"http://localhost:8080/MJServer/login"];
    
    //声明不要对服务器的东西进行解析，直接返回data即可
    NSMutableDictionary*dic =[NSMutableDictionary dictionary];///added
    
    dic[@"username"]=@"123";
    dic[@"pwd"] =@"123";
    
    /**
     *  发送GET请求
     *
     *  @param responseObject 返回值类型是个id 但实际类型是个Data类型,
     * 发送参数值会直接转码
     */
    [mage GET:url parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        //        responseObject.delegate= self;
        //        [responseObject parse];
        //
        NSLog(@"%@",[responseObject class]);
        
        NSLog(@"success");
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
    
    


}
-(void)AFN_GET_XML
{
    
    AFHTTPRequestOperationManager *mage=[AFHTTPRequestOperationManager manager];
    //用xml解析器，解析返回的数据
    mage.responseSerializer= [AFXMLParserResponseSerializer serializer];///added
    //    序列化器
    //    注意，默认就是AFJSONResponseSerializer
    //    mage.responseSerializer= [AFJSONResponseSerializer serializer];
    
    NSString *url =[NSString stringWithFormat:@"http://localhost:8080/MJServer/login"];
    NSMutableDictionary*dic =[NSMutableDictionary dictionary];
    
    dic[@"username"]=@"123";
    dic[@"pwd"] =@"123";
    
    
    dic[@"type"] = @"XML";///////Added
    
    /**
     *  发送GET请求
     *
     *  @param responseObject 返回值类型是个id 但实际类型是个NSXMLParser类型,
     * 发送参数值会直接转码
     */
    [mage GET:url parameters:dic success:^(AFHTTPRequestOperation *operation, NSXMLParser* responseObject) {
        
//        responseObject.delegate= self;
//        [responseObject parse];
//        
        
        NSLog(@"success");
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
    
    
    
}
-(void)AFN_GET_JSON
{
    AFHTTPRequestOperationManager *mage=[AFHTTPRequestOperationManager manager];
//    序列化器
//    注意，默认就是AFJSONResponseSerializer
//    mage.responseSerializer= [AFJSONResponseSerializer serializer];
    
    NSString *url =[NSString stringWithFormat:@"http://localhost:8080/MJServer/login"];
    NSMutableDictionary*dic =[NSMutableDictionary dictionary];
    
    dic[@"username"]=@"123";
    dic[@"pwd"] =@"123";
    
    
    /**
     *  发送GET请求
     *
     *  @param responseObject 返回值类型是个id 但实际类型是个字典类型
     * 发送参数值会直接转码
     */
    [mage GET:url parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"success");
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
}

@end

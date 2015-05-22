//
//  ViewController.m
//  1.基本HTTP请求
//
//  Created by Dee on 15/5/10.
//  Copyright (c) 2015年 zjsruxxxy7. All rights reserved.
//

#import "ViewController.h"
#import "MBProgressHUD+MJ.h"
@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITextField *userName;
@property (weak, nonatomic) IBOutlet UITextField *pwd;
- (IBAction)login;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

- (IBAction)login {
    
    //  判断文本中是否有输入文字
    NSString *userNameText = self.userName.text;
    if (userNameText.length == 0) {
        [MBProgressHUD showError:@"请输入用户名"];
        return;
    };
    
    NSString *pwdText = self.pwd.text;
    if (pwdText.length == 0 ) {
        
        [MBProgressHUD showError:@"请输入密码"];
        return;
    };
    
    //增加蒙版
    [MBProgressHUD showMessage:@"laoding..."];
    
    //文件路径
    NSString *str =[NSString stringWithFormat:@"http://localhost:8080/MJServer/login?username=%@&pwd=%@",userNameText,pwdText];
    
 //========url不能包含中文必须进行转码
    
    str=  [str  stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    
    
    
    
  //=========
    
    //创建请求
    NSURL *url = [NSURL URLWithString:str];
    
    
    NSURLRequest *requst = [NSURLRequest requestWithURL:url];
    
    //发送一个同步请求（在主线程发送请求）//一般不发送同步请求,会卡死路线
//    NSData *data= [NSURLConnection sendSynchronousRequest:requst returningResponse:nil error:nil];
    //异步请求
    //刷新界面只能在主线程中执行，所以我们必须将这个block的队列放在mainQueue中，才会显示MBProgressHUD
    NSOperationQueue *queue = [NSOperationQueue mainQueue];
    //执行异步操作会开一个新的线程 ，然后在发送完成后得到
   [NSURLConnection sendAsynchronousRequest:requst queue:queue completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
       
       //隐藏蒙版
       [MBProgressHUD hideHUD];
       
       if (connectionError  || data ==nil) {
            
            [MBProgressHUD showError:@"Fail request"];
            
            return ;
            
        }
   
    
    //解析服务器返回的json数据
    NSDictionary *dic=   [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
    NSString *error=dic[@"error"];
    if (error) {
        [MBProgressHUD showError:error];
    }else {
        NSString*success = dic[@"success"];
        [MBProgressHUD showSuccess:success];
    }
    
    }];
}
@end

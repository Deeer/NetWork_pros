//
//  ViewController.m
//  1.基本HTTP请求
//
//  Created by Dee on 15/5/10.
//  Copyright (c) 2015年 zjsruxxxy7. All rights reserved.
//

#import "ViewController.h"
#import "MBProgressHUD+MJ.h"
#import "NSString+Hash.h"
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
    
    
    //文件路径
//    NSString *str =[NSString stringWithFormat:@"http://localhost:8080/MJServer/login",userNameText,pwdText];
    
    //创建请求x
    NSURL *url = [NSURL URLWithString:@"http://localhost:8080/MJServer/login"];
    
    
    NSMutableURLRequest *requst = [NSMutableURLRequest requestWithURL:url];
    requst.HTTPMethod =@"POST";
    
    
    //5秒后算请求超时；（默认是60秒超时）
    requst.timeoutInterval =10;
    
    //设置请求头
    [requst setValue:@"dee" forHTTPHeaderField:@"User-Agent"];
    
    
    
    //设置请求体
    NSString *para =[NSString stringWithFormat:@"username=%@&pwd=%@",userNameText,pwdText];
    
    
     pwdText = [self MDSalt:pwdText];
    
    NSLog(@"%@",pwdText);
    
    
    
    //httpbody要求返回nsdata类型
    requst.HTTPBody = [para dataUsingEncoding:NSUTF8StringEncoding];//NSString -> NSData
    
    
    
    //发送一个同步请求（在主线程发送请求）//一般不发送同步请求,会卡死路线
//    NSData *data= [NSURLConnection sendSynchronousRequest:requst returningResponse:nil error:nil];
    //异步请求
    //刷新界面只能在主线程中执行，所以我们必须将这个block的队列放在mainQueue中，才会显示MBProgressHUD
    NSOperationQueue *queue = [NSOperationQueue mainQueue];
    //执行异步操作会开一个新的线程 ，然后在发送完成后得到
   [NSURLConnection sendAsynchronousRequest:requst queue:queue completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        
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

-(NSString*)MDSalt:(NSString *)text
{
    
    NSString *salt =[text stringByAppendingString:@"aa"];//撒盐
//    return [salt md5String];//md5加密
    
    NSString *prefix = [salt substringFromIndex:2];
    NSString *subfix = [salt substringToIndex:2];
    
    NSString *result = [prefix stringByAppendingString:subfix];
    
    return  result;
    
    
}

@end

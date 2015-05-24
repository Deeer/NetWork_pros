//
//  ViewController.m
//  session
//
//  Created by Dee on 15/5/24.
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

-(void)dataTask
{
    
    NSURLSession *session =[NSURLSession sharedSession];
    NSURL *url =[NSURL URLWithString:@"http://localhost:8080/MJServer/login"];
    NSURLSessionDataTask *task =[session dataTaskWithURL:url completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        
    }];
    

    
}


@end

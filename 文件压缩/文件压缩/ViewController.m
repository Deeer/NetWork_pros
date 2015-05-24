//
//  ViewController.m
//  文件压缩
//
//  Created by Dee on 15/5/24.
//  Copyright (c) 2015年 zjsruxxxy7. All rights reserved.
//

#import "ViewController.h"
#import "SSZipArchive.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    
    NSString *caches= [NSSearchPathForDirectoriesInDomains(NSCachesDirectory,NSUserDomainMask, YES)lastObject];
    NSString *path =[caches stringByAppendingPathComponent:@"images"];
    
    
    NSString *zipFiel =[caches stringByAppendingPathComponent:@"images.zip"];
    
    [SSZipArchive createZipFileAtPath:zipFiel withContentsOfDirectory:path];
    
    
}




@end

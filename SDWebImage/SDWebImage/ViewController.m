//
//  ViewController.m
//  SDWebImage
//
//  Created by Dee on 15/5/12.
//  Copyright (c) 2015年 zjsruxxxy7. All rights reserved.
//

#import "ViewController.h"
#import "DeeModel.h"
#import "UIImageView+WebCache.h"

@interface ViewController ()
@property (nonatomic,strong)NSMutableArray *apps;
@property (nonatomic,strong)NSOperationQueue *queue;
@property (nonatomic,strong)NSMutableDictionary *operations;
@property (nonatomic,strong)NSMutableDictionary *images;
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
#pragma mark - load
-(NSMutableArray *)apps//重写get方法
{
   
    if (!_apps) {
        NSString *path =[[NSBundle mainBundle]pathForResource:@"apps" ofType:@"plist"];
        NSArray *dicArray = [NSArray arrayWithContentsOfFile:path];
     
        NSMutableArray *arr =[NSMutableArray array];
        for (NSDictionary *dic in dicArray) {
            DeeModel *model= [DeeModel appsWithDic:dic];
            [arr addObject:model];
        }
        _apps =arr;
        
        
    }
    return  _apps;
    
}

#pragma  mark =- TableView_dataSocurce
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.apps.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ID = @"app";
    UITableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    
    DeeModel *app  =self.apps[indexPath.row];
    cell.textLabel.text    = app.name;
    cell.detailTextLabel.text = app.download;
    
    NSURL *url =[NSURL URLWithString:app.icon];
    UIImage *placeHolder = [UIImage imageNamed:@"placeholder"];
//
//    [cell.imageView sd_setImageWithURL:url placeholderImage:placeHolder ];
    
    
    SDWebImageOptions options= SDWebImageRetryFailed | SDWebImageLowPriority;
    [cell.imageView sd_setImageWithURL:url placeholderImage:placeHolder options:options];
    
    
    
    
    return cell;
}
@end

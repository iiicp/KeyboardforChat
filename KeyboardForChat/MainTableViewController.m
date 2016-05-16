//
//  MainTableViewController.m
//  KeyboardForChat
//
//  Created by ruofei on 16/4/8.
//  Copyright © 2016年 ruofei. All rights reserved.
//

#import "MainTableViewController.h"

@interface MainTableViewController ()

@property (strong, nonatomic) NSArray *demos;

@end

@implementation MainTableViewController

-(NSArray *)demos
{
    if (_demos == nil) {
        _demos = @[@"导航栏透明", @"导航栏设置成不透明，设置了图片", @"顶部带有标签栏的控制器", @"使用键盘的消息界面"];
    }
    return _demos;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.demos.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    
    cell.textLabel.text = self.demos[indexPath.row];
    
    return cell;

}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.row) {
        case 0:{
            
            [self performSegueWithIdentifier:@"DemoViewController" sender:nil];
            
            break;
        } case 1:{
            [self performSegueWithIdentifier:@"TestNavViewController" sender:nil];
            break;
        } case 2:{
            [self performSegueWithIdentifier:@"TopTabViewController" sender:nil];
            
            break;
        } case 3:{
            [self performSegueWithIdentifier:@"MessageViewController" sender:nil];
            break;
        }
            
    }
}
@end

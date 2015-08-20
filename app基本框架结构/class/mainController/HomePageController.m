//
//  HomePageController.m
//  超级模仿秀app
//
//  Created by xxzx on 15/8/13.
//  Copyright (c) 2015年 hxyxt. All rights reserved.
//

#import "HomePageController.h"
#import "GoodDetialController.h"
@interface HomePageController ()

@end

@implementation HomePageController

- (void)viewDidLoad {
    [super viewDidLoad];
     self.title = @"首页";
    
}
- (IBAction)jump:(id)sender {
    
    GoodDetialController *goodDetialVC = [GoodDetialController new];
    [self.navigationController pushViewController:goodDetialVC animated:YES];
}



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

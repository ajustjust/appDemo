//
//  YHTabBarController.m
//  超级模仿秀app
//
//  Created by xxzx on 15/8/13.
//  Copyright (c) 2015年 hxyxt. All rights reserved.
//

#import "YHTabBarController.h"
#import "BasicNavigationController.h"
#import "HomePageController.h"
#import "SecondViewController.h"

@interface YHTabBarController ()



@end

@implementation YHTabBarController


- (void)viewDidLoad
{
    [super viewDidLoad];
    self.tabBar.barTintColor = [UIColor whiteColor];
    // this will give selected icons and text your apps tint color
    self.tabBar.tintColor = [UIColor redColor];
    
    [self setupChildViewControllers];

}

/**
 normal : 普通状态
 highlighted : 高亮(用户长按的时候达到这个状态)
 disable : enabled = NO
 selected :  selected = YES
 */


///创建各个控制器
-(void)setupChildViewControllers
{
    // 1首页
    
    HomePageController* control_1 = [[HomePageController alloc] init];
    SecondViewController *control_2 = [[SecondViewController alloc]init];
    HomePageController* control_3 =[[HomePageController alloc] init];
    HomePageController* control_4 =[[HomePageController alloc] init];
    
    [self setupChildViewController:control_1 title:@"首页" imageName:@"home_w" selectdImageName:@"home_r"];
    
    [self setupChildViewController:control_2 title:@"超值抢" imageName:@"buy_w" selectdImageName:@"buy_r"];
    
    
    [self setupChildViewController:control_3 title:@"分类" imageName:@"category_w" selectdImageName:@"category_r"];
    
    
    [self setupChildViewController:control_4  title:@"个人中心" imageName:@"personal_w"
                  selectdImageName:@"personal_r"];
    

    
    
}
//////////////////////////////////
//封装初始化一个子控制器、

//***childVc   需要初始化的子控制器
//**title    标题
//**imageName  图标
//***seletedImageName 选中的图标
-(void)setupChildViewController:(UIViewController*)childVc title:(NSString*)title imageName:(NSString*)imageName selectdImageName:(NSString*)selectdImageName
{
    
    childVc.tabBarItem.image=[UIImage imageNamed:imageName];
    childVc.tabBarItem.title =title;
    childVc.tabBarItem.selectedImage = [[UIImage imageNamed:selectdImageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        BasicNavigationController *nav = [[BasicNavigationController alloc] initWithRootViewController:childVc];
    
    [self addChildViewController:nav];
}


@end

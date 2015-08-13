//
//  SwipableViewController.m
//  iosapp
//
//  Created by chenhaoxiang on 14-10-19.
//  Copyright (c) 2014年 oschina. All rights reserved.
//
#warning 综合视图构成！

#import "SwipableViewController.h"
#import "UIColor+Util.h"
//#import "Utils.h"
//#import "OSCAPI.h"
//#import "TweetsViewController.h"
//#import "PostsViewController.h"

@interface SwipableViewController ()  <UIScrollViewDelegate>

@property (nonatomic, strong) NSArray *controllers;

@end



@implementation SwipableViewController


- (instancetype)initWithTitle:(NSString *)title andSubTitles:(NSArray *)subTitles andControllers:(NSArray *)controllers
{
    return [self initWithTitle:title andSubTitles:subTitles andControllers:controllers underTabbar:NO];
}

- (instancetype)initWithTitle:(NSString *)title andSubTitles:(NSArray *)subTitles andControllers:(NSArray *)controllers underTabbar:(BOOL)underTabbar
{
    self = [super init];
    if (self) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
        //self.navigationController.navigationBar.translucent = NO;
        //self.view.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
        
        if (title) {self.title = title;}
        
        CGFloat titleBarHeight = 36;
        _titleBar = [[TitleBarView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, titleBarHeight) andTitles:subTitles];
        _titleBar.backgroundColor = [UIColor clearColor];
        [self.view addSubview:_titleBar];
        
        
        _viewPager = [[HorizonalTableViewController alloc] initWithViewControllers:controllers];
        
        CGFloat height = self.view.bounds.size.height - titleBarHeight - 64 - (underTabbar ? 49 : 0);
        _viewPager.view.frame = CGRectMake(0, titleBarHeight, self.view.bounds.size.width, height);
        
        [self addChildViewController:self.viewPager];
        [self.view addSubview:_viewPager.view];
        
        
        __weak TitleBarView *weakTitleBar = _titleBar;
        __weak HorizonalTableViewController *weakViewPager = _viewPager;
        //点击按钮时候，被点击按钮的特效代码块
        _viewPager.changeIndex = ^(NSUInteger index) {
            weakTitleBar.currentIndex = index;
            for (UIButton *button in weakTitleBar.titleButtons) {
                if (button.tag != index) {
                    [button setTitleColor:[UIColor colorWithHex:0x909090] forState:UIControlStateNormal];
                    button.transform = CGAffineTransformIdentity;
                } else {
                    [button setTitleColor:[UIColor colorWithHex:0x009000] forState:UIControlStateNormal];
                    button.transform = CGAffineTransformMakeScale(1.2, 1.2);
                }
            }
            [weakViewPager scrollToViewAtIndex:index];
        };
#warning --------->侧滑，切换视图对应标题按钮特效代码块！！
        _viewPager.scrollView = ^(CGFloat offsetRatio, NSUInteger focusIndex, NSUInteger animationIndex) {
            UIButton *titleFrom = weakTitleBar.titleButtons[animationIndex];
            UIButton *titleTo = weakTitleBar.titleButtons[focusIndex];
            CGFloat colorValue = (CGFloat)0x90 / (CGFloat)0xFF;
           
            [UIView transitionWithView:titleFrom duration:0.1 options:UIViewAnimationOptionTransitionCrossDissolve animations:^{
                [titleFrom setTitleColor:[UIColor colorWithRed:colorValue*(1-offsetRatio) green:colorValue blue:colorValue*(1-offsetRatio) alpha:1.0]
                                forState:UIControlStateNormal];
                titleFrom.transform = CGAffineTransformMakeScale(1 + 0.2 * offsetRatio, 1 + 0.2 * offsetRatio);
            } completion:nil];
            
            
            [UIView transitionWithView:titleTo duration:0.1 options:UIViewAnimationOptionTransitionCrossDissolve animations:^{
                [titleTo setTitleColor:[UIColor colorWithRed:colorValue*offsetRatio green:colorValue blue:colorValue*offsetRatio alpha:1.0]
                              forState:UIControlStateNormal];
                titleTo.transform = CGAffineTransformMakeScale(1 + 0.2 * (1-offsetRatio), 1 + 0.2 * (1-offsetRatio));
            } completion:nil];
        };
        
   #warning --------->点击按钮切换视图的代码块！！
        _titleBar.titleButtonClicked = ^(NSUInteger index) {
            [weakViewPager scrollToViewAtIndex:index];
        };
    }
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor themeColor];
}


- (void)scrollToViewAtIndex:(NSUInteger)index
{
     _viewPager.changeIndex(index);
}



@end

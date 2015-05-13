//
//  RHCTabBarViewController.m
//  iOS跳转解耦
//
//  Created by renren on 4/27/15.
//  Copyright (c) 2015 renren. All rights reserved.
//

#import "LSLTabBarViewController.h"
#import "LSLHomeViewController.h"
#import "LSLMoreViewController.h"
#import "LSLBaseNavigationController.h"
#import "RDVTabBarItem.h"

@interface LSLTabBarViewController ()<UINavigationControllerDelegate,RDVTabBarControllerDelegate>


@end

@implementation LSLTabBarViewController

#pragma mark -lifeCycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self addNavigationBar];
    
}

#pragma mark - prvateMethod

-(void)addNavigationBar
{
    LSLHomeViewController *hv = [[LSLHomeViewController alloc] init];
    LSLBaseNavigationController *hnav = [[LSLBaseNavigationController alloc] initWithRootViewController:hv];
    hnav.delegate = self;
    
    LSLMoreViewController *cv = [[LSLMoreViewController alloc] init];
    LSLBaseNavigationController *cnav = [[LSLBaseNavigationController alloc] initWithRootViewController:cv];
    cnav.delegate = self;
    
    [self setViewControllers:@[hnav,cnav]];
    
    [self customizeTabBar:self];
}

- (void)customizeTabBar:(RDVTabBarController *)tbc;
{
    
    NSArray *titles = @[@"首页",@"我的"];
    NSArray *selectImages = @[@"ico_shouye",@"ico_fenlei"];

    for (int i = 0; i < selectImages.count; i++) {
        RDVTabBarItem *mytabBarItem = tbc.tabBar.items[i];
        [mytabBarItem setFinishedSelectedImage:[UIImage imageNamed:selectImages[i]] withFinishedUnselectedImage:[UIImage imageNamed:selectImages[i]]];
        [mytabBarItem setBackgroundSelectedImage:[UIImage imageNamed:@"tab_xuanzhong"]withUnselectedImage:[UIImage imageNamed:@"tab_weixuan"]];
        mytabBarItem.title = titles[i];
        mytabBarItem.titlePositionAdjustment = UIOffsetMake(0, 3);
        mytabBarItem.unselectedTitleAttributes = @{
                                                   NSFontAttributeName: [UIFont boldSystemFontOfSize:13],
                                                   NSForegroundColorAttributeName: [UIColor whiteColor]};
        mytabBarItem.selectedTitleAttributes =
                                        @{NSFontAttributeName: [UIFont boldSystemFontOfSize:13],
                                    NSForegroundColorAttributeName: [UIColor whiteColor]
                                                                                          };

    }
}

#pragma mark - UINavigationControllerDelegate
- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if(navigationController.viewControllers.count == 1){
        self.tabBarHidden = NO;
    } else {
        self.tabBarHidden = YES;
    }
    viewController.view.frame = self.contentViewBounds;
}



@end

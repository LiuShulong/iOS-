//
//  LSLHomeViewController.m
//  ios代码架构
//
//  Created by renren on 5/13/15.
//  Copyright (c) 2015 renren. All rights reserved.
//

#import "LSLHomeViewController.h"
#import "ForwardServiceHeader.h"
#import "LSLHomeDetailController.h"

@interface LSLHomeViewController ()

@property (nonatomic,strong) UIButton *gotoDetailPageButton;

@end

@implementation LSLHomeViewController

#pragma mark - lifeCycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self configureUI];
    [self configureSubViewsFrame];
    
}

- (void)configureUI
{
    [self.view addSubview:self.gotoDetailPageButton];
}

- (void)configureSubViewsFrame
{
    self.gotoDetailPageButton.frame = CGRectMake(20, 100, CGRectGetWidth(self.view.bounds) - 40, 30);
}

#pragma mark - click

- (void)gotoDetailPage
{
    [LSLForwardService openHomeDetailPage:^(LSLHomeDetailController *controller) {
        
    }];
}

#pragma mark - get&&set

- (UIButton *)gotoDetailPageButton
{
    if (_gotoDetailPageButton == nil) {
        _gotoDetailPageButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _gotoDetailPageButton.backgroundColor = [UIColor lightGrayColor];
        _gotoDetailPageButton.layer.cornerRadius = 3.5;
        _gotoDetailPageButton.layer.masksToBounds = YES;
        [_gotoDetailPageButton setTitle:@"前往detail界面" forState:UIControlStateNormal];
        [_gotoDetailPageButton addTarget:self action:@selector(gotoDetailPage) forControlEvents:UIControlEventTouchUpInside];
    }
    return _gotoDetailPageButton;
}

@end

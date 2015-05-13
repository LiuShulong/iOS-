//
//  LSLHomeDetailController.m
//  ios代码架构
//
//  Created by renren on 5/13/15.
//  Copyright (c) 2015 renren. All rights reserved.
//

#import "LSLHomeDetailController.h"

@interface LSLHomeDetailController ()

@end

@implementation LSLHomeDetailController

#pragma mark - lifeCycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self configureUI];
    [self configureFrames];
}

- (void)configureUI
{
    [self.view addSubview:[self backButton]];
}

- (void)configureFrames
{
    UIButton *backBtn = (UIButton *)[self.view viewWithTag:100];
    backBtn.frame = CGRectMake(30, 100, CGRectGetWidth(self.view.bounds) - 60, 30);
}

#pragma mark - get&&set

- (UIButton *)backButton
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.layer.cornerRadius = 3.5l;
    btn.layer.masksToBounds = YES;
    btn.backgroundColor = [UIColor lightGrayColor];
    [btn setTitle:@"返回" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(goBack) forControlEvents:UIControlEventTouchUpInside];
    btn.tag = 100;
    return btn;
}

@end

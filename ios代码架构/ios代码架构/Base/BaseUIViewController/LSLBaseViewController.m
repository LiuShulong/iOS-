//
//  RHCBaseViewController.m
//  iOS跳转解耦
//
//  Created by renren on 4/27/15.
//  Copyright (c) 2015 renren. All rights reserved.
//

#import "LSLBaseViewController.h"
#import "AppDelegate.h"
#import "LSLForwardService.h"
#import "JGProgressHUD.h"
#import "JGProgressHUDErrorIndicatorView.h"
#import "JGProgressHUDSuccessIndicatorView.h"
#import <objc/runtime.h>


enum {
    RHCProgressLoadingTag = 103900,
    RHCMessageTipTag
};

@interface LSLBaseViewController ()<JGProgressHUDDelegate>

@end

@implementation LSLBaseViewController

#pragma lifeCycle


- (instancetype)initWithConfigureBlock:(void (^)(id))configureBlock
{
    if (self == [super init]) {
        if (configureBlock) {
            configureBlock(self);
            
        }
    }
    return self;
}

//因为想要手动旋转，所以先关闭自动旋转
- (BOOL)shouldAutorotate{
    return NO;
}

-(NSUInteger)supportedInterfaceOrientations{
    return UIInterfaceOrientationMaskPortrait;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = NSStringFromClass([self class]);
    self.navigationItem.hidesBackButton = YES;
    
    
}
- (void)viewWillAppear:(BOOL)animated
{
    if (self.navigationController) {
        [LSLForwardService sharedInstance].navigationController = self.navigationController;
    }
}


- (UIWindow *)window
{
    AppDelegate *delegate = [UIApplication sharedApplication].delegate;
    return delegate.window;
}

- (UIViewController *)topViewController
{
    UIViewController *controller;
    if (self.navigationController) {
        controller = self.navigationController;
        if (self.navigationController.topViewController) {
            return self.navigationController.topViewController;
        }
    } else {
        controller = self;
    }
    UIViewController *ctl = controller.presentedViewController;
    
    if (ctl) {
        return ctl;
    }
    
    return controller;

}

- (void)goBack
{
    if (self.isPresentViewController) {
        [self dismissViewControllerAnimated:YES completion:NULL];
    } else {
        [self.navigationController popViewControllerAnimated:YES];
    }
}


@end

@implementation LSLBaseViewController (HUDMessage)

char* const ASSOCIATION_MUTABLE_ARRAY = "ASSOCIATION_MUTABLE_ARRAY";

#pragma mark - 提示语相关

- (void)showTextTip:(NSString *)message configureBlock:(void (^)(JGProgressHUD *))configureBlock
{
    JGProgressHUD *HUD = self.prototypeHUD;
    
    HUD.indicatorView = nil;
    
    HUD.textLabel.text = message;
    HUD.position = JGProgressHUDPositionCenter;
    HUD.marginInsets = (UIEdgeInsets) {
        .top = 0.0f,
        .bottom = 20.0f,
        .left = 20.0f,
        .right = 20.0f,
    };
    
    configureBlock(HUD);
    
    [HUD showInView:self.view];
    
    [HUD dismissAfterDelay:2.0];
    
}

- (BOOL)isTipExists
{
    if ([self.currentShowTips count] > 0) {
        return YES;
    } else {
        return NO;
    }
}

- (void)hideTip
{
    [self.currentShowTips enumerateObjectsUsingBlock:^(JGProgressHUD * obj, NSUInteger idx, BOOL *stop) {
        [obj dismiss];
    }];
}

- (JGProgressHUD *)prototypeHUD {
    JGProgressHUD *HUD = [[JGProgressHUD alloc] initWithStyle:JGProgressHUDStyleDark];
    HUD.interactionType = JGProgressHUDInteractionTypeBlockNoTouches;
    HUD.delegate = self;

    return HUD;
}

/**
 *  网络加载状态相关
 */
- (BOOL)isLoadingViewExists
{
    return NO;
}
- (void)showLoadingView
{
    JGProgressHUD *HUD = self.prototypeHUD;
    
    [HUD showInView:self.view];
    
    [HUD dismissAfterDelay:3.0];
}
- (void)hideLoadingView
{
    [self hideTip];
}


#pragma mark - JGProgressHUDDelegate

- (void)progressHUD:(JGProgressHUD *)progressHUD didPresentInView:(UIView *)view
{
    [self.currentShowTips addObject:progressHUD];
}

- (void)progressHUD:(JGProgressHUD *)progressHUD didDismissFromView:(UIView *)view
{
    [self.currentShowTips removeObject:progressHUD];
}

#pragma mark - get&&set

- (void)setCurrentShowTips:(NSMutableArray *)currentShowTips
{
    objc_setAssociatedObject(self, ASSOCIATION_MUTABLE_ARRAY, currentShowTips, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSMutableArray *)currentShowTips
{
    NSMutableArray *tips = objc_getAssociatedObject(self, ASSOCIATION_MUTABLE_ARRAY);
    
    if (tips == nil) {
        tips = [NSMutableArray array];
        [self setCurrentShowTips:tips];
    }
    return tips;
}



@end

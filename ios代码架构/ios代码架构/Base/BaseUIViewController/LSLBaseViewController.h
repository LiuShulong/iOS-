//
//  RHCBaseViewController.h
//  iOS跳转解耦
//
//  Created by renren on 4/27/15.
//  Copyright (c) 2015 renren. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JGProgressHUD.h"

@interface LSLBaseViewController : UIViewController

@property (nonatomic,assign) BOOL isPresentViewController;


/**
 *  初始化操作
 *
 *  @param configureBlock 参数为返回的控制器，通过block进行参数设置
 *
 *  @return 控制器
 */
- (instancetype)initWithConfigureBlock:(void(^)(id controller))configureBlock;

- (void)goBack;

/**
 *  取得当前delegate的window
 *
 *  @return 当前delegate的window
 */
- (UIWindow *)window;

/**
 *  取得栈顶的controller
 *
 *  @return 栈顶得控制器
 */
- (UIViewController *)topViewController;

@end

@interface LSLBaseViewController (HUDMessage)

@property (nonatomic,strong) NSMutableArray *currentShowTips;//所有得正在显示得tip

/**
 * 显示提示信息
 */
- (void)showTextTip:(NSString *)message configureBlock:(void(^)(JGProgressHUD *))configureBlock;
- (void)hideTip;
- (BOOL)isTipExists;

/**
 *  网络加载状态相关
 */
- (BOOL)isLoadingViewExists;
- (void)showLoadingView;
- (void)hideLoadingView;


@end

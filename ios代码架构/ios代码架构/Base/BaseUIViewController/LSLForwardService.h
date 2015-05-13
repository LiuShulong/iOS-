//
//  RHCForwardService.h
//  iOS跳转解耦
//
//  Created by renren on 4/28/15.
//  Copyright (c) 2015 renren. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "LSLHomeDetailController.h"
#import "LSLLoginViewController.h"

/**
 *  跳转类型
 */
typedef NS_ENUM(NSInteger, LSLForwardType){
    /**
     *  push方式跳转
     */
    LSLForwardTypePush,
    /**
     *  模态跳转
     */
    LSLForwardTypePresent
};

@interface LSLForwardService : NSObject

+ (instancetype) sharedInstance;

@property (nonatomic,strong) UINavigationController *navigationController;

- (void)forwarToViewController:(UIViewController *)controller type:(LSLForwardType)type;

//+ (void)openHomeDetailPage:(void(^)(RHCHomeDetailController *ctl))configureBlock;

+ (void)openLoginPage:(void(^)(LSLLoginViewController *ctl))configureBlock;

@end

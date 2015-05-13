//
//  RHCForwardService.m
//  iOS跳转解耦
//
//  Created by renren on 4/28/15.
//  Copyright (c) 2015 renren. All rights reserved.
//

#import "LSLForwardService.h"
#import "LSLBaseNavigationController.h"



@implementation LSLForwardService

+ (instancetype )sharedInstance {
    static LSLForwardService *service;
    if (service == nil) {
        service = [[self alloc] init];
    }
    return service;
}

- (void)forwarToViewController:(UIViewController *)controller type:(LSLForwardType)type
{
    if (type == LSLForwardTypePush) {
        if (self.navigationController != nil) {
            [_navigationController pushViewController:controller animated:YES];
        } else {
            return;
        }
    } else if (type == LSLForwardTypePresent){
        [_navigationController presentViewController:controller animated:YES completion:NULL];
    }
}


+ (void)openLoginPage:(void (^)(LSLLoginViewController *))configureBlock
{
    LSLLoginViewController *pvc = [[LSLLoginViewController alloc] init];
    LSLBaseNavigationController *nav = [[LSLBaseNavigationController alloc] initWithRootViewController:pvc];
    [[LSLForwardService sharedInstance] forwarToViewController:nav type:LSLForwardTypePresent];
    pvc.isPresentViewController = YES;
}

@end

//
//  RHCForwardService+HomeDetail.m
//  iOS跳转解耦
//
//  Created by renren on 5/4/15.
//  Copyright (c) 2015 renren. All rights reserved.
//

#import "LSLForwardService+HomeDetail.h"

@implementation LSLForwardService (HomeDetail)

+ (void)openHomeDetailPage:(void (^)(LSLHomeDetailController *))configureBlock
{
    LSLHomeDetailController *ctl = [[LSLHomeDetailController alloc] initWithConfigureBlock:^(UIViewController *controller) {
        if (configureBlock) {
            configureBlock((LSLHomeDetailController *)controller);
        }
    }];
    
    [[LSLForwardService sharedInstance] forwarToViewController:ctl type:LSLForwardTypePush];
}


@end

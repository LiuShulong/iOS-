//
//  RHCForwardService+HomeDetail.h
//  iOS跳转解耦
//
//  Created by renren on 5/4/15.
//  Copyright (c) 2015 renren. All rights reserved.
//

#import "LSLForwardService.h"

@interface LSLForwardService (HomeDetail)

+ (void)openHomeDetailPage:(void (^)(LSLHomeDetailController *))configureBlock;

@end

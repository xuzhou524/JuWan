//
//  MBProgressHUD+ITTAdditions.h
//  WMCommons
//
//  Copyright (c) 2013年 wumii. All rights reserved.
//

#import <MBProgressHUD/MBProgressHUD.h>

@interface MBProgressHUD (ITTAdditions)
+ (void)showDefaultIndicatorWithText:(NSString *)text;
+ (void)hideDefaultIndicator;

+ (void)hideAllIndicator;
+ (void)showIndicatorMessage:(NSString *)message;
+ (void)showMultilineIndicatorMessage:(NSString *)message;
@end

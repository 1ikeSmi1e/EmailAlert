//
//  EmailInputAlertView.h
//  MobilePaymentOS
//
//  Created by admin on 2018/4/19.
//  Copyright © 2018年 yinsheng. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^EmailInputAlertViewBlock)(NSString *email);
@interface EmailInputAlertView : UIView

+ (void)showWithSendbtnClick:(EmailInputAlertViewBlock)block;
@end

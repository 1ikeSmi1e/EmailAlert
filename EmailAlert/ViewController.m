//
//  ViewController.m
//  EmailAlert
//
//  Created by admin on 2018/4/23.
//  Copyright © 2018年 admin. All rights reserved.
//

#import "ViewController.h"
#import "EmailInputAlertView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (IBAction)send:(id)sender {
    
    [EmailInputAlertView showWithSendbtnClick:^(NSString *email) {
        NSLog(@"发送成功");
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end

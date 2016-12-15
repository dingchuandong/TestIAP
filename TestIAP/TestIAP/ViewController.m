//
//  ViewController.m
//  TestIAP
//
//  Created by dcd on 16/12/15.
//  Copyright © 2016年 ZM. All rights reserved.
//

#import "ViewController.h"
#import "ZM_PersonAiYiViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIButton *goBtn = [[UIButton alloc] initWithFrame:CGRectMake(self.view.frame.size.width/2 - 50, 100, 100, 50)];
    [goBtn setTitle:@"充值页面" forState:UIControlStateNormal];
    goBtn.backgroundColor = [UIColor colorWithRed:255/255.0
                                            green:85/255.0
                                             blue:114/255.0
                                            alpha:1];
    [goBtn addTarget:self action:@selector(go) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:goBtn];
}

- (void) go
{
    ZM_PersonAiYiViewController *zm_personAiyiVC = [[ZM_PersonAiYiViewController alloc] init];
    [self presentViewController:zm_personAiyiVC animated:YES completion:^{
        
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end

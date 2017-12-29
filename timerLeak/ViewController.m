//
//  ViewController.m
//  timerLeak
//
//  Created by admin on 2017/10/18.
//  Copyright © 2017年 sunhua. All rights reserved.
//

#import "ViewController.h"
#import "NextViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(100, 100, 100, 100);
    [btn setTitle:@"点击" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(btnAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
//    UIView *testObject = [[UIView alloc] init];
//    [testObject release];
//    [testObject setNeedsLayout];
}

- (void)btnAction {

    NextViewController *next = [[NextViewController alloc] init];
    //    next.delegate = self;
    [self presentViewController:next animated:YES completion:^{
        
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)delegateTest {
    NSLog(@"----------");
}

@end

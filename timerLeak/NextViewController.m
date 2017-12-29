//
//  NextViewController.m
//  timerLeak
//
//  Created by admin on 2017/10/19.
//  Copyright © 2017年 sunhua. All rights reserved.
//

#import "NextViewController.h"

@interface NextViewController ()

@property (nonatomic, strong) UILabel *timeLab;
@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, strong) NSTimer *timer2;
@property (nonatomic, strong) CADisplayLink *link;
@property (nonatomic, strong) id observer;
@end

@implementation NextViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor yellowColor];
    _timeLab = [[UILabel alloc] init];
    _timeLab.frame = CGRectMake(200, 200, 300, 100);
    _timeLab.textColor = [UIColor blackColor];
    [self.view addSubview:_timeLab];
    id context;
//    [self addObserver:self forKeyPath:@"123" options:0 context:&context];
//    [self removeObserver:self forKeyPath:@"123" context:&context];
    
//    [[NSNotificationCenter defaultCenter] addObserverForName:@"aaaaaaa"
//                                                      object:nil
//                                                       queue:[NSOperationQueue mainQueue]
//                                                  usingBlock:^(NSNotification *note) {
//                                                      NSLog(@"hello:%@",self.timer2);
//                                                  }];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(aaa) name:@"aaaaaaa" object:nil];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"aaaaaaa" object:nil];
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(100, 100, 100, 100);
    [btn setTitle:@"取消" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(btnAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];

    //    [self performSelector:@selector(abcdefg) withObject:nil afterDelay:0.1];
    
//    NSArray *arr = nil;
//    NSDictionary *dic = @{@"123":arr};
    _link = [CADisplayLink displayLinkWithTarget:self selector:@selector(timerAction)];
    if (@available(iOS 10.0, *)) {
        _link.preferredFramesPerSecond = 1;
    } else {
        // Fallback on earlier versions
        _link.frameInterval = 60;
    }
    [_link addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSRunLoopCommonModes];
//    _timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timerAction) userInfo:nil repeats:YES];
//    _timer = [NSTimer timerWithTimeInterval:1 target:self selector:@selector(timerAction) userInfo:nil repeats:YES];
//    NSRunLoop *loop = [NSRunLoop currentRunLoop];
//    [loop addTimer:_timer forMode:NSRunLoopCommonModes];

//    if (@available(iOS 10.0, *)) {
//        _timer = [NSTimer scheduledTimerWithTimeInterval:1 repeats:YES block:^(NSTimer * _Nonnull timer) {
//            NSLog(@"111111");
//        }];
//    } else {
//        // Fallback on earlier versions
//    }
//    _timer2 = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timerAction2) userInfo:nil repeats:YES];
}

- (void)timerAction {
    NSLog(@"time is %@", [NSDate date]);
    _timeLab.text = [NSString stringWithFormat:@"time is %@", [NSDate date]];
}

- (void)timerAction2 {
    NSLog(@"time2 is %@", [NSDate date]);
}

- (void)btnAction {

    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        [self willChangeValueForKey:@"123"];
        sleep(2);
        [self didChangeValueForKey:@"123"];
    });
    [self dismissViewControllerAnimated:YES completion:^{
    }];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    NSLog(@"changed");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)aaa {
    NSLog(@"hello:%@",self.timer2);
}

- (void)dealloc {
    NSLog(@"%@ dealloc", NSStringFromClass([self class]));
}

@end

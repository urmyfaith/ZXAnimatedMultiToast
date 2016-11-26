//
//  ViewController.m
//  ZXAnimatedMultiToast
//
//  Created by zx on 26/11/2016.
//  Copyright © 2016 z2xy. All rights reserved.
//

#import "ViewController.h"
#import "ZXAnimatedMultiToast.h"

@interface ViewController ()
@property(nonatomic, strong) ZXAnimatedMultiToast *multiToast;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor lightGrayColor];

    [self.view addSubview:self.multiToast];
    [self.multiToast makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(80);
        make.centerX.equalTo(self.view);
        make.width.equalTo(150);
        make.height.equalTo(4*35);
    }];
}

-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.multiToast appendMessage:@"toast1111"];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self.multiToast appendMessage:@"toast2222"];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self.multiToast appendMessage:@"toast3333"];
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [self.multiToast appendMessage:@"toast4444"];
                });
            });
        });

    });
}

-(ZXAnimatedMultiToast *)multiToast
{
    if (!_multiToast) {
        _multiToast=  [[ZXAnimatedMultiToast alloc]init];
    }
    return _multiToast;
}
@end

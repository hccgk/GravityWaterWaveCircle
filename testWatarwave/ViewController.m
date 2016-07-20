//
//  ViewController.m
//  testWatarwave
//
//  Created by 川何 on 16/7/19.
//  Copyright © 2016年 川何. All rights reserved.
//

#import "ViewController.h"
#import "SXWaveView.h"  // -----步骤1 引入自定义view头文件
#import <CoreMotion/CoreMotion.h>

#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height
#define SIDES SCREEN_WIDTH/2.0
#define MARGIN SCREEN_WIDTH/4.0
#define COLOR(a,b,c,d) [UIColor colorWithRed:a/255.0 green:b/255.0 blue:c/255.0 alpha:d]

@interface ViewController (){
    UIView *hcview;
    CGFloat x;
    CGFloat y;
}
@property(nonatomic,strong)SXWaveView *animateView8;
@property (strong) CMMotionManager* motionManager;

@end

@implementation ViewController
-(void)viewWillAppear:(BOOL)animated{
    
    [self.animateView8 addAnimateWithType:0];

}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.animateView8 = [[SXWaveView alloc]initWithFrame:CGRectMake(MARGIN, MARGIN,SIDES, SIDES)];
    [self.view addSubview:_animateView8];
    [self.animateView8 setPrecent:70 description:@"年化收益率" textColor:[UIColor whiteColor] bgColor:COLOR(29, 154, 238, 1) alpha:1 clips:YES];
    self.animateView8.endless = YES;
    [self.animateView8 setTextColor:[UIColor whiteColor] bgColor:COLOR(136, 202, 246, 1) waterColor:COLOR(29, 154, 238, 1)];
    [self testTuoLouYi];
    
}

-(void)testTuoLouYi{
    self.motionManager = [[CMMotionManager alloc] init];
    
    self.motionManager.deviceMotionUpdateInterval = 1.0f/30; //1秒10次
    
    hcview = (UIView *)_animateView8.bigImg;
    x = _animateView8.centerx /hcview.width ;
    y = (_animateView8.centery - hcview.frame.origin.y)/hcview.height;
    [self controlHardware];
}

- (void)controlHardware
{
    [self.motionManager startDeviceMotionUpdatesToQueue:[NSOperationQueue currentQueue] withHandler:^(CMDeviceMotion *motion, NSError *error) {
        double rotation = atan2(motion.gravity.x, motion.gravity.y) - M_PI;
        _animateView8.transform = CGAffineTransformMakeRotation(rotation);

    }];
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

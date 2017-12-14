//
//  ViewController.m
//  TwoSidedView
//
//  Created by 蔡强 on 2017/12/12.
//  Copyright © 2017年 kuaijiankang. All rights reserved.
//

#import "ViewController.h"
#import "TwoSidedView.h"

@interface ViewController ()

@property (nonatomic, strong) TwoSidedView *twoSidedView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.view.backgroundColor = [UIColor grayColor];
    
    self.twoSidedView = [[TwoSidedView alloc] initWithFrame:CGRectMake(90, 90, 200, 200)];
    self.twoSidedView.center = self.view.center;
    [self.view addSubview:self.twoSidedView];
    
    UIImageView *topImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"funny"]];
    topImageView.frame =self.twoSidedView.bounds;
    
    UIImageView *bottomImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"nice"]];
    bottomImageView.frame = self.twoSidedView.bounds;
    
    // 设置topView
    self.twoSidedView.topView    = topImageView;
    // 设置bottomView
    self.twoSidedView.bottomView = bottomImageView;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.twoSidedView turnWithDuration:2 completion:^{
        NSLog(@"翻转完成");
    }];
}

@end

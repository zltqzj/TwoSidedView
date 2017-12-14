//
//  TwoSidedView.m
//  TwoSidedView
//
//  Created by 蔡强 on 2017/12/12.
//  Copyright © 2017年 kuaijiankang. All rights reserved.
//

#import "TwoSidedView.h"

@implementation TwoSidedView {
    BOOL _isTurning; // 是否正在翻转
    CGFloat _angle;  // 翻转角度
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        _isTurning = NO;
        _angle = 0;
    }
    return self;
}

/** 设置顶部view */
- (void)setTopView:(UIView *)topView {
    _topView = topView;
    
    [self addSubview:_topView];
    [self bringSubviewToFront:_topView];
}

/** 设置底部view */
- (void)setBottomView:(UIView *)bottomView {
    _bottomView = bottomView;
    
    [self addSubview:_bottomView];
    [self sendSubviewToBack:_bottomView];
    
    _bottomView.hidden = YES; // 默认隐藏
    
    // 翻转180度
    CATransform3D transform = CATransform3DMakeRotation(M_PI, 0, 1, 0);
    _bottomView.layer.transform = transform;
}

/**
 翻转
 
 @param duration 翻转动画所需时间
 @param completion 动画结束后的回调
 */
- (void)turnWithDuration:(NSTimeInterval)duration completion:(void(^)(void))completion{
    if (!self.topView || !self.bottomView) {
        NSAssert(NO, @"未设置topView或bottomView");
    }
    
    // 正在动画中不能重复执行
    if (_isTurning) {
        return;
    }
    _isTurning = YES;
    
    // 动画进行到一半的时候切换要展示的view
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(duration / 2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self.topView.hidden    = !self.topView.hidden;
        self.bottomView.hidden = !self.bottomView.hidden;
    });
    
    // 在之前的基础上翻转180度
    _angle += M_PI;
    [UIView animateWithDuration:duration animations:^{
        CATransform3D transform = CATransform3DMakeRotation(_angle, 0, 1, 0);
        self.layer.transform = transform;
    } completion:^(BOOL finished) {
        _isTurning = NO;
        if (completion) {
            completion();
        }
    }];
}

@end

//
//  TwoSidedView.m
//  TwoSidedView
//
//  Created by 蔡强 on 2017/12/12.
//  Copyright © 2017年 kuaijiankang. All rights reserved.
//

#import "TwoSidedView.h"

@implementation TwoSidedView

/** 设置顶部view */
- (void)setTopView:(UIView *)topView {
    _topView = topView;
    
    [self addSubview:topView];
    [self bringSubviewToFront:_topView];
}

/** 设置底部view */
- (void)setBottomView:(UIView *)bottomView {
    _bottomView = bottomView;
    
    [self addSubview:_bottomView];
    [self sendSubviewToBack:_bottomView];
    
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
    
    // 动画进行到一半的时候将bottomView移到上层
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(duration / 2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self bringSubviewToFront:self.bottomView];
    });
    
    // 翻转180度
    [UIView animateWithDuration:duration animations:^{
        CATransform3D transform = CATransform3DMakeRotation(M_PI, 0, 1, 0);
        self.layer.transform = transform;
    } completion:^(BOOL finished) {
        if (completion) {
            completion();
        }
    }];
}

@end

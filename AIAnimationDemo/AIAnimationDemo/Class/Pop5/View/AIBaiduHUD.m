//
//  AIBaiduHUD.m
//  AIAnimationDemo
//
//  Created by 艾泽鑫 on 2016/10/11.
//  Copyright © 2016年 艾泽鑫. All rights reserved.
//

#import "AIBaiduHUD.h"
#import "AILoadAnimationView.h"
#import "single.h"
@interface AIBaiduHUD ()

/** 提示label*/
@property(nonatomic,weak)UILabel *tipsLable;
/** 动画这块view*/
@property(nonatomic,weak)AILoadAnimationView *animationView;
/** 取消按钮*/
@property(nonatomic,weak)UIButton *cancelButton;
/** 总体宽度*/
@property(nonatomic,assign)CGFloat allWith;
/** 背景图片*/
@property(nonatomic,weak)UIImageView *bgImageView;
@end
@implementation AIBaiduHUD

#pragma mark ----single
singleton_m(AIBaiduHUD)

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self createHub];
    }
    return self;
}
/**
 创建
 */
-(void)createHub{
    UIImageView *bgImageView = [[UIImageView alloc]init];
    bgImageView.userInteractionEnabled = YES;
    self.bgImageView         = bgImageView;
    bgImageView.image        = [UIImage imageNamed:@"search_map_btn"];
    [self addSubview:bgImageView];
    //提示label
    UILabel *tipsLabel      = [[UILabel alloc]init];
    tipsLabel.textAlignment = NSTextAlignmentCenter;
    tipsLabel.text          = @"正在加载。。。";
    self.tipsLable          = tipsLabel;
    [self.bgImageView addSubview:tipsLabel];
    //动画view
    AILoadAnimationView *animationView = [[AILoadAnimationView alloc]init];
    self.animationView                 = animationView;
    [self.bgImageView addSubview:animationView];
    //取消按钮
    UIButton *cancelButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
    self.cancelButton      = cancelButton;
    [cancelButton addTarget:self action:@selector(onClickCancelBtn:) forControlEvents:(UIControlEventTouchUpInside)];
    [self.bgImageView addSubview:cancelButton];
    [cancelButton setImage:[UIImage imageNamed:@"dialog_cancel"] forState:(UIControlStateNormal)];
}

-(void)layoutSubviews{
    [super layoutSubviews];
    //背景图
    self.bgImageView.frame   = self.bounds;
    //动画view
    CGFloat animationViewW   = 100;
    CGFloat animationViewH   = 100;
    CGFloat animationViewX   = 0;
    CGFloat animationViewY   = 0;
    self.animationView.frame = CGRectMake(animationViewX,
                                          animationViewY,
                                          animationViewW,
                                          animationViewH);
    //label
    CGFloat tipsLabelX       = CGRectGetMaxX(self.animationView.frame);
    CGFloat tipsLabelY       = 0;
    CGFloat tipsLabelW       = 100;
    CGFloat tipsLabelH       = animationViewH;
    self.tipsLable.frame     = CGRectMake(tipsLabelX,
                                          tipsLabelY,
                                          tipsLabelW,
                                          tipsLabelH);
    //取消按钮
    CGFloat cacelBtnX        = CGRectGetMaxX(self.tipsLable.frame);
    CGFloat cacelBtnY        = 0;
    CGFloat cacelBtnW        = 50;
    CGFloat cacelBtnH        = animationViewH;
    self.cancelButton.frame  = CGRectMake(cacelBtnX, cacelBtnY, cacelBtnW, cacelBtnH);
    //总体宽度
    self.allWith = animationViewW + tipsLabelW + cacelBtnW;
}
#pragma mark ---相应事件
-(void)onClickCancelBtn:(UIButton *)btn{
    [AIBaiduHUD dissmis];
}

#pragma mark ---类方法
+(void)show{
    AIBaiduHUD *hud            = [AIBaiduHUD sharedAIBaiduHUD];
    [hud.animationView startGlow];
    hud.frame                  = CGRectMake(0, 0, hud.allWith, 100);
    UIApplication *application = [UIApplication sharedApplication];
    UIWindow *lastWindow       = [application.windows lastObject];
    hud.center                 = lastWindow.center;
    
    [lastWindow addSubview:hud];
}
+(void)dissmis{
    [[AIBaiduHUD sharedAIBaiduHUD].animationView resetGlow];
    [[AIBaiduHUD sharedAIBaiduHUD]removeFromSuperview];
}



@end
//
//  WGViewController.m
//  WGDigitField
//
//  Created by 王冠宇 on 10/19/2018.
//  Copyright (c) 2018 王冠宇. All rights reserved.
//

#import "WGViewController.h"

@import WGDigitField;
@import Masonry;

@interface BackgroundWithBottomLine : UIView

@property (nonatomic, strong) UIView *bottomLine;

+ (instancetype)create;

@end

@implementation BackgroundWithBottomLine

+ (instancetype)create {
    BackgroundWithBottomLine *background = [[BackgroundWithBottomLine alloc] initWithFrame:CGRectMake(0, 0, 40, 45)];
    background.bottomLine = [[UIView alloc] init];
    background.bottomLine.backgroundColor = [UIColor grayColor];
    [background addSubview:background.bottomLine];
    [background.bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.and.bottom.equalTo(@0);
        make.height.equalTo(@1);
    }];
    return background;
}

@end

@interface WGViewController ()

@end

@implementation WGViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    WGDigitField<WGDigitView<UIView *> *> *field = [[WGDigitField<WGDigitView<UIView *> *> alloc] initWithDigitViewInitBlock:^WGDigitView<UIView *> * (NSInteger index){
        UIView *background = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 40, 45)];
        background.backgroundColor = [UIColor whiteColor];
        background.layer.borderColor = [UIColor grayColor].CGColor;
        background.layer.borderWidth = 1.f;
        background.layer.cornerRadius = 3.f;
        
        return [[WGDigitView<UIView *> alloc] initWithBackgroundView:background digitFont:[UIFont systemFontOfSize:25.f] digitColor:[UIColor blackColor]];
    } numberOfDigits:6 leadSpacing:25 tailSpacing:25 weakenBlock:^(WGDigitView<UIView *> * _Nonnull digitView) {
        digitView.backgroundView.layer.borderColor = [UIColor grayColor].CGColor;
        digitView.backgroundView.layer.borderWidth = 1.f;
    } highlightedBlock:^(WGDigitView<UIView *> * _Nonnull digitView) {
        digitView.backgroundView.layer.borderColor = [UIColor redColor].CGColor;
        digitView.backgroundView.layer.borderWidth = 2.f;
        
        CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"transform.translation.y"];
        animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
        animation.duration = 0.6;
        animation.values = @[@(-20.0), @20.0, @(-20.0), @20.0, @(-10.0), @10.0, @(-5.0), @(5.0), @(0.0)];
        [digitView.layer addAnimation:animation forKey:@"shake.animation"];
    } fillCompleteBlock:^(WGDigitField * _Nonnull digitField, NSArray<WGDigitView<UIView *> *> * _Nonnull digitViewArray, NSString * _Nonnull text) {
        for (WGDigitView<UIView *> *digitView in digitViewArray) {
            CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"backgroundColor"];
            animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
            animation.duration = 1.0;
            animation.values = @[(id)[UIColor whiteColor].CGColor, (id)[UIColor redColor].CGColor, (id)[UIColor whiteColor].CGColor];
            [digitView.backgroundView.layer addAnimation:animation forKey:@"background.animation"];
        }
        [digitField resignFirstResponder];
    }];
    
    [self.view addSubview:field];
    [field mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.and.trailing.equalTo(@0);
        make.top.equalTo(@100);
        make.height.equalTo(@(45 + 2 * 17));
    }];
    
    // ----------------------
    
    WGDigitField<WGDigitView<BackgroundWithBottomLine *> *> *field2 = [[WGDigitField<WGDigitView<BackgroundWithBottomLine *> *> alloc] initWithDigitViewInitBlock:^WGDigitView<BackgroundWithBottomLine *> * (NSInteger index){
        BackgroundWithBottomLine *background2 = [BackgroundWithBottomLine create];
        
        return [[WGDigitView<BackgroundWithBottomLine *> alloc] initWithBackgroundView:background2 digitFont:[UIFont systemFontOfSize:25.f] digitColor:[UIColor blackColor]];
    } numberOfDigits:6 leadSpacing:25 tailSpacing:25 weakenBlock:^(WGDigitView<BackgroundWithBottomLine *> * _Nonnull digitView) {
        digitView.backgroundView.bottomLine.backgroundColor = [UIColor grayColor];
    } highlightedBlock:^(WGDigitView<BackgroundWithBottomLine *> * _Nonnull digitView) {
        digitView.backgroundView.bottomLine.backgroundColor = [UIColor redColor];
    } fillCompleteBlock:^(WGDigitField * _Nonnull digitField, NSArray<WGDigitView<BackgroundWithBottomLine *> *> * _Nonnull digitViewArray, NSString * _Nonnull text) {
        for (WGDigitView<BackgroundWithBottomLine *> *digitView in digitViewArray) {
            CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"transform.translation.x"];
            animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
            animation.duration = 0.6;
            animation.values = @[@(-20.0), @20.0, @(-20.0), @20.0, @(-10.0), @10.0, @(-5.0), @(5.0), @(0.0)];
            [digitView.backgroundView.layer addAnimation:animation forKey:@"shake.animation"];
        }
        [digitField resignFirstResponder];
    }];

    [self.view addSubview:field2];
    [field2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.and.trailing.equalTo(@0);
        make.top.equalTo(field.mas_bottom).with.offset(20);
        make.height.equalTo(@(45 + 2 * 17));
    }];
}

@end

// WGDigitField<WGDigitView<UIView *> *> means you have to initialize this WGDigitField with an instance of WGDigitView<UIView *> as digitView
//WGDigitField<WGDigitView<UIView *> *> *field = [[WGDigitField<WGDigitView<UIView *> *> alloc] initWithDigitViewInitBlock:^WGDigitView<UIView *> * (NSInteger index){
//    // initializing a background view (UIView or any subclass of UIView if you want)
//    UIView *background = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 40, 45)];
//    background.backgroundColor = [UIColor whiteColor];
//    background.layer.borderColor = [UIColor grayColor].CGColor;
//    background.layer.borderWidth = 1.f;
//    background.layer.cornerRadius = 3.f;
//    // `WGDigitView<UIView *>` means you have to initialize this WGDigitView with an instance of UIView as backgroundView
//    return [[WGDigitView<UIView *> alloc] initWithBackgroundView:background digitFont:[UIFont systemFontOfSize:25.f] digitColor:[UIColor blackColor]];
//
//} numberOfDigits:6 leadSpacing:25 tailSpacing:25 weakenBlock:^(WGDigitView<UIView *> * _Nonnull digitView) {
//    // getting it normal
//    digitView.backgroundView.layer.borderColor = [UIColor grayColor].CGColor;
//    digitView.backgroundView.layer.borderWidth = 1.f;
//
//} highlightedBlock:^(WGDigitView<UIView *> * _Nonnull digitView) {
//    // making some UI changes
//    digitView.backgroundView.layer.borderColor = [UIColor redColor].CGColor;
//    digitView.backgroundView.layer.borderWidth = 2.f;
//    // or implementing animations
//    CAKeyframeAnimation *animation = ...
//} fillCompleteBlock:^(WGDigitField * _Nonnull digitField, NSArray<WGDigitView<UIView *> *> * _Nonnull digitViewArray, NSString * _Nonnull text) {
//    // dismissing keyboard and starting requests
//    [digitField resignFirstResponder];
//}];

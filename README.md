# WGDigitField

[![CI Status](https://img.shields.io/travis/王冠宇/WGDigitField.svg?style=flat)](https://travis-ci.org/王冠宇/WGDigitField)
[![Version](https://img.shields.io/cocoapods/v/WGDigitField.svg?style=flat)](https://cocoapods.org/pods/WGDigitField)
[![License](https://img.shields.io/cocoapods/l/WGDigitField.svg?style=flat)](https://cocoapods.org/pods/WGDigitField)
[![Platform](https://img.shields.io/cocoapods/p/WGDigitField.svg?style=flat)](https://cocoapods.org/pods/WGDigitField)

## Overview

**WGDigitField** is a customizable digit input control for iOS. You can initialize a powerful digit input control with a very simple way. 

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Features

* Customizable style for every single digit view.
* Customizable animation for highlighting and unhighlighting digit view. 
* Supporting autofill for iOS 12. 

<div align=center>
<img src=https://s1.ax1x.com/2018/10/20/i0qmqO.gif width=200/>
</div>

## Installation

WGDigitField is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'WGDigitField'
```

## How To Use

```objectivec
// WGDigitField<WGDigitView<UIView *> *> means you have to initialize this WGDigitField with an instance of WGDigitView<UIView *> as digitView
WGDigitField<WGDigitView<UIView *> *> *field = [[WGDigitField<WGDigitView<UIView *> *> alloc] initWithDigitViewInitBlock:^WGDigitView<UIView *> * (NSInteger index){
    // initializing a background view (UIView or any subclass of UIView if you want)
    UIView *background = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 40, 45)];
    background.backgroundColor = [UIColor whiteColor];
    background.layer.borderColor = [UIColor grayColor].CGColor;
    background.layer.borderWidth = 1.f;
    background.layer.cornerRadius = 3.f;
    // `WGDigitView<UIView *>` means you have to initialize this WGDigitView with an instance of UIView as backgroundView
    return [[WGDigitView<UIView *> alloc] initWithBackgroundView:background digitFont:[UIFont systemFontOfSize:25.f] digitColor:[UIColor blackColor]];

} numberOfDigits:6 leadSpacing:25 tailSpacing:25 weakenBlock:^(WGDigitView<UIView *> * _Nonnull digitView) {
    // getting it normal
    digitView.backgroundView.layer.borderColor = [UIColor grayColor].CGColor;
    digitView.backgroundView.layer.borderWidth = 1.f;

} highlightedBlock:^(WGDigitView<UIView *> * _Nonnull digitView) {
    // making some UI changes
    digitView.backgroundView.layer.borderColor = [UIColor redColor].CGColor;
    digitView.backgroundView.layer.borderWidth = 2.f;
    // or implementing animations
    CAKeyframeAnimation *animation = ...
} fillCompleteBlock:^(WGDigitField * _Nonnull digitField, NSArray<WGDigitView<UIView *> *> * _Nonnull digitViewArray, NSString * _Nonnull text) {
    // dismissing keyboard and starting requests
    [digitField resignFirstResponder];
}];
```

## Author

王冠宇, Weibo: [@冠宇住在贝克街](http://weibo.com/131471169)

## License

WGDigitField is available under the MIT license. See the LICENSE file for more info.

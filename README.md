# WGDigitField

[![CI Status](https://img.shields.io/travis/王冠宇/WGDigitField.svg?style=flat)](https://travis-ci.org/王冠宇/WGDigitField)
[![Version](https://img.shields.io/cocoapods/v/WGDigitField.svg?style=flat)](https://cocoapods.org/pods/WGDigitField)
[![License](https://img.shields.io/cocoapods/l/WGDigitField.svg?style=flat)](https://cocoapods.org/pods/WGDigitField)
[![Platform](https://img.shields.io/cocoapods/p/WGDigitField.svg?style=flat)](https://cocoapods.org/pods/WGDigitField)

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Features

* Customizable style for every single digit view.
* Customizable animation for highlighting and unhighlighting digit view. 
* Supporting autofill for iOS 12. 

<div align=center>
<img src=https://s1.ax1x.com/2018/10/19/iwvqAS.png width=200/>
</div>

## Installation

WGDigitField is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'WGDigitField'
```

## How To Use

1. Create a background view (any kind of UIView you want)
```objectivec
UIView *background = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 40, 45)];
background.backgroundColor = [UIColor whiteColor];
background.layer.borderColor = [UIColor grayColor].CGColor;
background.layer.borderWidth = 1.f;
background.layer.cornerRadius = 3.f;
```

2. Create a digit view
```objectivec
WGDigitView *view = [[WGDigitView alloc] initWithBackgroundView:background digitFont:[UIFont systemFontOfSize:25.f] digitColor:[UIColor blackColor]];
```

3. Get a digit field
```objectivec
WGDigitField *field = [[WGDigitField alloc] initWithSingleDigitView:view numberOfDigits:6 leadSpacing:25.f tailSpacing:25.f weakenBlock:^(WGDigitView * _Nonnull digitView) {
    digitView.backgroundView.layer.borderColor = [UIColor grayColor].CGColor;
    digitView.backgroundView.layer.borderWidth = 1.f;
} highlightedBlock:^(WGDigitView * _Nonnull digitView) {
    digitView.backgroundView.layer.borderColor = [UIColor redColor].CGColor;
    digitView.backgroundView.layer.borderWidth = 2.f;
} fillCompleteBlock:^(WGDigitField * _Nonnull digitFiled, NSString * _Nonnull text) {
    [digitFiled resignFirstResponder];
}];
```

That's all. So easy, right?

## Author

王冠宇, wangguanyu@mobike.com

## License

WGDigitField is available under the MIT license. See the LICENSE file for more info.

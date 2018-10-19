//
//  WGDigitView.m
//  WGDigitField
//
//  Created by 王冠宇 on 2018/10/19.
//

#import "WGDigitView.h"

@import Masonry;

@implementation WGDigitView

- (instancetype)initWithBackgroundView:(UIView *)view
                             digitFont:(UIFont *)font
                            digitColor:(UIColor *)color {
    if (self = [super initWithFrame:view.frame]) {
        _backgroundView = view;
        
        _digitLabel = [[UILabel alloc] init];
        _digitLabel.font = font;
        _digitLabel.textColor = color;
        _digitLabel.textAlignment = NSTextAlignmentCenter;
        _digitLabel.numberOfLines = 1;
        
        [_backgroundView addSubview:_digitLabel];
        [_digitLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(self.backgroundView);
            make.edges.equalTo(self.backgroundView);
        }];
        
        [self addSubview:_backgroundView];
        [_backgroundView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self);
        }];
    }
    return self;
}

- (id)copyWithZone:(NSZone *)zone {
    UIView *backgroundView = [[UIView alloc] initWithFrame:self.backgroundView.frame];
    backgroundView.layer.borderColor = self.backgroundView.layer.borderColor;
    backgroundView.layer.borderWidth = self.backgroundView.layer.borderWidth;
    backgroundView.backgroundColor = self.backgroundView.backgroundColor;
    backgroundView.layer.cornerRadius = self.backgroundView.layer.cornerRadius;
    backgroundView.layer.masksToBounds = self.backgroundView.layer.masksToBounds;
    
    WGDigitView *copy = [[[self class] allocWithZone:zone] initWithBackgroundView:backgroundView digitFont:self.digitLabel.font digitColor:self.digitLabel.textColor];
    return copy;
}

- (BOOL)hasText {
    return self.digitLabel.text.length != 0;
}

- (NSString *)text {
    return self.digitLabel.text;
}

- (void)setText:(NSString *)text {
    // Only "0-9"(ASCII) and "" is allowed.
    if ([[NSPredicate predicateWithFormat:@"SELF MATCHES %@", @"^[0-9]$"] evaluateWithObject:text] || text.length == 0) {
        self.digitLabel.text = text;
    }
}

@end

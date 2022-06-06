//
//  TDCameraPreview.m
//  hello_tooth
//
//  Created by liu nian on 2022/6/6.
//

#import "TDCameraPreview.h"

@interface TDCameraPreview ()
@property (nonatomic, strong) UILabel *textLabel;

@end
@implementation TDCameraPreview

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
        [self addGestureRecognizer:tap];
    }
    return self;
}


- (void)tapAction:(UITapGestureRecognizer *)tap {
    if ([_delegate respondsToSelector:@selector(viewDidTapWithPreview:)]) {
        [_delegate viewDidTapWithPreview:self];
    }
}

#pragma mark setter
- (void)layoutSubviews {
    [super layoutSubviews];
    self.textLabel.frame = self.bounds;
    
}
- (void)setPlainText:(NSString *)plainText {
    if (_plainText != plainText) {
        _plainText = plainText;
        self.textLabel.text = plainText;
    }
}

#pragma mark getter
- (UILabel *)textLabel {
    if (!_textLabel) {
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 300, 60)];
        label.textColor = [UIColor whiteColor];
        [self addSubview:label];
        _textLabel = label;
    }
    return _textLabel;
}

@end

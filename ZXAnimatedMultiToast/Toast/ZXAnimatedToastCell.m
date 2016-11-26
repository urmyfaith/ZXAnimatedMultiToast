//
//  ZXAnimatedToastCell.m
//  ZXAnimatedMultiToast
//
//  Created by zx on 25/11/2016.
//  Copyright © 2016 z2xy. All rights reserved.
//

#import "ZXAnimatedToastCell.h"

@interface ZXAnimatedToastCell()
@property(nonatomic, strong) UILabel *messageLabel;
@end


@implementation ZXAnimatedToastCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {

        self.backgroundColor = [UIColor clearColor];
        self.contentView.backgroundColor =  [UIColor clearColor];
        [self.contentView addSubview:self.messageLabel];

        [self.messageLabel makeConstraints:^(MASConstraintMaker *make) {
            make.leading.trailing.top.equalTo(self.contentView);
            make.bottom.equalTo(self.contentView).offset(-10);
        }];
    }
    return self;
}

+(CGFloat)cellHeight
{
    return 35.0;
}

- (void)tableView:(UITableView *)tableView
forRowAtIndexPath:(NSIndexPath *)indexPath
   animationStyle:(UITableViewCellDisplayAnimationStyle)animationStyle {
    switch (animationStyle) {
        case UITableViewCellDisplayAnimationTop: {
            CGRect originFrame = self.frame;
            CGRect frame = self.frame;
            frame.origin.y = -frame.size.height;
            self.frame = frame;

            NSTimeInterval duration = 0.3;
            [UIView animateWithDuration:duration animations:^{
                self.frame = originFrame;
            } completion:nil];
            break;
        }
        case UITableViewCellDisplayAnimationAlpla:
        {
            self.contentView.alpha = 1.0;
            [UIView animateWithDuration:0.3 animations:^{
                self.contentView.alpha = 0.0;
            } completion:nil];
            break;
        }
        default:
            break;
    }
}

-(void)layoutSubviews
{
    [super layoutSubviews];

    self.messageLabel.layer.masksToBounds = YES;
    self.messageLabel.layer.cornerRadius = 6;
    
}
-(void)setMessage:(NSString *)msg;
{
    self.messageLabel.text = msg;
}

-(UILabel *)messageLabel{
    if (!_messageLabel) {
        _messageLabel = [[UILabel alloc]init];
        _messageLabel.textColor = [UIColor whiteColor];
        _messageLabel.backgroundColor = [UIColor colorWithWhite:0 alpha:0.6];
        _messageLabel.font = [UIFont systemFontOfSize:12];
        _messageLabel.textAlignment = NSTextAlignmentCenter;

    }
    return _messageLabel;
}
@end

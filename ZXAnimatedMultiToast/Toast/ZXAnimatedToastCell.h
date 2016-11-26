//
//  ZXAnimatedToastCell.h
//  ZXAnimatedMultiToast
//
//  Created by zx on 25/11/2016.
//  Copyright © 2016 z2xy. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSInteger, UITableViewCellDisplayAnimationStyle) {
    UITableViewCellDisplayAnimationTop,
    UITableViewCellDisplayAnimationAlpla,
};
@interface ZXAnimatedToastCell : UITableViewCell
+(CGFloat)cellHeight;
-(void)setMessage:(NSString *)msg;
-(void)tableView:(UITableView *)tableView forRowAtIndexPath:(NSIndexPath *)indexPath
  animationStyle:(UITableViewCellDisplayAnimationStyle)animationStyle;
@end

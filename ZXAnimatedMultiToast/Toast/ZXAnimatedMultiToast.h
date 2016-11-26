//
//  ZXAnimatedMultiToast.h
//  ZXAnimatedMultiToast
//
//  Created by zx on 25/11/2016.
//  Copyright © 2016 z2xy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZXAnimatedMultiToast : UIView

//config: default -> 4
@property(nonatomic, assign) NSInteger maxCellCount;

//API
-(void)appendMessage:(NSString *)message;

-(CGFloat)cellHeight;

//cleanup
-(void)removeTimer;
@end

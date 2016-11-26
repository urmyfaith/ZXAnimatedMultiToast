//
//  ZXAnimatedMultiToast.h
//  ZXAnimatedMultiToast
//
//  Created by zx on 25/11/2016.
//  Copyright © 2016 z2xy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZXAnimatedMultiToast : UIView

//config: default -> 4 cells
@property(nonatomic, assign) NSInteger maxCellCount;

//config: default -> 2s
@property(nonatomic, assign) CGFloat dissmisDuration;

//API
-(void)appendMessage:(NSString *)message;

-(CGFloat)cellHeight;

//cleanup
-(void)removeTimer;
@end

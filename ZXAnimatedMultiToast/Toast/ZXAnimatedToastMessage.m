//
//  ZXAnimatedToastMessage.m
//  ZXAnimatedMultiToast
//
//  Created by zx on 25/11/2016.
//  Copyright © 2016 z2xy. All rights reserved.
//

#import "ZXAnimatedToastMessage.h"

@implementation ZXAnimatedToastMessage
-(instancetype)initWithMessage:(NSString *)msg
{
    if (self = [super init]) {
        self.message = msg;
        self.status = ZXAnimatedToastMessageStatusNeedDisplay;
    }
    return self;
}
@end

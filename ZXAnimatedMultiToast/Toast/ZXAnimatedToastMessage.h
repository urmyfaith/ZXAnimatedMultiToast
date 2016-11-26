//
//  ZXAnimatedToastMessage.h
//  ZXAnimatedMultiToast
//
//  Created by zx on 25/11/2016.
//  Copyright © 2016 z2xy. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger,ZXAnimatedToastMessageStatus){
    ZXAnimatedToastMessageStatusNeedDisplay,
    ZXAnimatedToastMessageStatusDisplaying,
};

@interface ZXAnimatedToastMessage : NSObject
@property(nonatomic, strong) NSString *message;
@property(nonatomic, assign) ZXAnimatedToastMessageStatus status;
-(instancetype)initWithMessage:(NSString *)msg;
@end

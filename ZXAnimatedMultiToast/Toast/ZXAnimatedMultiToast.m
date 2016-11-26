//
//  ZXAnimatedMultiToast.m
//  ZXAnimatedMultiToast
//
//  Created by zx on 25/11/2016.
//  Copyright © 2016 z2xy. All rights reserved.
//

#import "ZXAnimatedMultiToast.h"
#import "ZXAnimatedToastCell.h"
#import "ZXAnimatedToastMessage.h"

@interface ZXAnimatedMultiToast()<UITableViewDelegate,UITableViewDataSource>
{
    BOOL isAnimating;
}
@property(nonatomic, strong) UITableView *tableView;
@property(nonatomic, strong,readwrite) NSMutableArray *rows;
@property(nonatomic, strong) NSTimer *timer;
@end

@implementation ZXAnimatedMultiToast

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.userInteractionEnabled = NO;
        self.backgroundColor = [UIColor clearColor];
        [self bulidHierarchy];
        [self buildConstraints];

        self.timer = [NSTimer scheduledTimerWithTimeInterval:2.0f target:self selector:@selector(checkRows) userInfo:nil repeats:YES];
        [self stopTimer];

        self.maxCellCount = 4;
    }
    return self;
}


-(void)bulidHierarchy
{
    [self addSubview:self.tableView];
}

-(void)buildConstraints
{
    [self.tableView makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
}

#pragma mark - Timer
-(void)checkRows
{
    ZXAnimatedToastMessage *message = [self.rows lastObject];
    if (message) {
        NSLog(@"msg=%@ deleted",message.message);
        NSUInteger index = [self.rows indexOfObject:message];
        if (index != NSNotFound) {
            NSIndexPath *indexpath = [NSIndexPath indexPathForRow:index inSection:0];

            [self.tableView beginUpdates];
            [self.rows removeLastObject];
            [self.tableView deleteRowsAtIndexPaths:@[indexpath] withRowAnimation:UITableViewRowAnimationFade];
            [self.tableView endUpdates];
        }
    }else{
        NSLog(@"timer stoped");
        [self stopTimer];
    }
}

-(void)stopTimer
{
    [self.timer pauseTimer];
}


-(void)removeTimer
{
    [self.timer invalidate];
    self.timer = nil;
}

#pragma mark - API
-(void)appendMessage:(NSString *)message
{
    for (ZXAnimatedToastMessage *row in self.rows) {
        if (row.status == ZXAnimatedToastMessageStatusNeedDisplay) {
            NSLog(@"msg=%@ can not waite to display",row.message);
            row.status = ZXAnimatedToastMessageStatusDisplaying;
        }
    }

    {//inset new row;
        [self.tableView beginUpdates];
        ZXAnimatedToastMessage *msg = [[ZXAnimatedToastMessage alloc]initWithMessage:message ];

        [self.rows insertObject:msg atIndex:0];
        [self.tableView insertRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:0 inSection:0]] withRowAnimation:UITableViewRowAnimationTop];
        [self.tableView endUpdates];
    }

    {// delete more row if needed;

        if (self.rows.count > self.maxCellCount) {
            NSMutableArray *indexPathArray = [NSMutableArray array];
            NSMutableArray *rowArray = [NSMutableArray array];
            [self.rows enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                if (idx > self.maxCellCount - 1) {
                    [indexPathArray addObject:[NSIndexPath indexPathForRow:idx inSection:0]];
                    [rowArray addObject:obj];
                }
            }];
            if(indexPathArray.count >0 ){
                [self.tableView beginUpdates];
                [self.rows removeObjectsInArray:rowArray];
                [self.tableView deleteRowsAtIndexPaths:indexPathArray withRowAnimation:UITableViewRowAnimationFade];
                [self.tableView endUpdates];
            }
        }
    }

    [self stopTimer];
    [self.timer resumeTimerAfterTimeInterval:2.0];
}

#pragma mark - UITableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.rows.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [ZXAnimatedToastCell cellHeight];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ZXAnimatedToastCell *cell  = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([ZXAnimatedToastCell class])];
    ZXAnimatedToastMessage *msg  = self.rows[indexPath.row];
    [cell setMessage:msg.message];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    ZXAnimatedToastMessage *msg  = self.rows[indexPath.row];
    if (msg.status == ZXAnimatedToastMessageStatusNeedDisplay) {
        NSLog(@"msg=%@ NeedDisplay-> Displaying",msg.message);
        [(ZXAnimatedToastCell*)cell tableView:tableView
                            forRowAtIndexPath:indexPath
                               animationStyle:UITableViewCellDisplayAnimationTop];
        msg.status = ZXAnimatedToastMessageStatusDisplaying;
    }
}

#pragma mark - Getter
-(UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectZero];
        [_tableView registerClass:[ZXAnimatedToastCell class] forCellReuseIdentifier:NSStringFromClass([ZXAnimatedToastCell class])];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _tableView;
}

-(NSMutableArray *)rows{
    if (!_rows) {
        _rows = [NSMutableArray array];
    }
    return _rows;
}
@end

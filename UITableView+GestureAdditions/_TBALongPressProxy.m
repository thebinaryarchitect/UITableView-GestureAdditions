//
//  _TBALongPressProxy.m
//  UITableView+GestureAdditions
//
//  Copyright (C) 2015 Xiao Yao. All Rights Reserved.
//  See LICENSE.txt for more information.
//

#import "_TBALongPressProxy.h"

#pragma mark - _TBALongPressProxy

#pragma mark - Private Interface

@interface _TBALongPressProxy()
@end

#pragma mark - Public Implementation

@implementation _TBALongPressProxy

#pragma mark Lifecycle

- (instancetype)initWithTableView:(UITableView *)tableView {
    self = [super init];
    if (self) {
        self.tableView = tableView;
    }
    return self;
}

@end

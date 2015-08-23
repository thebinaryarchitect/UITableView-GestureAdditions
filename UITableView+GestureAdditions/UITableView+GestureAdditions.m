//
//  UITableView+GestureAdditions.m
//  UITableView+GestureAdditions
//
//  Copyright (C) 2015 Xiao Yao. All Rights Reserved.
//  See LICENSE.txt for more information.
//

#import "UITableView+GestureAdditions.h"
#import "_TBALongPressProxy.h"
#import <objc/runtime.h>

#pragma mark - UITableView

#pragma mark - Public Implementation (GestureAdditions)

@implementation UITableView (GestureAdditions)
@dynamic longPressProxy;
@dynamic enableLongPressReorder;
@dynamic minimumPressDuration;

#pragma mark - LongPressProxy

- (_TBALongPressProxy *)longPressProxy {
    _TBALongPressProxy *proxy = objc_getAssociatedObject(self, @selector(longPressProxy));
    if (!proxy) {
        proxy = [[_TBALongPressProxy alloc] initWithTableView:self];
        self.longPressProxy = proxy;
    }
    return proxy;
}

- (void)setLongPressProxy:(_TBALongPressProxy *)longPressProxy {
    objc_setAssociatedObject(self, @selector(longPressProxy), longPressProxy, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (BOOL)enableLongPressReorder {
    return self.longPressProxy.enabled;
}

- (void)setEnableLongPressReorder:(BOOL)enableLongPressReorder {
    self.longPressProxy.enabled = enableLongPressReorder;
}

- (CGFloat)minimumPressDuration {
    return self.longPressProxy.longPressGestureRecognizer.minimumPressDuration;
}

- (void)setMinimumPressDuration:(CGFloat)minimumPressDuration {
    self.longPressProxy.longPressGestureRecognizer.minimumPressDuration = minimumPressDuration;
}

@end

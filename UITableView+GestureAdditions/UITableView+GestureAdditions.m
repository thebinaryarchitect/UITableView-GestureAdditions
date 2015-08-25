//
//  UITableView+GestureAdditions.m
//  UITableView+GestureAdditions
//
//  Copyright (C) 2015 Xiao Yao. All Rights Reserved.
//  See LICENSE.txt for more information.
//

#import "UITableView+GestureAdditions.h"
#import "_TBAHorizontalPanProxy.h"
#import "_TBALongPressProxy.h"
#import <objc/runtime.h>

#pragma mark - UITableView

#pragma mark - Public Implementation (GestureAdditions)

@implementation UITableView (GestureAdditions)
@dynamic gestureDelegate;
@dynamic enableLongPressReorder;
@dynamic minimumPressDuration;
@dynamic enableHorizontalPan;
@dynamic minimumHorizontalOffset;
@dynamic maximumHorizontalOffset;

#pragma mark - LongPressProxy

- (id<UITableViewGestureDelegate>)gestureDelegate {
    return objc_getAssociatedObject(self, @selector(gestureDelegate));
}

- (void)setGestureDelegate:(id<UITableViewGestureDelegate>)gestureDelegate {
    objc_setAssociatedObject(self, @selector(gestureDelegate), gestureDelegate, OBJC_ASSOCIATION_ASSIGN);
}

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

#pragma mark HorizontalPanProxy

- (_TBAHorizontalPanProxy *)horizontalPanProxy {
    _TBAHorizontalPanProxy *proxy = objc_getAssociatedObject(self, @selector(horizontalPanProxy));
    if (!proxy) {
        proxy = [[_TBAHorizontalPanProxy alloc] initWithTableView:self];
        self.horizontalPanProxy = proxy;
    }
    return proxy;
}

- (void)setHorizontalPanProxy:(_TBAHorizontalPanProxy *)horizontalPanProxy {
    objc_setAssociatedObject(self, @selector(horizontalPanProxy), horizontalPanProxy, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (BOOL)enableHorizontalPan {
    return self.horizontalPanProxy.enabled;
}

- (void)setEnableHorizontalPan:(BOOL)enableHorizontalPan {
    self.horizontalPanProxy.enabled = enableHorizontalPan;
}

- (CGFloat)minimumHorizontalOffset {
    return self.horizontalPanProxy.minimumHorizontalOffset;
}

- (void)setMinimumHorizontalOffset:(CGFloat)minimumHorizontalOffset {
    self.horizontalPanProxy.minimumHorizontalOffset = minimumHorizontalOffset;
}

- (CGFloat)maximumHorizontalOffset {
    return self.horizontalPanProxy.maximumHorizontalOffset;
}

- (void)setMaximumHorizontalOffset:(CGFloat)maximumHorizontalOffset {
    self.horizontalPanProxy.maximumHorizontalOffset = maximumHorizontalOffset;
}

@end

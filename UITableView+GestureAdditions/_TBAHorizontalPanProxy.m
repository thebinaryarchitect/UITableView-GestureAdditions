//
//  _TBAHorizontalPanProxy.m
//  UITableView+GestureAdditions
//
//  Copyright (C) 2015 Xiao Yao. All Rights Reserved.
//  See LICENSE.txt for more information.
//

#import "_TBAHorizontalPanProxy.h"

#pragma mark - _TBAHorizontalPanProxy

#pragma mark - Public Implementation

@implementation _TBAHorizontalPanProxy

#pragma mark Lifecycle

- (instancetype)initWithTableView:(UITableView *)tableView {
    self = [super init];
    if (self) {
        self.tableView = tableView;
        
        UIPanGestureRecognizer *panRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePan:)];
        panRecognizer.delegate = self;
        [tableView addGestureRecognizer:panRecognizer];
        [tableView.panGestureRecognizer requireGestureRecognizerToFail:panRecognizer];
        self.panGestureRecognizer = panRecognizer;
        
        self.minimumHorizontalOffset = -tableView.frame.size.width;
        self.maximumHorizontalOffset = -tableView.frame.size.height;
    }
    return self;
}

#pragma mark Property Overrides

- (void)setEnabled:(BOOL)enabled {
    if (_enabled != enabled) {
        _enabled = enabled;
        if (_enabled) {
            [self.tableView addGestureRecognizer:self.panGestureRecognizer];
            [self.tableView.panGestureRecognizer requireGestureRecognizerToFail:self.panGestureRecognizer];
        } else {
            [self.tableView removeGestureRecognizer:self.panGestureRecognizer];
        }
    }
}

#pragma mark Private

- (void)handlePan:(UIPanGestureRecognizer *)recognizer {
    switch (recognizer.state) {
        case UIGestureRecognizerStateBegan: {
            CGPoint touchLocation = [recognizer locationInView:recognizer.view];
            NSIndexPath *indexPath = [self.tableView indexPathForRowAtPoint:touchLocation];
            UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
            self.selectedTableViewCell = cell;
            break;
        }
        case UIGestureRecognizerStateChanged: {
            CGPoint translation = [recognizer translationInView:recognizer.view];
            CGRect frame = self.selectedTableViewCell.frame;
            frame.origin.x += translation.x;
            frame.origin.x = MAX(frame.origin.x, self.minimumHorizontalOffset);
            frame.origin.x = MIN(frame.origin.x, self.maximumHorizontalOffset);
            self.selectedTableViewCell.frame = frame;
            [recognizer setTranslation:CGPointZero inView:recognizer.view];
            break;
        }
        default: {
            self.selectedTableViewCell = nil;
            break;
        }
    }
}

#pragma mark UIGestureRecognizerDelegate

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
    // Only allow horizontal pan
    // Compares the horizontal and vertical components of the velocity
    CGPoint velocity = [self.panGestureRecognizer velocityInView:self.panGestureRecognizer.view];
    return fabs(velocity.x) > fabs(velocity.y);
}

@end

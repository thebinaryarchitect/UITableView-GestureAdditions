//
//  _TBALongPressProxy.m
//  UITableView+GestureAdditions
//
//  Copyright (C) 2015 Xiao Yao. All Rights Reserved.
//  See LICENSE.txt for more information.
//

#import "_TBALongPressProxy.h"

#pragma mark - _TBALongPressProxy

#pragma mark - Public Implementation

@implementation _TBALongPressProxy

#pragma mark Lifecycle

- (instancetype)initWithTableView:(UITableView *)tableView {
    self = [super init];
    if (self) {
        self.tableView = tableView;
        
        UILongPressGestureRecognizer *recognizer = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(handleLongPress:)];
        recognizer.delegate = self;
        [tableView addGestureRecognizer:recognizer];
        self.longPressGestureRecognizer = recognizer;
    }
    return self;
}

- (void)setEnabled:(BOOL)enabled {
    if (_enabled != enabled) {
        _enabled = enabled;
        if (_enabled) {
            [self.tableView addGestureRecognizer:self.longPressGestureRecognizer];
        } else {
            [self.tableView removeGestureRecognizer:self.longPressGestureRecognizer];
        }
    }
}

#pragma mark Private

- (void)handleLongPress:(UILongPressGestureRecognizer *)recognizer {
}

#pragma mark UIGestureRecognizerDelegate

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
    if ([gestureRecognizer isEqual:self.longPressGestureRecognizer]) {
        // Disable if table view data source does not respond to tableView:canMoveRowAtIndexPath: and tableView:moveRowAtIndexPath:toIndexPath: or if this method returns NO.
        if ([self.tableView.dataSource respondsToSelector:@selector(tableView:canMoveRowAtIndexPath:)] && [self.tableView.dataSource respondsToSelector:@selector(tableView:moveRowAtIndexPath:toIndexPath:)]) {
            CGPoint touchLocation = [self.longPressGestureRecognizer locationInView:self.longPressGestureRecognizer.view];
            NSIndexPath *indexPath = [self.tableView indexPathForRowAtPoint:touchLocation];
            BOOL canMove = [self.tableView.dataSource tableView:self.tableView canMoveRowAtIndexPath:indexPath];
            if (canMove) {
                // No sections, return early.
                if ([self.tableView numberOfSections] == 0) {
                    return NO;
                }
                
                for (NSInteger i=0; i<[self.tableView numberOfSections]; i++) {
                    if ([self.tableView numberOfRowsInSection:i] > 0) {
                        return YES;
                    }
                }
            } else {
                return NO;
            }
        } else {
            return NO;
        }
    }
    return YES;
}

@end

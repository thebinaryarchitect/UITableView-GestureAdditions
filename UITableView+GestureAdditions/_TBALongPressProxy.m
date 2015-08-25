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
    CGPoint touchLocation = [recognizer locationInView:recognizer.view];
    NSIndexPath *indexPath = [self.tableView indexPathForRowAtPoint:touchLocation];
    switch (recognizer.state) {
        case UIGestureRecognizerStateBegan: {
            UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
            cell.backgroundColor = [UIColor whiteColor];
            [cell setHighlighted:NO];
            [cell setSelected:NO];
            self.selectedTableViewCell = cell;
            self.sourceIndexPath = indexPath;
            
            UIEdgeInsets inset = self.selectedTableViewCell.separatorInset;
            CGFloat right = inset.right;
            inset.right = NSIntegerMax;
            self.selectedTableViewCell.separatorInset = inset;
            
            UIGraphicsBeginImageContextWithOptions(cell.bounds.size, NO, 0.0);
            [cell.layer renderInContext:UIGraphicsGetCurrentContext()];
            UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
            UIGraphicsEndImageContext();
            
            UIImageView *snapshot = [[UIImageView alloc] initWithImage:image];
            CALayer *layer = snapshot.layer;
            layer.shadowColor = [UIColor blackColor].CGColor;
            layer.shadowOffset = CGSizeMake(0.0, 0.0);
            layer.shadowOpacity = 0.25;
            layer.shadowRadius = 5.0;
            CGRect frame = cell.frame;
            frame.origin.x = 0.0;
            snapshot.frame = frame;
            snapshot.alpha = 0.0;
            [self.tableView addSubview:snapshot];
            self.snapshot = snapshot;
            
            inset.right = right;
            self.selectedTableViewCell.separatorInset = inset;
            
            [UIView animateWithDuration:0.25 animations:^{
                self.snapshot.transform = CGAffineTransformMakeScale(1.025, 1.025);
                
                self.snapshot.alpha = 1.0;
                
                CGPoint center = self.snapshot.center;
                center.y = touchLocation.y;
                self.snapshot.center = center;
                
                self.selectedTableViewCell.hidden = YES;
            }];
            
            CADisplayLink *link = [CADisplayLink displayLinkWithTarget:self selector:@selector(tick:)];
            [link addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSDefaultRunLoopMode];
            self.displayLink = link;
            break;
        }
        case UIGestureRecognizerStateChanged: {
            // Calculate scroll rate
            CGRect rect = self.tableView.bounds;
            UIEdgeInsets contentInset = self.tableView.contentInset;
            rect.size.height -= contentInset.top;
            CGFloat scrollZoneHeight = MIN(self.selectedTableViewCell.frame.size.height * 2.0, rect.size.height / 5.0);
            CGPoint contentOffset = self.tableView.contentOffset;
            CGFloat minY = contentOffset.y + contentInset.top + scrollZoneHeight;
            CGFloat maxY = contentOffset.y + contentInset.top +rect.size.height - scrollZoneHeight;
            if (touchLocation.y >= maxY) {
                self.scrollRate = (touchLocation.y - maxY) / scrollZoneHeight;
            } else if (touchLocation.y <= minY) {
                self.scrollRate = (touchLocation.y - minY) / scrollZoneHeight;
            } else {
                self.scrollRate = 0.0;
                [self updateCell];
            }
            break;
        }
        default: {
            self.scrollRate = 0.0;
            [self.displayLink invalidate];
            self.displayLink = nil;
            
            CGRect frame = CGRectZero;
            if ([self.tableView.gestureDelegate respondsToSelector:@selector(tableView:shouldCommitRowMoveAtIndexPath:toIndexPath:)]) {

                BOOL commit = [self.tableView.gestureDelegate tableView:self.tableView shouldCommitRowMoveAtIndexPath:self.sourceIndexPath toIndexPath:indexPath];
                if (commit) {
                    if ([self.tableView.gestureDelegate respondsToSelector:@selector(tableView:commitRowMoveAtIndexPath:toIndexPath:)]) {
                        [self.tableView.gestureDelegate tableView:self.tableView commitRowMoveAtIndexPath:self.sourceIndexPath toIndexPath:indexPath];
                    }
                    frame = self.selectedTableViewCell.frame;
                } else {
                    UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:self.sourceIndexPath];
                    frame = cell.frame;
                }
            } else {
                frame = self.selectedTableViewCell.frame;
            }
            
            [UIView animateWithDuration:0.25 animations:^{
                self.snapshot.transform = CGAffineTransformMakeScale(1.0, 1.0);
                self.snapshot.frame = frame;
                self.snapshot.alpha = 0.0;
            } completion:^(BOOL finished) {
                [self.snapshot removeFromSuperview];
                self.snapshot = nil;
                self.selectedTableViewCell.hidden = NO;
                self.selectedTableViewCell = nil;
                self.sourceIndexPath = nil;
            }];
            break;
        }
    }
}

- (void)updateCell {
    CGPoint touchLocation = [self.longPressGestureRecognizer locationInView:self.longPressGestureRecognizer.view];
    NSIndexPath *selectedIndexPath = [self.tableView indexPathForCell:self.selectedTableViewCell];
    NSIndexPath *indexPath = [self.tableView indexPathForRowAtPoint:touchLocation];
    if (![selectedIndexPath isEqual:indexPath] && indexPath && selectedIndexPath) {
        if ([self.tableView.dataSource respondsToSelector:@selector(tableView:moveRowAtIndexPath:toIndexPath:)]) {
            [self.tableView.dataSource tableView:self.tableView moveRowAtIndexPath:selectedIndexPath toIndexPath:indexPath];
        }
        [self.tableView moveRowAtIndexPath:selectedIndexPath toIndexPath:indexPath];
    }
    
    // Update snapshot center
    CGPoint center = self.snapshot.center;
    touchLocation.y = MAX(0.0, touchLocation.y);
    touchLocation.y = MIN(self.tableView.contentSize.height, touchLocation.y);
    center.y = touchLocation.y;
    self.snapshot.center = center;
}

- (void)tick:(CADisplayLink *)link {
    if (self.scrollRate != 0.0) {
        // Update content offset.
        CGPoint offset = self.tableView.contentOffset;
        offset.y += 15.0 * self.scrollRate;
        
        UIEdgeInsets contentInset = self.tableView.contentInset;
        CGFloat top = contentInset.top;
        if (offset.y < -top) {
            offset.y = -top;
        } else {
            CGSize contentSize = self.tableView.contentSize;
            CGRect frame = self.tableView.frame;
            if (contentSize.height + contentInset.bottom < frame.size.height) {
                offset = self.tableView.contentOffset;
            } else {
                CGFloat max = contentSize.height + contentInset.bottom - frame.size.height;
                if (offset.y > max) {
                    offset.y = max;
                }
            }
        }
        
        self.tableView.contentOffset = offset;
        [self updateCell];
    }
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

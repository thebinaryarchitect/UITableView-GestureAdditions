//
//  _TBALongPressProxy.h
//  UITableView+GestureAdditions
//
//  Copyright (C) 2015 Xiao Yao. All Rights Reserved.
//  See LICENSE.txt for more information.
//

@import Foundation;
@import UIKit;

#pragma mark - _TBALongPressProxy

#pragma mark - Public Interface

/**
 *  A proxy object used to manage the long press reorder functionality for the UITableView class. This is a PRIVATE CLASS.
 */
@interface _TBALongPressProxy : NSObject <UIGestureRecognizerDelegate>

/**
 *  The table view.
 */
@property (nonatomic, weak, readwrite) UITableView *tableView;

/**
 *  Tracks if the gesture is enabled.
 */
@property (nonatomic, assign, readwrite) BOOL enabled;

/**
 *  The long press gesture recognizer used to reorder cells. The proxy is the delegate.
 */
@property (nonatomic, strong, readwrite) UILongPressGestureRecognizer *longPressGestureRecognizer;

/**
 *  The selected table view cell.
 */
@property (nonatomic, strong, readwrite) UITableViewCell *selectedTableViewCell;

/**
 *  The snapshot of the cell being reordered.
 */
@property (nonatomic, strong, readwrite) UIImageView *snapshot;

/**
 *  The display link used to auto scroll.
 */
@property (nonatomic, strong, readwrite) CADisplayLink *displayLink;

/**
 *  The speed of the auto scroll.
 */
@property (nonatomic, assign, readwrite) CGFloat scrollRate;

/**
 *  The index path of the selected cell at the beginning of the gesture.
 */
@property (nonatomic, assign, readwrite) NSIndexPath *sourceIndexPath;

/**
 *  The designated initializer.
 *
 *  @param tableView The table view.
 *
 *  @return _TBALongPressProxy object.
 */
- (instancetype)initWithTableView:(UITableView *)tableView;

@end

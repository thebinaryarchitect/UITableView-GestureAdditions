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
@interface _TBALongPressProxy : NSObject

/**
 *  The table view.
 */
@property (nonatomic, weak, readwrite) UITableView *tableView;

/**
 *  Tracks if the gesture is enabled.
 */
@property (nonatomic, assign, readwrite) BOOL enabled;

/**
 *  The long press gesture recognizer used to reorder cells.
 */
@property (nonatomic, strong, readwrite) UILongPressGestureRecognizer *longPressGestureRecognizer;

/**
 *  The designated initializer.
 *
 *  @param tableView The table view.
 *
 *  @return _TBALongPressProxy object.
 */
- (instancetype)initWithTableView:(UITableView *)tableView;

@end

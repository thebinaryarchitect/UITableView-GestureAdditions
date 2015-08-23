//
//  UITableView+GestureAdditions.h
//  UITableView+GestureAdditions
//
//  Created by Xiao Yao on 8/23/15.
//  Copyright (c) 2015 Xiao Yao. All rights reserved.
//

@import UIKit;

#pragma mark - UITableView

#pragma mark - Public Interface (GestureAdditions)

/**
 *  Adds gesture based functionality to the UITableView class.
 */
@interface UITableView (GestureAdditions)

/**
 *  Tracks if long press reorder functionality is enabled.
 *
 *  A long press gesture recognizer is added to the table view if set to YES. The recognizer is removed when set to NO. The default is NO.
 *
 *  @warning Both the tableView:canMoveRowAtIndexPath: and tableView:moveRowAtIndexPath:toIndexPath data source methods must be implemented for the recognizer to trigger.
 */
@property (nonatomic, assign, readwrite) BOOL enableLongPressReorder;

/**
 *  The minimum amount of time that needs to elapse from a long press to trigger a reorder actions.
 */
@property (nonatomic, assign, readwrite) CGFloat minimumPressDuration;

@end

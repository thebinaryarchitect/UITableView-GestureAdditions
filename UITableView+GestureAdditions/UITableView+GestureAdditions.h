//
//  UITableView+GestureAdditions.h
//  UITableView+GestureAdditions
//
//  Created by Xiao Yao on 8/23/15.
//  Copyright (c) 2015 Xiao Yao. All rights reserved.
//

@import UIKit;

/**
 *  Protocol definition to handle gestures.
 */
@protocol UITableViewGestureDelegate <NSObject>

/**
 *  Called when a reorder is about to happen.
 *
 *  @param tableView            The table view.
 *  @param sourceIndexPath      The index path at the start of the gesture
 *  @param destinationIndexPath The index path to reorder the cell to
 *
 *  @return YES if you want to allow the reorder. If YES, tableView:commitRowMoveAtIndexPath:toIndexPath: is called
 */
- (BOOL)tableView:(UITableView *)tableView shouldCommitRowMoveAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath;

/**
 *  Called when a reorder is completed.
 *
 *  @param tableView            The table view
 *  @param sourceIndexPath      The index path at the start of the gesture
 *  @param destinationIndexPath The index path to reorder the cell to
 */
- (void)tableView:(UITableView *)tableView commitRowMoveAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath;


@end

#pragma mark - UITableView

#pragma mark - Public Interface (GestureAdditions)

/**
 *  Adds gesture based functionality to the UITableView class.
 */
@interface UITableView (GestureAdditions)

/**
 *  The gesture delegate.
 */
@property (nonatomic, weak, readwrite) id<UITableViewGestureDelegate> gestureDelegate;

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

//
//  _TBAHorizontalPanProxy.h
//  UITableView+GestureAdditions
//
//  Copyright (C) 2015 Xiao Yao. All Rights Reserved.
//  See LICENSE.txt for more information.
//

@import Foundation;
@import UIKit;

#pragma mark - _TBAHorizontalPanProxy

#pragma mark - Public Interface

@interface _TBAHorizontalPanProxy : NSObject <UIGestureRecognizerDelegate>

/**
 *  Tracks if the horizontal pan is active. If YES, the pan gesture recognizer is added to the table view.
 */
@property (nonatomic, assign, readwrite) BOOL enabled;

/**
 *  The table view.
 */
@property (nonatomic, strong, readwrite) UITableView *tableView;

/**
 *  The pan gesture recognizer used to move cells.
 *
 *  The proxy is the delegate for this recognizer. In the gestureRecognizerShouldBegin: method, the absolue value of the x and y components for the velocity of the recognizer is compared. Reture YES if the x component is greater than the y component - limits to horizontal panning. The recognizer is required to fail before the pan gesture recognizer of the table view is triggered.
 */
@property (nonatomic, strong, readwrite) UIPanGestureRecognizer *panGestureRecognizer;

/**
 *  The minimum value for the x-origin of the frame for the selected cell.
 */
@property (nonatomic, assign, readwrite) CGFloat minimumHorizontalOffset;

/**
 *  The maximum value for the x-origin of the frame for the selected cell.
 */
@property (nonatomic, assign, readwrite) CGFloat maximumHorizontalOffset;

/**
 *  The designated initilizer.
 *
 *  @param tableView The table view.
 *
 *  @return _TBAHorizontalPanProxy object.
 */
- (instancetype)initWithTableView:(UITableView *)tableView;

@end

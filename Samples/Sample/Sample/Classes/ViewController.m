//
//  ViewController.m
//  Sample
//
//  Copyright (C) 2015 Xiao Yao. All Rights Reserved.
//  See LICENSE.txt for more information.
//

#import "ViewController.h"
#import "RootViewController.h"

#pragma mark - ViewController

#pragma mark - Public Implementation

@implementation ViewController

#pragma mark Lifecycle

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    RootViewController *rootVC = [[RootViewController alloc] init];
    self = [super initWithRootViewController:rootVC];
    if (self) {
        self.navigationBar.translucent = NO;
    }
    return self;
}

@end

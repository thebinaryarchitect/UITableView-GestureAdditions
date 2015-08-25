//
//  RootViewController.m
//  Sample
//
//  Created by Xiao Yao on 8/23/15.
//  Copyright (c) 2015 Xiao Yao. All rights reserved.
//

#import "RootViewController.h"
#import "UITableView+GestureAdditions.h"

#pragma mark - RootViewController

#pragma mark - Private Interface

@interface RootViewController() <UITableViewGestureDelegate>
@property (nonatomic, strong, readwrite) NSMutableArray *objects;
@end

#pragma mark - Public Implementation

@implementation RootViewController

#pragma mark Lifecycle

- (instancetype)init {
    self = [super init];
    if (self) {
        self.objects = [NSMutableArray array];
        for (NSInteger i=0; i<10; i++) {
            NSMutableArray *section = [NSMutableArray array];
            for (NSInteger j=0; j<10; j++) {
                [section addObject:[NSString stringWithFormat:@"Section %i | Row %i", i, j]];
            }
            [self.objects addObject:section];
        }
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.enableLongPressReorder = YES;
    self.tableView.gestureDelegate = self;
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:NSStringFromClass([UITableViewCell class])];
}

#pragma mark UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.objects.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSMutableArray *objects = self.objects[section];
    return objects.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([UITableViewCell class]) forIndexPath:indexPath];
    NSMutableArray *objects = self.objects[indexPath.section];
    NSString *text = objects[indexPath.row];
    cell.textLabel.text = text;
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return [NSString stringWithFormat:@"Section %i", section];
}

#pragma mark UITableViewDelegate

- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath {
    NSInteger sRow = sourceIndexPath.row;
    NSInteger dRow = destinationIndexPath.row;
    
    // Update data source
    NSMutableArray *sObjects = self.objects[sourceIndexPath.section];
    NSString *text = [NSString stringWithFormat:@"Moved cell from section %i row %i to section %i row %i", destinationIndexPath.section, destinationIndexPath.row, sourceIndexPath.section, sourceIndexPath.row];
    [sObjects replaceObjectAtIndex:dRow withObject:text];
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:destinationIndexPath];
    cell.textLabel.text = text;
    
    text = [NSString stringWithFormat:@"Moved cell from section %i row %i to sectio %i row %i", sourceIndexPath.section, sourceIndexPath.row, destinationIndexPath.section, destinationIndexPath.row];
    [sObjects replaceObjectAtIndex:sRow withObject:text];
    cell = [tableView cellForRowAtIndexPath:sourceIndexPath];
    cell.textLabel.text = text;
    
    // 
    if (sourceIndexPath.section != destinationIndexPath.section) {
        NSString *text = sObjects[sRow];
        [sObjects removeObjectAtIndex:sRow];
        
        NSMutableArray *dObjects = self.objects[destinationIndexPath.section];
        [dObjects insertObject:text atIndex:destinationIndexPath.row];
    }
}

#pragma mark UITableViewGestureDelegate

- (BOOL)tableView:(UITableView *)tableView shouldCommitRowMoveAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath {
    return YES;
}

- (void)tableView:(UITableView *)tableView commitRowMoveAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath {
    if (sourceIndexPath.section == destinationIndexPath.section) {
        
    }
}

@end

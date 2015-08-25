//
//  RootViewController.m
//  Sample
//
//  Created by Xiao Yao on 8/23/15.
//  Copyright (c) 2015 Xiao Yao. All rights reserved.
//

#import "RootViewController.h"

#pragma mark - RootViewController

#pragma mark - Private Interface

@interface RootViewController()
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

@end

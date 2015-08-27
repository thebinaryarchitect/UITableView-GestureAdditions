# UITableView-GestureAdditions

A category extension on the UITableView class that adds the following functionality:
1. Long press reorder
2. Horizontally panning of individual cells.

Example:

UITableView *tableView = ...
tableView.enableLongPressReorder = YES;
tableView.enableHorizontalPanning = YES;

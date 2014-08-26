//
//  ItemsViewController.m
//  Homepwner
//
//  Created by Kevin Moy on 8/21/14.
//  Copyright (c) 2014 Kevin Moy. All rights reserved.
//

#import "ItemsViewController.h"
#import "ItemStore.h"
#import "Item.h"
@interface ItemsViewController ()

@property (nonatomic, strong) IBOutlet UIView *headerView;

@end
@implementation ItemsViewController

- (instancetype)init
{
    self = [super initWithStyle:UITableViewStylePlain];
    if (self) {
    
    }
    return self;
}
- (instancetype)initWithStyle:(UITableViewStyle)style
{
    return [self init];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[[ItemStore sharedStore] allItems] count];
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Create instance of UItableview with default appearance
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell" forIndexPath:indexPath];
    
    NSArray *items = [[ItemStore sharedStore] allItems];
    Item *item = items[indexPath.row];
    
    cell.textLabel.text = [item description];
    
    return cell;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UITableViewCell"];
    
    UIView *header = self.headerView;
    [self.tableView setTableHeaderView:header];
}

- (IBAction)addNewItem:(id)sender
{
    // Create new item and add to store
    Item *newItem = [[ItemStore sharedStore] createItem];
    
    // Figure out where item is in the array
    NSInteger lastRow = [[[ItemStore sharedStore] allItems] indexOfObject:newItem];
    
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:lastRow inSection:0];
    
    // Insert a new row
    [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationTop];
    
}
- (IBAction)toggleEditingMode:(id)sender
{
    // If in editing mode
    if (self.isEditing) {
        // Change tet of button to inform user
        [sender setTitle:@"Edit" forState:UIControlStateNormal];
        
        // Turn off editing mode
        [self setEditing:NO animated:YES];
    } else {
        // Change text of button to inform user of state
        [sender setTitle:@"Done" forState:UIControlStateNormal];
        
        // Enter editing mode
        [self setEditing:YES animated:YES];
    }
}
- (UIView *)headerView
{
    // If not loaded headerview
    if (!_headerView){
        // Load headerview.xib
        [[NSBundle mainBundle] loadNibNamed:@"HeaderView"
                                      owner:self
                                    options:nil];
    }
    
    return _headerView;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    // If table view is asking to commit delete command
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        NSArray *items = [[ItemStore sharedStore] allItems];
        Item *item = items[indexPath.row];
        [[ItemStore sharedStore] removeItem:item];
        
        // Also remove row from table view with animation
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
}

- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath
{
    [[ItemStore sharedStore] moveItemAtIndex:sourceIndexPath.row toIndex:destinationIndexPath.row];
}

@end


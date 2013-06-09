//
//  RootViewController.m
//  Setting
//
//  Created by Hiroaki Komatsu on 12/09/27.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "RootViewController.h"
#import "AccountViewController.h"
#import "AddAccountViewController.h"


@implementation RootViewController


- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:UITableViewStyleGrouped];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

- (void)dealloc
{
    [_accounts release], _accounts = nil;
    [super dealloc];
}

#pragma mark - actions

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.navigationItem.title = @"Columns";
    
    itemsList = [[NSArray alloc] initWithObjects:@"kjdff", nil];
    _accounts = [[NSMutableArray alloc] initWithObjects:
               [NSMutableDictionary dictionaryWithObjectsAndKeys:@"Nominal Dimentions", @"id", @"guest", @"password", nil],
                 [NSMutableDictionary dictionaryWithObjectsAndKeys:@"Wood type", @"id", @"guest", @"password", nil],
                 [NSMutableDictionary dictionaryWithObjectsAndKeys:@"Grade", @"id", @"guest", @"password", nil],
                 [NSMutableDictionary dictionaryWithObjectsAndKeys:@"Load Duration Factor", @"id", @"guest", @"password", nil],
               nil];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.tableView reloadData];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}




#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    switch (section) {
        case 0:
            return [_accounts count];
            break;
    }
    return 0;
}

- (NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    switch (section) {
        case 0:
            return @"Account:";
            break;
    }
    return @"";
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    
    // Configure the cell...
    NSMutableDictionary *data;
    int section = [indexPath section];
    int row = [indexPath row];
    switch (section) {
        case 0:
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            if (indexPath.row < [_accounts count]) {
                data = [_accounts objectAtIndex:row];
                cell.textLabel.text = [data objectForKey:@"id"];
            }
            break;
    }
    
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    int section = [indexPath section];
    int row = [indexPath row];
    switch (section) {
        case 0:
            // アカウント関連グループ
            
            if (indexPath.row < [_accounts count]) {
                // 登録されているアカウントのセル
                
                // Navigation logic may go here. Create and push another view controller.
                AccountViewController *accountViewController = [[[AccountViewController alloc] init] autorelease];
                accountViewController.datas = _accounts;
                accountViewController.index = row;
                
                // Pass the selected object to the new view controller.
                [self.navigationController pushViewController:accountViewController animated:YES];
                
            } else {
                // アカウントを追加するためのセル
                
                // Navigation logic may go here. Create and push another view controller.
                AddAccountViewController *addAccountViewController = [[[AddAccountViewController alloc] init] autorelease];
                addAccountViewController.datas = _accounts;
                
                // Pass the selected object to the new view controller.
                [self.navigationController pushViewController:addAccountViewController animated:YES];
            }
            break;
    }
}






@end

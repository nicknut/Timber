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
    [_woodTypeList release], _woodTypeList = nil;
    [super dealloc];
}

#pragma mark - actions

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.navigationItem.title = @"Timber";
    
    [self loadnomDimentionSmall];
    
    
    _accounts = [[NSMutableArray alloc] initWithObjects:
               [NSMutableDictionary dictionaryWithObjectsAndKeys:@"Nominal Dimentions", @"id", @"guest", @"password", nil],
                 [NSMutableDictionary dictionaryWithObjectsAndKeys:@"Wood type", @"id", @"guest", @"password", nil],
                 [NSMutableDictionary dictionaryWithObjectsAndKeys:@"Grade", @"id", @"guest", @"password", nil],
                 [NSMutableDictionary dictionaryWithObjectsAndKeys:@"Load Duration Factor", @"id", @"guest", @"password", nil],

                 [NSMutableDictionary dictionaryWithObjectsAndKeys:@"CM", @"id", @"guest", @"password", nil],
                 [NSMutableDictionary dictionaryWithObjectsAndKeys:@"Ct", @"id", @"guest", @"password", nil],
                 [NSMutableDictionary dictionaryWithObjectsAndKeys:@"CF", @"id", @"guest", @"password", nil],
                 [NSMutableDictionary dictionaryWithObjectsAndKeys:@"Cp", @"id", @"guest", @"password", nil],
                 [NSMutableDictionary dictionaryWithObjectsAndKeys:@"Ci", @"id", @"guest", @"password", nil],
                 [NSMutableDictionary dictionaryWithObjectsAndKeys:@"CT", @"id", @"guest", @"password", nil],
                
               nil];
    
    _results = [[NSMutableArray alloc] initWithObjects:
                [NSMutableDictionary dictionaryWithObjectsAndKeys:@"Result 1 Emin'", @"id", @"guest", @"password", nil],
                [NSMutableDictionary dictionaryWithObjectsAndKeys:@"Result 2 Fce", @"id", @"guest", @"password", nil],
                [NSMutableDictionary dictionaryWithObjectsAndKeys:@"Result 3 fc*", @"id", @"guest", @"password", nil],
                [NSMutableDictionary dictionaryWithObjectsAndKeys:@"Result 4 Cp", @"id", @"guest", @"password", nil],
                nil];
    
  
    

                
    UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleSingleTap:)];
    [tapRecognizer setNumberOfTapsRequired:1];
    [self.view addGestureRecognizer:tapRecognizer];
}

- (void) loadnomDimentionSmall
{
    
    
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"nomDimentionSmall" ofType:@"csv"];
    if (filePath) {
        NSString *myText = [NSString stringWithContentsOfFile:filePath];
        if (myText) {
            return;
        }
        NSArray *contentArray = [filePath componentsSeparatedByString:@"\r"];
        for (NSString *item in contentArray) {
            NSArray *itemsArray = [item componentsSeparatedByString:@","];
        }
    }
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)handleSingleTap:(UITapGestureRecognizer *)recognizer
{
    [self.view endEditing:YES];
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
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    switch (section) {
        case 0:
            return [_accounts count];
            break;
        case 1:
            return [_results count];
            break;
    }
    return 0;
}

- (NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    switch (section) {
        case 0:
            return @"Column Information:";
            break;
        case 1:
            return @"Results:";
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
            if (indexPath.row > 3) {
                UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, 200, 21)];
                textField.placeholder = @"Enter number";
                textField.tag = 1000+indexPath.row;
                textField.returnKeyType = UIReturnKeyDone;
                //textField.delegate = self;
                textField.keyboardType = UIKeyboardTypeDecimalPad;
                textField.textAlignment = UITextAlignmentRight;
                cell.accessoryView = textField;
                [textField release];
                
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
            } else {
                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            }
            data = [_accounts objectAtIndex:row];
            cell.textLabel.text = [data objectForKey:@"id"];
            break;
        case 1:
            if(indexPath.row >= 0) {
                UILabel *labelField = [[UILabel alloc]initWithFrame:CGRectMake(25, 25, 100, 21)];
                labelField.text = @"0.00";
                labelField.tag = 2000+indexPath.row;
                labelField.textAlignment = UITextAlignmentRight;
                labelField.BackgroundColor = [UIColor clearColor];
                cell.accessoryView = labelField;
                [labelField release];
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            data = [_results objectAtIndex:row];
            cell.textLabel.text = [data objectForKey:@"id"];
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
            // Go to list view
            if (indexPath.row < 3) {
                // Navigation logic may go here. Create and push another view controller.
                AccountViewController *accountViewController = [[[AccountViewController alloc] init] autorelease];
                accountViewController.datas = _accounts;
                accountViewController.index = row;
                
                // Pass the selected object to the new view controller.
                [self.navigationController pushViewController:accountViewController animated:YES];
                
            } else {
                // Pull up keyboard
                UITextField* field =  (UITextField *) [tableView viewWithTag: indexPath.row + 1000];
                [field becomeFirstResponder];
            }
            break;
    }
}

@end
    

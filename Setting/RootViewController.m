//
//  RootViewController.m
//

#import "RootViewController.h"
#import "ListViewController.h"

@implementation RootViewController

@synthesize txtActiveField;
@synthesize inputAccView;
@synthesize btnDone;
@synthesize btnNext;
@synthesize btnPrev;


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
    [_nomList release], _nomList = nil;
    [_results release], _results = nil;
    [super dealloc];
}

#pragma mark - actions

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.navigationItem.title = @"Timber";
    _nomSelectedIndex = @-1;
    _nomList = [[NSMutableArray alloc] init];
    [self loadnomDimentionSmall];
    [self loadnomDimentionLarge];
    
    
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

}

- (void) loadnomDimentionSmall
{
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"nomDimentionSmall" ofType:@"csv"];
    if (filePath) {
        NSString *myText = [NSString stringWithContentsOfFile:filePath];

        NSArray *contentArray = [myText componentsSeparatedByString:@"\r"];
        int i = 0;
        for (NSString *item in contentArray) {
            if(i != 0) {
                NSArray *itemsArray = [item componentsSeparatedByString:@","];
                [_nomList addObject:itemsArray];
            }
            i++;
        }
        //[contentArray release];
        //[myText release];
    }
    
    //[filePath release];
}

- (void) loadnomDimentionLarge
{
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"nomDimentionLarge" ofType:@"csv"];
    if (filePath) {
        NSString *myText = [NSString stringWithContentsOfFile:filePath];
        
        NSArray *contentArray = [myText componentsSeparatedByString:@"\r"];
        
        int i = 0;
        for (NSString *item in contentArray) {
            if(i != 0) {
                NSArray *itemsArray = [item componentsSeparatedByString:@","];
                [_nomList addObject:itemsArray];
            }
            i++;
        }
        //[contentArray release];
        //[myText release];
    }
    
    //[filePath release];
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
                textField.delegate = self;
                textField.keyboardType = UIKeyboardTypeDecimalPad;
                textField.textAlignment = UITextAlignmentRight;
                cell.accessoryView = textField;
                [textField release];
                
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
            } else {
                UILabel *labelField = [[UILabel alloc]initWithFrame:CGRectMake(100, 7, 180, 30)];

                labelField.tag = 1000+indexPath.row;
                labelField.textAlignment = UITextAlignmentRight;
                labelField.BackgroundColor = [UIColor clearColor];
                [cell addSubview:labelField];
                //cell.accessoryView = labelField;
                [labelField release];
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

// The done on the keyboard events

-(void)createInputAccessoryView{
    // Create the view that will play the part of the input accessory view.
    // Note that the frame width (third value in the CGRectMake method)
    // should change accordingly in landscape orientation. But we don’t care
    // about that now.
    inputAccView = [[UIView alloc] initWithFrame:CGRectMake(10.0, 0.0, 310.0, 40.0)];
    // Set the view’s background color. We’ ll set it here to gray. Use any color you want.
    [inputAccView setBackgroundColor:[UIColor colorWithRed:0.0 green:0 blue:0 alpha:0.1]];
    // We can play a little with transparency as well using the Alpha property. Normally
    // you can leave it unchanged.    // If you want you may set or change more properties (ex. Font, background image,e.t.c.).
    // For now, what we’ ve already done is just enough.
    // Let’s create our buttons now. First the previous button.
    /*
    btnPrev = [UIButton buttonWithType: UIButtonTypeCustom];
    // Set the button’ s frame. We will set their widths to 80px and height to 40px.
    [btnPrev setFrame: CGRectMake(5.0, 5.0, 80.0, 30.0)];
    // Title.
    [btnPrev setTitle: @"Previous" forState: UIControlStateNormal];
    [btnPrev setBackgroundColor:[UIColor blueColor]];
    // Background color.
    // You can set more properties if you need to.
    // With the following command we’ ll make the button to react in finger tapping. Note that the
    // gotoPrevTextfield method that is referred to the @selector is not yet created. We’ ll create it
    // (as well as the methods for the rest of our buttons) later.
    [btnPrev addTarget: self action: @selector(gotoPrevTextfield) forControlEvents: UIControlEventTouchUpInside];
    // Do the same for the two buttons left.
    btnNext = [UIButton buttonWithType:UIButtonTypeCustom];
    [btnNext setFrame:CGRectMake(90.0f, 5.0f, 80.0f, 30.0f)];
    [btnNext setTitle:@"Next" forState:UIControlStateNormal];
    [btnNext setBackgroundColor:[UIColor blueColor]];
    [btnNext addTarget:self action:@selector(gotoNextTextfield) forControlEvents:UIControlEventTouchUpInside];
    */
    btnDone = [UIButton buttonWithType:UIButtonTypeCustom];
    [btnDone setFrame:CGRectMake(235.0, 5.0f, 80.0f, 30.0f)];
    [btnDone setTitle:@"Done" forState:UIControlStateNormal];
    [btnDone setBackgroundColor:[UIColor greenColor]];
    [btnDone setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btnDone addTarget:self action:@selector(doneTyping) forControlEvents:UIControlEventTouchUpInside];
    // Now that our buttons are ready we just have to add them to our view.
    [inputAccView addSubview:btnPrev];
    [inputAccView addSubview:btnNext];
    [inputAccView addSubview:btnDone];
}

-(void)textFieldDidBeginEditing:(UITextField *)textField{
    // Call the createInputAccessoryView method we created earlier.
    // By doing that we will prepare the inputAccView.
    [self createInputAccessoryView];
    // Now add the view as an input accessory view to the selected textfield.
    [textField setInputAccessoryView:inputAccView];
    // Set the active field. We' ll need that if we want to move properly
    // between our textfields.
    txtActiveField = textField;
}

-(void)gotoPrevTextfield{
    // If the active textfield is the first one, can't go to any previous
    // field so just return.
    //if (txtActiveField == txtField1) {
        return;
    //}
    //else {
        // Otherwise if the second textfield has the focus, the operation
        // of "previous" button can be done and set the first field as the first
        // responder.
    //    [txtField1 becomeFirstResponder];
    //}
    
    // NOTE: If you have more than two textfields, you modify the if... blocks
    // according to your needs. The example here is quite simple and in a complete
    // app it's possible that you'll have more than two textfields.
}

-(void)gotoNextTextfield{
    // If the active textfield is the second one, there is no next so just return.
    //if (txtActiveField == txtField2) {
        return;
    /*}
    else {
        // Make the second textfield our first responder.
        [txtField2 becomeFirstResponder];
    }*/
}

-(void)doneTyping{
    // When the "done" button is tapped, the keyboard should go away.
    // That simply means that we just have to resign our first responder.
    [txtActiveField resignFirstResponder];
}

- (void)addItemViewController:(ListViewController *)controller didFinishEnteringItem:(int)row
{
    [self.navigationController popViewControllerAnimated:YES];
    
    switch (selectedIndex) {
        case 0:
            _nomSelectedIndex = row;
            UILabel* field =  (UILabel *) [[self tableView] viewWithTag: 1000];
            field.text = [_nomList objectAtIndex:row][0];
            break;
    }
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    int section = [indexPath section];
    int row = [indexPath row];
    switch (section) {
        case 0:
            // Go to list view
            if (row < 3) {
                // Navigation logic may go here. Create and push another view controller.
                ListViewController *listViewController = [[[ListViewController alloc] init] autorelease];
                selectedIndex = row;
                switch(row) {
                    case 0:
                        listViewController.datas = _nomList;
                        listViewController.index = _nomSelectedIndex;
                        break;
                }
                listViewController.delegate = self;
                // Pass the selected object to the new view controller.
                [self.navigationController pushViewController:listViewController animated:YES];
                
            } else {
                // Pull up keyboard
                UITextField* field =  (UITextField *) [tableView viewWithTag: row + 1000];
                [field becomeFirstResponder];
            }
            break;
    }
}

@end
    

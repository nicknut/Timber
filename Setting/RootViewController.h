//
//  RootViewController.h
//

#import <UIKit/UIKit.h>
#import "ListViewController.h"

@interface RootViewController : UITableViewController <UITableViewDelegate, UITableViewDataSource,UITextFieldDelegate,ListViewControllerDelegate>
{
    NSMutableArray *_accounts;
    NSMutableArray *_results;
    
    // What list we opened
    int selectedIndex;
    
    // For first list
    NSMutableArray *_nomList;
    int _nomSelectedIndex;
    
    // For keyboard next/done
    UITextField *txtActiveField;
    UIView *inputAccView;
    UIButton *btnDone;
    UIButton *btnNext;
    UIButton *btnPrev;}

@property (nonatomic, retain) UITextField *txtActiveField;
@property (nonatomic, retain) UIView *inputAccView;
@property (nonatomic, retain) UIButton *btnDone;
@property (nonatomic, retain) UIButton *btnNext;
@property (nonatomic, retain) UIButton *btnPrev;



@end


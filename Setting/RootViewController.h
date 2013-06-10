//
//  RootViewController.h
//

#import <UIKit/UIKit.h>

@interface RootViewController : UITableViewController <UITableViewDelegate, UITableViewDataSource,UITextFieldDelegate>
{
    NSMutableArray *_accounts;
    NSMutableArray *_results;
    NSMutableArray *_nomList;
    NSNumber *_nomSelectedIndex;
    
    // For keyboard next/done
    UITextField *txtActiveField;
    UIView *inputAccView;
    UIButton *btnDone;
    UIButton *btnNext;
    UIButton *btnPrev;
}

@property (nonatomic, retain) UITextField *txtActiveField;
@property (nonatomic, retain) UIView *inputAccView;
@property (nonatomic, retain) UIButton *btnDone;
@property (nonatomic, retain) UIButton *btnNext;
@property (nonatomic, retain) UIButton *btnPrev;


@end


//
//  ListViewController.h
//

#import <UIKit/UIKit.h>

@class ListViewController;

@protocol ListViewControllerDelegate <NSObject>
- (void)addItemViewController:(ListViewController *)controller didFinishEnteringItem:(int)row;
@end

@interface ListViewController : UITableViewController <UIActionSheetDelegate>
{
    NSMutableArray *_data;
}

@property (nonatomic, retain) NSMutableArray *datas;
@property (readwrite) int index;
@property (nonatomic, retain) id <ListViewControllerDelegate> delegate;

@end

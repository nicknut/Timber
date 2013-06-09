//
//  ListViewController.h
//

#import <UIKit/UIKit.h>

@interface ListViewController : UITableViewController <UIActionSheetDelegate>
{
    NSMutableArray *_data;
}

@property (nonatomic, retain) NSMutableArray *datas;
@property (readwrite) int index;

@end

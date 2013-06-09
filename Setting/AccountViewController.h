//
//  AccountViewController.h
//  Setting
//
//  Created by Hiroaki Komatsu on 12/09/28.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AccountViewController : UITableViewController <UIActionSheetDelegate>
{
    NSMutableArray *_data;
}

@property (nonatomic, retain) NSMutableArray *datas;
@property (readwrite) int index;

@end

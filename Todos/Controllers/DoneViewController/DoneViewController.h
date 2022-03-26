//
//  DoneViewController.h
//  Todos
//
//  Created by Amr Hossam on 29/01/2022.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "CustomTableViewCellDelegate.h"

@interface DoneViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, CustomTableViewCellDelegate>

@property NSMutableArray *doneTasks;

@property AppDelegate *appDelegate;
@property NSManagedObjectContext *context;


@end



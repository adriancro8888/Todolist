//
//  ViewController.h
//  Todos
//
//  Created by Amr Hossam on 28/01/2022.
//

#import <UIKit/UIKit.h>
#import "ToDoItemAdderDelegate.h"
#import "CustomTableViewCellDelegate.h"
#import "ItemDetailsViewControllerDelegate.h"
#import "AppDelegate.h"


@interface HomeViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, ToDoItemAdderDelegate, CustomTableViewCellDelegate, ItemDetailsViewControllerDelegate>

@property NSMutableArray *highTodos;
@property NSMutableArray *medTodos;
@property NSMutableArray *lowTodos;


@property AppDelegate *appDelegate;
@property NSManagedObjectContext *context;
@property NSArray *dictionaries;
@property UIImageView *imageView;


@end


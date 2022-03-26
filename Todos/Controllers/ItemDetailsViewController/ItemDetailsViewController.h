//
//  ItemDetailsViewController.h
//  Todos
//
//  Created by Amr Hossam on 29/01/2022.
//

#import <UIKit/UIKit.h>
#import "ToDoItem.h"
#import "ItemDetailsViewControllerDelegate.h"

NS_ASSUME_NONNULL_BEGIN

@interface ItemDetailsViewController : UIViewController

@property ToDoItem *item;
@property id<ItemDetailsViewControllerDelegate> delegate;
@property NSIndexPath *indexPath;

@end

NS_ASSUME_NONNULL_END

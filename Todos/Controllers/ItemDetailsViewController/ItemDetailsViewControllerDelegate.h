//
//  ItemDetailsViewControllerDelegate.h
//  Todos
//
//  Created by Amr Hossam on 29/01/2022.
//

#import <UIKit/UIKit.h>



@protocol ItemDetailsViewControllerDelegate <NSObject>

- (void) didStartTaskAtIndexPath: (NSIndexPath*) indexPath;
- (void) didTapMarkAsDoneForIndexPath: (NSIndexPath*) indexPath;
- (void) didTapDeleteForIndexPath: (NSIndexPath*) indexPath;

@end



//
//  CustomTableViewCell.h
//  Todos
//
//  Created by Amr Hossam on 28/01/2022.
//

#import <UIKit/UIKit.h>
#import "ToDoItem.h"
#import "CustomTableViewCellDelegate.h"


@interface CustomTableViewCell : UITableViewCell

@property UILabel *titleLabel;
@property UIView *customContent;
@property UIButton *disclosureButton;
@property UIImageView *doneIndicator;
@property id<CustomTableViewCellDelegate> delegate;
@property NSIndexPath *indexPath;
-(void) configureCellWithModel: (ToDoItem*) model;


@end



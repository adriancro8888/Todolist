//
//  ToDoItemAdderViewController.h
//  Todos
//
//  Created by Amr Hossam on 28/01/2022.
//

#import <UIKit/UIKit.h>
#import "ToDoItemAdderDelegate.h"


@interface ToDoItemAdderViewController : UIViewController <UITextViewDelegate>


@property UILabel *pageLabel;
@property UILabel *titleLabel;
@property UIImageView *imageView;
@property UITextField *titleTextField;
@property UITextView *descriptionTextView;
@property UISegmentedControl *segmentControl;
@property UILabel *endsAtLabel;
@property UIDatePicker *picker;
@property UIButton *saveButton;
@property id <ToDoItemAdderDelegate> delegate;


@end



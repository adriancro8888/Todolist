//
//  ToDoItemAdderViewController.m
//  Todos
//
//  Created by Amr Hossam on 28/01/2022.
//

#import "ToDoItemAdderViewController.h"
#import <ChameleonFramework/Chameleon.h>
#import "ToDoItem.h"
#import "AppDelegate.h"

@interface ToDoItemAdderViewController ()

@end

@implementation ToDoItemAdderViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:UIColor.systemBackgroundColor];
    
    [self configureDescriptionTextView];
    [self configurePageLabel];
    [self configureTitleLabel];
    [self configureImageView];
    [self configureTextField];
    [self configureSegmentControl];
    [self configureEndsAtLabel];
    [self configureSaveButton];

    [self.view addSubview:_pageLabel];
    [self.view addSubview:_titleLabel];
    [self.view addSubview:_imageView];
    [self.view addSubview:_titleTextField];
    [self.view addSubview:_descriptionTextView];
    [self.view addSubview:_segmentControl];
    [self.view addSubview:_endsAtLabel];
    [self.view addSubview:_picker];
    [self.view addSubview:_saveButton];

}


-(void) didTapSave {
    if(_titleTextField.text.length > 2) {
        AppDelegate *appDelegate = (AppDelegate*)[UIApplication sharedApplication].delegate ;

        NSManagedObjectContext *managedObjectContext = appDelegate.persistentContainer.viewContext;
        ToDoItem *item = [[ToDoItem alloc] initWithItemTitle: _titleTextField.text
                                                      itemDescription:_descriptionTextView.text
                                                      endsAtTask:_picker.date
                                                      andPriority:(int)_segmentControl.selectedSegmentIndex];
        
        
        [_delegate toDoItemAdderDidSaveWith:item andContext:managedObjectContext];
        [self dismissViewControllerAnimated:YES completion:NULL];
    } else {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Invalid Entry" message:@"Make sure your title is meaningful" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDefault handler:NULL];
        [alert addAction:action];
        [self presentViewController:alert animated:YES completion:NULL];
    }

}

-(void) configureSaveButton {
    _saveButton = [[UIButton alloc] initWithFrame:CGRectMake(20, 670, self.view.frame.size.width - 40, 50)];
    _saveButton.layer.masksToBounds = YES;
    _saveButton.layer.cornerRadius = 12;
    [_saveButton setTitle:@"Save" forState:UIControlStateNormal];
    _saveButton.backgroundColor = [UIColor colorWithHexString:@"#cf69ff"];
    _saveButton.titleLabel.font = [UIFont systemFontOfSize:18 weight:UIFontWeightBold];
    [_saveButton addTarget:self action:@selector(didTapSave) forControlEvents:UIControlEventTouchUpInside];
}

- (void)configureEndsAtLabel {
    _endsAtLabel = [[UILabel alloc] initWithFrame: CGRectMake(20, 600, 100, 50)];
    _endsAtLabel.text = @"Ends at:";
    _endsAtLabel.font = [UIFont systemFontOfSize:18 weight:UIFontWeightRegular];
    _endsAtLabel.textColor = UIColor.grayColor;
    
    _picker = [[UIDatePicker alloc] initWithFrame:CGRectMake(100, 608, 100, 50)];
}


- (void) configureSegmentControl {
    
    _segmentControl = [[UISegmentedControl alloc] initWithItems:@[@"Low",@"Medium",@"High"]];
    [_segmentControl setFrame:CGRectMake(20, 540, self.view.frame.size.width - 40, 40)];
    [_segmentControl setSelectedSegmentIndex:0];
    
}

- (void)textViewDidBeginEditing:(UITextView *)textView
{
    if ([textView.text isEqualToString:@"Describe your task"]) {
         textView.text = @"";
         textView.textColor = [UIColor labelColor]; //optional
    }
    [textView becomeFirstResponder];
    textView.font = [UIFont systemFontOfSize:16 weight:UIFontWeightMedium];
}

- (void)textViewDidEndEditing:(UITextView *)textView
{
    if ([textView.text isEqualToString:@""]) {
        textView.text = @"Describe your task";
        textView.textColor = [UIColor tertiaryLabelColor]; //optional
    }
    [textView resignFirstResponder];
    textView.font = [UIFont systemFontOfSize:16 weight:UIFontWeightMedium];
}


- (void)configureTextField {
    _titleTextField = [[UITextField alloc] initWithFrame: CGRectMake(80, 305, 330, 40)];
    [_titleTextField setBackgroundColor:UIColor.quaternarySystemFillColor];
    _titleTextField.returnKeyType = UIReturnKeyNext;
    _titleTextField.leftViewMode = UITextFieldViewModeAlways;
    _titleTextField.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 0)];
    [_titleTextField.layer setMasksToBounds:YES];
    [_titleTextField.layer setCornerRadius:12];
    [_titleTextField setTintColor: UIColor.blackColor];
    [_titleTextField setPlaceholder:@"Enter item title"];
}

- (void)configureDescriptionTextView {
    _descriptionTextView = [[UITextView alloc] initWithFrame:CGRectMake(20, 360, self.view.frame.size.width - 40, 160)];
    _descriptionTextView.text = @"Describe your task";
    _descriptionTextView.font = [UIFont systemFontOfSize:16 weight:UIFontWeightMedium];
    _descriptionTextView.textColor = UIColor.tertiaryLabelColor;
    _descriptionTextView.backgroundColor = UIColor.quaternarySystemFillColor;
    [_descriptionTextView.layer setMasksToBounds:YES];
    [_descriptionTextView.layer setCornerRadius:12];
    [_descriptionTextView setTextContainerInset:UIEdgeInsetsMake(12, 12, 12, 12)];
    [_descriptionTextView setDelegate:self];
}

- (void)configureImageView {
    _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 100, self.view.frame.size.width, 200)];
    _imageView.image = [UIImage imageNamed:@"Checklist"];
    _imageView.contentMode = UIViewContentModeScaleAspectFit;
}

- (void)configureTitleLabel {
    _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 300, 100, 50)];
    _titleLabel.font = [UIFont systemFontOfSize:22 weight:UIFontWeightRegular];
    _titleLabel.textColor = UIColor.grayColor;
    _titleLabel.text = @"Title";
}

- (void)configurePageLabel {
    _pageLabel = [[UILabel alloc] initWithFrame: CGRectMake(20, 20, self.view.frame.size.width - 40, 60)];
    _pageLabel.text = @"New To Do";
    _pageLabel.font = [UIFont systemFontOfSize:40 weight:UIFontWeightBold];
    _pageLabel.textAlignment = NSTextAlignmentCenter;

}



@end

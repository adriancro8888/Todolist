//
//  ItemDetailsViewController.m
//  Todos
//
//  Created by Amr Hossam on 29/01/2022.
//

#import "ItemDetailsViewController.h"
#import "AppDelegate.h"

@interface ItemDetailsViewController ()
@property (weak, nonatomic) IBOutlet UILabel *pageTitle;
@property (weak, nonatomic) IBOutlet UITextView *descriptionTextView;
@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;
@property AppDelegate *appDelegate;
@property NSManagedObjectContext *context;

@end

@implementation ItemDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _pageTitle.text = _item.title;
    _descriptionTextView.text = _item.taskDescription;
    [_datePicker setDate:_item.endsAtDate];
    _appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    _context = _appDelegate.persistentContainer.viewContext;
}
- (IBAction)didTapDeleteButton:(id)sender {
    [_delegate didTapDeleteForIndexPath:_indexPath];
    [self.navigationController popViewControllerAnimated:YES];
}


- (void) updateDatabaseForModel {
    NSManagedObjectContext *context = _appDelegate.persistentContainer.viewContext;
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:[NSEntityDescription entityForName:@"ToDoEntity" inManagedObjectContext:context]];
    NSError *error = nil;
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"title == %@", _pageTitle.text];
    [request setPredicate:predicate];
    NSArray *results = [context executeFetchRequest:request error:&error];
    [results[0] setIsStarted:![_item isStarted]];
    [context save:NULL];
}

- (IBAction)didStartTask:(id) sender {
    [_delegate didStartTaskAtIndexPath: _indexPath];
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)didTapMarkAsDone:(id)sender {
    [_delegate didTapMarkAsDoneForIndexPath: _indexPath];
    [self.navigationController popViewControllerAnimated:YES];
}

@end

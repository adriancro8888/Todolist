//
//  DoneViewController.m
//  Todos
//
//  Created by Amr Hossam on 29/01/2022.
//

#import "DoneViewController.h"
#import "CustomTableViewCell.h"
#import <CoreData/CoreData.h>
#import "AppDelegate.h"
#import <ChameleonFramework/Chameleon.h>
#import "ItemDetailsViewController.h"

@interface DoneViewController ()

@property (weak, nonatomic) IBOutlet UITableView *doneTableView;
@end

@implementation DoneViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [_doneTableView registerClass:[CustomTableViewCell class] forCellReuseIdentifier:@"doneCell"];
    self.navigationController.navigationBar.prefersLargeTitles = YES;
    self.navigationItem.largeTitleDisplayMode = UINavigationItemLargeTitleDisplayModeAlways;
    self.navigationItem.title = @"Completed tasks";
    [_doneTableView setSeparatorStyle: 0];
    _doneTasks = [NSMutableArray new];

    _appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    _context = _appDelegate.persistentContainer.viewContext;
    [[NSNotificationCenter defaultCenter] addObserver:self
            selector:@selector(didRecieveTaskStartedNotification)
            name:@"taskDone"
            object:nil];
        [self fetchTodosFromDataBase];

}

- (void) didRecieveTaskStartedNotification {
    _doneTasks = [NSMutableArray new];
    [self fetchTodosFromDataBase];
    [_doneTableView reloadData];
}


- (void) fetchTodosFromDataBase {
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"ToDoEntity" inManagedObjectContext:_context];
    [fetchRequest setEntity:entity];

    NSError *error = nil;
    NSArray *fetchedObjects = [_context executeFetchRequest:fetchRequest error:&error];
    for(int i=0; i< [fetchedObjects count]; i++) {
        if([fetchedObjects[i] isFinished]) {
            [_doneTasks addObject:fetchedObjects[i]];
        }
    }
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_doneTasks count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CustomTableViewCell* cell = (CustomTableViewCell*) [tableView dequeueReusableCellWithIdentifier:@"doneCell" forIndexPath:indexPath];
    UIView *bgColorView = [[UIView alloc] init];
    bgColorView.backgroundColor = [UIColor systemBackgroundColor];
    [cell setSelectedBackgroundView:bgColorView];
    [cell configureCellWithModel:[_doneTasks objectAtIndex:indexPath.row]];
    cell.indexPath = indexPath;
    if([[_doneTasks objectAtIndex:indexPath.row] isFinished]) {
        [cell.customContent setBackgroundColor: [UIColor colorWithHexString:@"#498af2"]];
        [cell.disclosureButton setTintColor:[UIColor colorWithHexString:@"#d5e1f5"]];
        [cell.titleLabel setTextColor:[ UIColor colorWithHexString:@"#f5f9ff"]];
        [cell.doneIndicator setHidden:YES];
    } else {
        [cell.customContent setBackgroundColor: [UIColor colorWithHexString:@"#E5F7FF"]];
        [cell.disclosureButton setTintColor:[UIColor colorWithHexString:@"#558ded"]];
        [cell.titleLabel setTextColor:[ UIColor colorWithHexString:@"#4d4d4d"]];
        [cell.doneIndicator setHidden:YES];
    }
    [cell setDelegate:self];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 120;
}



- (void)didTapDisclosureForIndexPath:(NSIndexPath *)indexPath {
    ToDoItem *item = _doneTasks[indexPath.row];
    ItemDetailsViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"ItemDetailsViewController"];
    vc.item = item;
    [vc setIndexPath:indexPath];
    [self.navigationController pushViewController:vc animated:YES];
    
}














@end

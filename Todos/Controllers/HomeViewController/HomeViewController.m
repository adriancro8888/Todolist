//
//  ViewController.m
//  Todos
//
//  Created by Amr Hossam on 28/01/2022.
//

#import "HomeViewController.h"
#import "InProgressCollectionViewCell.h"
#import "TableViewHeader.h"
#import "CustomTableViewCell.h"
#import "ToDoItemAdderViewController.h"
#import <ChameleonFramework/Chameleon.h>
#import "ToDoItemAdderViewController.h"
#import "ItemDetailsViewController.h"
#import "DoneViewController.h"


@interface HomeViewController ()


@property UITableView *tableView;
@property TableViewHeader *header;
@property UIButton *button;


@end

@implementation HomeViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"What's up, Amr!";
    [self configureTableView];
    _button = [UIButton new];
    [_button addTarget:self action:@selector(didTapAddButton) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_button];
    _highTodos = [NSMutableArray new];
    _medTodos = [NSMutableArray new];
    _lowTodos = [NSMutableArray new];
    

    _appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    _context = _appDelegate.persistentContainer.viewContext;
    _imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"AddTask"]];
    _imageView.frame = self.view.bounds;
    _imageView.contentMode = UIViewContentModeScaleAspectFit;
    [self.view addSubview:_imageView];
    [self fetchTodosFromDataBase];
    

    
    
}

-(void) didTapSearchIcon {
    
}

- (void) fetchTodosFromDataBase {
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"ToDoEntity" inManagedObjectContext:_context];
    [fetchRequest setEntity:entity];
    // fetch all objects
    NSError *error = nil;
    NSArray *fetchedObjects = [_context executeFetchRequest:fetchRequest error:&error];
    for(int i=0; i< [fetchedObjects count]; i++) {
        switch([fetchedObjects[i] priorityFlag]) {
            case 0:
                [_lowTodos addObject: fetchedObjects[i]];
                break;
            case 1:
                [_medTodos addObject: fetchedObjects[i]];
                break;
            case 2:
                [_highTodos addObject: fetchedObjects[i]];
                break;
        }
    }
}


- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    _button.frame = CGRectMake(self.view.frame.size.width - 100, self.view.frame.size.height - 200, 70, 70);
    _button.backgroundColor = UIColor.linkColor;
    _button.layer.masksToBounds = YES;
    _button.layer.cornerRadius = 35;
    [_button setImage:[UIImage systemImageNamed:@"plus" withConfiguration: [UIImageSymbolConfiguration configurationWithPointSize:22 weight:UIImageSymbolWeightBold]] forState:UIControlStateNormal];
    [_button setTintColor:UIColor.whiteColor];
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"ToDoEntity" inManagedObjectContext:_context];
    [fetchRequest setEntity:entity];
    NSError *error = nil;
    NSArray *fetchedObjects = [_context executeFetchRequest:fetchRequest error:&error];
    if([fetchedObjects count] == 0) {
        [_tableView setHidden:YES];
        [_imageView setHidden:NO];
    } else {
        [_tableView setHidden:NO];
        [_imageView setHidden:YES];
    }
    
    
}



-(void) didTapAddButton {
    
    ToDoItemAdderViewController *vc = [ToDoItemAdderViewController new];
    [vc setDelegate:self];
    [self presentViewController:vc animated:YES completion:NULL];
}




- (void)configureTableView {
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    [_tableView registerClass:[CustomTableViewCell class] forCellReuseIdentifier:@"cell"];
    self.navigationController.navigationBar.prefersLargeTitles = YES;
    self.navigationItem.largeTitleDisplayMode = UINavigationItemLargeTitleDisplayModeAlways;

    [self.view addSubview:_tableView];
    _header = [[TableViewHeader alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 250)];
    [_tableView setDelegate:self];
    [_tableView setDataSource:self];
    [_tableView setTableHeaderView:_header];
    [_tableView setSeparatorStyle:0];
     
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    switch(section) {
        case 0:
            return [_highTodos count];
            break;
        case 1:
            return [_medTodos count];
            break;
        case 2:
            return [_lowTodos count];
            break;
        default:
            return 0;
    }
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}


- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    switch(section) {
        case 0:
            return @"High Priority";
        case 1:
            return @"Medium Proirity";
        case 2:
            return @"Low Priority";
        default:
            return @"";
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CustomTableViewCell* cell = (CustomTableViewCell*) [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    UIView *bgColorView = [[UIView alloc] init];
    bgColorView.backgroundColor = [UIColor systemBackgroundColor];
    [cell setSelectedBackgroundView:bgColorView];

    
    switch(indexPath.section) {
        case 0:
            [cell configureCellWithModel:[_highTodos objectAtIndex:indexPath.row]];
            cell.indexPath = indexPath;
            [cell setDelegate:self];
            if([[_highTodos objectAtIndex:indexPath.row] isFinished]) {
                [cell.customContent setBackgroundColor: [UIColor colorWithHexString:@"#39ba1c"]];
                [cell.disclosureButton setTintColor:[UIColor colorWithHexString:@"#d5e1f5"]];
                [cell.titleLabel setTextColor:[ UIColor colorWithHexString:@"#ffffff"]];
                [cell.doneIndicator setHidden:NO];
            } else {
                [cell.customContent setBackgroundColor: [UIColor colorWithHexString:@"#eb4034"]];
                [cell.disclosureButton setTintColor:[UIColor colorWithHexString:@"#ffffff"]];
                [cell.titleLabel setTextColor:[ UIColor colorWithHexString:@"#ffffff"]];
                [cell.doneIndicator setHidden:YES];
            }
            return cell;
            break;
        case 1:
            [cell configureCellWithModel:[_medTodos objectAtIndex:indexPath.row]];
            cell.indexPath = indexPath;
            [cell setDelegate:self];
            if([[_medTodos objectAtIndex:indexPath.row] isFinished]) {
                [cell.customContent setBackgroundColor: [UIColor colorWithHexString:@"#39ba1c"]];
                [cell.disclosureButton setTintColor:[UIColor colorWithHexString:@"#d5e1f5"]];
                [cell.titleLabel setTextColor:[ UIColor colorWithHexString:@"#f5f9ff"]];
                [cell.doneIndicator setHidden:NO];
            } else {
                [cell.customContent setBackgroundColor: [UIColor colorWithHexString:@"#7372cf"]];
                [cell.disclosureButton setTintColor:[UIColor colorWithHexString:@"#ffffff"]];
                [cell.titleLabel setTextColor:[ UIColor colorWithHexString:@"#ffffff"]];
                [cell.doneIndicator setHidden:YES];
            }
            return cell;
            break;
        case 2:
            [cell configureCellWithModel:[_lowTodos objectAtIndex:indexPath.row]];
            cell.indexPath = indexPath;
            [cell setDelegate:self];
            if([[_lowTodos objectAtIndex:indexPath.row] isFinished]) {
                [cell.customContent setBackgroundColor: [UIColor colorWithHexString:@"#39ba1c"]];
                [cell.disclosureButton setTintColor:[UIColor colorWithHexString:@"#d5e1f5"]];
                [cell.titleLabel setTextColor:[ UIColor colorWithHexString:@"#f5f9ff"]];
                [cell.doneIndicator setHidden:NO];
            } else {
                [cell.customContent setBackgroundColor: [UIColor colorWithHexString:@"#3282e3"]];
                [cell.disclosureButton setTintColor:[UIColor colorWithHexString:@"#ffffff"]];
                [cell.titleLabel setTextColor:[ UIColor colorWithHexString:@"#ffffff"]];
                [cell.doneIndicator setHidden:YES];
            }
            return cell;
            break;
    }

    return cell;
}

- (void)didTapDisclosureForIndexPath:(NSIndexPath *) indexPath {
    
    ToDoItem *item = [ToDoItem new];
    switch(indexPath.section) {
        case 0:
            item = [_highTodos objectAtIndex:indexPath.row];
            break;
        case 1:
            item = [_medTodos objectAtIndex:indexPath.row];
            break;
        case 2:
            item = [_lowTodos objectAtIndex:indexPath.row];
            break;
    }
    ItemDetailsViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"ItemDetailsViewController"];
    vc.item = item;
    [vc setDelegate:self];
    [vc setIndexPath:indexPath];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)didStartTaskAtIndexPath:(NSIndexPath *) indexPath {
    switch(indexPath.section) {
        case 0:
            [[_highTodos objectAtIndex:indexPath.row] setIsStarted:YES];
            [[NSNotificationCenter defaultCenter]
                    postNotificationName:@"taskStarted"
                    object:self];
            [(TableViewHeader*)[self.tableView tableHeaderView] fetchData];

            break;
        case 1:
            [[_medTodos objectAtIndex:indexPath.row] setIsStarted:YES];
            [[NSNotificationCenter defaultCenter]
                    postNotificationName:@"taskStarted"
                    object:self];
            [(TableViewHeader*)[self.tableView tableHeaderView] fetchData];
            break;
        case 2:
                 [[_lowTodos objectAtIndex:indexPath.row] setIsStarted:YES];
            [[NSNotificationCenter defaultCenter]
                    postNotificationName:@"taskStarted"
                    object:self];
            [(TableViewHeader*)[self.tableView tableHeaderView] fetchData];
            break;
    }
}

- (void) updateDatabaseForModel: (ToDoItem*) item  withContext: (NSManagedObjectContext*) context {
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:[NSEntityDescription entityForName:@"ToDoEntity" inManagedObjectContext:context]];
    NSError *error = nil;
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"title == %@", [item title]];
    [request setPredicate:predicate];
    NSArray *results = [_context executeFetchRequest:request error:&error];
    [results[0] setIsFinished:[item isFinished]];
    [_context save:NULL];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    switch(indexPath.section) {
        case 0:
            [[_highTodos objectAtIndex:indexPath.row] setIsFinished:![[_highTodos objectAtIndex:indexPath.row] isFinished]];
            [self updateDatabaseForModel: [_highTodos objectAtIndex:indexPath.row] withContext:[_highTodos[indexPath.row] managedObjectContext]];
            [[NSNotificationCenter defaultCenter]
                    postNotificationName:@"taskDone"
                    object:self];
            [tableView reloadData];
            break;
            
        case 1:
            [[_medTodos objectAtIndex:indexPath.row] setIsFinished:![[_medTodos objectAtIndex:indexPath.row] isFinished]];
            [self updateDatabaseForModel: [_medTodos objectAtIndex:indexPath.row] withContext:[_highTodos[indexPath.row] managedObjectContext]];
            [[NSNotificationCenter defaultCenter]
                    postNotificationName:@"taskDone"
                    object:self];
            [tableView reloadData];
            break;
            
        case 2:
            [[_lowTodos objectAtIndex:indexPath.row] setIsFinished:![[_lowTodos objectAtIndex:indexPath.row] isFinished]];
            [self updateDatabaseForModel: [_lowTodos objectAtIndex:indexPath.row] withContext:[_lowTodos[indexPath.row] managedObjectContext]];
            [[NSNotificationCenter defaultCenter]
                    postNotificationName:@"taskDone"
                    object:self];
            [tableView reloadData];
            break;
    }
}



- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Caution!" message:@"You're attempting to delete an item" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *delete = [UIAlertAction actionWithTitle:@"Delete" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * action){
        NSManagedObjectContext *context;
        switch (editingStyle) {
            case UITableViewCellEditingStyleDelete:
                switch (indexPath.section) {
                    case 0:
                        context = [[self->_highTodos objectAtIndex:indexPath.row] managedObjectContext];
                        [context deleteObject:[self->_highTodos objectAtIndex:indexPath.row]];
                        [self->_highTodos removeObjectAtIndex:indexPath.row];
                        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
                        [context save: NULL];
                        break;
                    case 1:
                        context = [[self->_medTodos objectAtIndex:indexPath.row] managedObjectContext];
                        [context deleteObject:[self->_medTodos objectAtIndex:indexPath.row]];
                        [self->_medTodos removeObjectAtIndex:indexPath.row];
                        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
                        [context save: NULL];
                        break;
                    case 2:
                        context = [[self->_lowTodos objectAtIndex:indexPath.row] managedObjectContext];
                        [context deleteObject:[self->_lowTodos objectAtIndex:indexPath.row]];
                        [self->_lowTodos removeObjectAtIndex:indexPath.row];
                        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
                        [context save: NULL];
                        break;
                }
                break;
            default:
                break;
        }
    }];
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleDefault handler:NULL];
   
    [alert addAction:delete];
    [alert addAction:cancel];
    
    [self presentViewController:alert animated:YES completion:NULL];
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 120;
}

- (void)didTapMarkAsDoneForIndexPath:(NSIndexPath *)indexPath {
    
    switch(indexPath.section) {
        case 0:
            [[_highTodos objectAtIndex:indexPath.row] setIsFinished:YES];
            [self updateDatabaseForModel: [_medTodos objectAtIndex:indexPath.row]withContext:[_medTodos[indexPath.row] managedObjectContext]];
            [[NSNotificationCenter defaultCenter]
                    postNotificationName:@"taskDone"
                    object:self];
            break;
        case 1:
            [[_medTodos objectAtIndex:indexPath.row] setIsFinished:YES];
            [self updateDatabaseForModel: [_lowTodos objectAtIndex:indexPath.row]withContext:[_medTodos[indexPath.row] managedObjectContext]];
            [[NSNotificationCenter defaultCenter]
                    postNotificationName:@"taskDone"
                    object:self];
            break;;
        case 2:
            [[_lowTodos objectAtIndex:indexPath.row] setIsFinished:YES];
            [self updateDatabaseForModel: [_lowTodos objectAtIndex:indexPath.row]withContext:[_medTodos[indexPath.row] managedObjectContext]];
            [[NSNotificationCenter defaultCenter]
                    postNotificationName:@"taskDone"
                    object:self];
            break;
    }
    [_tableView reloadData];
}



- (void)toDoItemAdderDidSaveWith:(ToDoItem *)todo andContext: (NSManagedObjectContext*) context{
    
    NSManagedObject *entityObject = [NSEntityDescription insertNewObjectForEntityForName:@"ToDoEntity"
                                                                  inManagedObjectContext:context];
    NSNumber *priorityFlag = [NSNumber numberWithInt:[todo priorityFlag]];

    [entityObject setValue:[todo title] forKey:@"title"];
    [entityObject setValue:[todo taskDescription] forKey:@"taskDescription"];
    [entityObject setValue: priorityFlag forKey:@"priorityFlag"];
    [entityObject setValue:[todo endsAtDate] forKey:@"endsAtDate"];
    [entityObject setValue:[NSNumber numberWithBool:[todo isFinished]] forKey:@"isFinished"];
    [entityObject setValue:[NSNumber numberWithBool:[todo isStarted]] forKey:@"isStarted"];
    
    [_appDelegate saveContext];
    
    
    switch([todo priorityFlag]) {
        case 0:
            [_lowTodos addObject:entityObject];
            break;
        case 1:
            [_medTodos addObject:entityObject];
            break;
        case 2:
            [_highTodos addObject:entityObject];
            break;
    }
    
    [_tableView setHidden:NO];
    [_imageView setHidden:YES];
    [_tableView reloadData];
}


- (void)didTapDeleteForIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.section) {
        case 0:
            
            [_context deleteObject:[_highTodos objectAtIndex:indexPath.row]];
            [_highTodos removeObjectAtIndex:indexPath.row];
            [_tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
            [_context save:NULL];
            break;
            
        case 1:
            [_context deleteObject:[_medTodos objectAtIndex:indexPath.row]];
            [_medTodos removeObjectAtIndex:indexPath.row];
            [_tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
            [_context save:NULL];
            break;
        case 2:
            [_context deleteObject:[_lowTodos objectAtIndex:indexPath.row]];
            [_lowTodos removeObjectAtIndex:indexPath.row];
            [_tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
            [_context save:NULL];
            break;
    }
}

@end

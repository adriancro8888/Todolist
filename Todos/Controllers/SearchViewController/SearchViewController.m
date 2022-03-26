//
//  SearchViewController.m
//  Todos
//
//  Created by Amr Hossam on 30/01/2022.
//

#import "SearchViewController.h"
#import "CustomTableViewCell.h"
#import "AppDelegate.h"
@interface SearchViewController ()
@property (weak, nonatomic) IBOutlet UITableView *searchTableView;
@end

@implementation SearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [_searchTableView registerClass:[CustomTableViewCell class] forCellReuseIdentifier:@"cell"];
    [_searchTableView setDelegate:self];
    [_searchTableView setDataSource:self];
    [_searchTableView setSeparatorStyle:0];
    _searchBar = (UISearchBar*)_searchTableView.tableHeaderView;
    [_searchBar setDelegate:self];
    _todos = [NSMutableArray new];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_todos count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CustomTableViewCell* cell = (CustomTableViewCell*)[tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    [cell configureCellWithModel: _todos[indexPath.row]];
    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 120;
}


- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    if(searchText.length > 0) {

        AppDelegate *appDelegate = (AppDelegate*)[UIApplication sharedApplication].delegate ;

        NSManagedObjectContext *managedObjectContext = appDelegate.persistentContainer.viewContext;
        NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"ToDoEntity"];

        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"title contains %@", searchText];
        [fetchRequest setPredicate:predicate];
        _todos = [[managedObjectContext executeFetchRequest:fetchRequest error:nil] mutableCopy];
        [_searchTableView reloadData];
    } else if (searchText.length == 0) {
        _todos = [NSMutableArray new];
        [_searchTableView reloadData];
    }
}

@end

//
//  SearchViewController.h
//  Todos
//
//  Created by Amr Hossam on 30/01/2022.
//

#import <UIKit/UIKit.h>



@interface SearchViewController : UIViewController<UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate>


@property UISearchBar *searchBar;
@property NSMutableArray *todos;
@end



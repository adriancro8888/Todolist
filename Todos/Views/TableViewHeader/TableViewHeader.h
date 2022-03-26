//
//  TableViewHeader.h
//  Todos
//
//  Created by Amr Hossam on 28/01/2022.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"


@interface TableViewHeader : UIView <UICollectionViewDelegate, UICollectionViewDataSource>

@property UICollectionView *collectionView;
@property NSArray *inProgressArr;
@property UIImageView *imageView;
@property AppDelegate *appDelegate;
@property NSManagedObjectContext *context;
@property UILabel *sectionHeaderTitle;
-(void) fetchData;

@end



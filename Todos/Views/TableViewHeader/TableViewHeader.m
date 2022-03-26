//
//  TableViewHeader.m
//  Todos
//
//  Created by Amr Hossam on 28/01/2022.
//

#import "TableViewHeader.h"
#import "InProgressCollectionViewCell.h"

@implementation TableViewHeader


- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    _appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    _context = _appDelegate.persistentContainer.viewContext;
    _sectionHeaderTitle = [[UILabel alloc] initWithFrame:CGRectMake(20, 30, self.frame.size.width, 20)];
    _sectionHeaderTitle.text = @"Still in Progress...";
    _sectionHeaderTitle.font = [UIFont systemFontOfSize:19 weight:UIFontWeightThin];
    [self addSubview:_sectionHeaderTitle];
    _inProgressArr = [NSMutableArray new];
    UICollectionViewFlowLayout *layout = [UICollectionViewFlowLayout new];
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    layout.itemSize = CGSizeMake(frame.size.width - 80, frame.size.height - 60);
    layout.minimumLineSpacing = 10;

    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 60, self.frame.size.width, self.frame.size.height - 60) collectionViewLayout:layout];
    [_collectionView registerClass:[InProgressCollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
    [_collectionView setDelegate:self];
    _collectionView.contentInset = UIEdgeInsetsMake(0, 10, 0, 10);
    _collectionView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentAlways;
    [_collectionView setDataSource:self];
    [[NSNotificationCenter defaultCenter] addObserver:self
            selector:@selector(didRecieveTaskStartedNotification)
            name:@"taskStarted"
            object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
            selector:@selector(fetchData)
            name:@"taskDone"
            object:nil];


    _imageView = [[UIImageView alloc] initWithImage: [UIImage imageNamed:@"notracks"]];
    _imageView.frame = self.bounds;
    _imageView.contentMode = UIViewContentModeScaleAspectFit;
    [self addSubview:_collectionView];
    [self addSubview:_imageView];
    [self initSetup];
    return self;
}

- (void) didRecieveTaskStartedNotification {
    [_collectionView reloadData];
}


-(void) initSetup {
    [self fetchData];
    if([_inProgressArr count] == 0) {
        [_sectionHeaderTitle setHidden:YES];

    } else {
        [_sectionHeaderTitle setHidden:NO];
        [_imageView setHidden:YES];

        
    }
}


-(void) fetchData {
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"ToDoEntity" inManagedObjectContext:_context];
    [fetchRequest setEntity:entity];
    // fetch all objects
    NSError *error = nil;
    _inProgressArr = [NSArray new];
    NSArray* fetchedObj = [_context executeFetchRequest:fetchRequest error:&error];
    NSMutableArray *arr = [NSMutableArray new];
    for(int i=0; i< [fetchedObj count]; i++) {
        if(![fetchedObj[i] isFinished] && [fetchedObj[i] isStarted]) {
            [arr addObject:fetchedObj[i]];
        }
    }
    _inProgressArr = arr;
    if([_inProgressArr count] == 0) {
        [_imageView setHidden:NO];
        [_sectionHeaderTitle setHidden:YES];
    }
    [_collectionView reloadData];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [_inProgressArr count];
}


- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    InProgressCollectionViewCell *cell = (InProgressCollectionViewCell*)[collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    
    [_imageView setHidden:YES];
    [cell configureCellWithModel: _inProgressArr[indexPath.row]];
    if([_inProgressArr count] == 0) {
        [_sectionHeaderTitle setHidden:YES];
    } else {
        [_sectionHeaderTitle setHidden:NO];
    }
    
    return cell;
}






@end

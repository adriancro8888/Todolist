//
//  InProgressCollectionViewCell.h
//  Todos
//
//  Created by Amr Hossam on 28/01/2022.
//

#import <UIKit/UIKit.h>
#import "InProgressCollectionViewCell.h"
#import "ToDoItem.h"



@interface InProgressCollectionViewCell : UICollectionViewCell

@property UILabel *label;
@property UILabel *dueDateLabel;

-(void) configureCellWithModel: (ToDoItem*) item;



@end



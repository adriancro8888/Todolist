//
//  InProgressCollectionViewCell.m
//  Todos
//
//  Created by Amr Hossam on 28/01/2022.
//

#import "InProgressCollectionViewCell.h"
#import <ChameleonFramework/Chameleon.h>

@implementation InProgressCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    _label = [[UILabel alloc] initWithFrame:CGRectMake(10, 20, self.frame.size.width - 20, 50)];
    _label.font = [UIFont systemFontOfSize:32 weight:UIFontWeightBold];
    _label.textColor = UIColor.whiteColor;
    _dueDateLabel = [[UILabel alloc] initWithFrame: CGRectMake(self.frame.size.width / 2.5, self.frame.size.height-50, self.frame.size.width / 1.5, 50)];
    _dueDateLabel.textColor = UIColor.whiteColor;
    _dueDateLabel.font = [UIFont systemFontOfSize:18 weight:UIFontWeightMedium];
    [_dueDateLabel setText:@"Due date: 21/2"];
    [self addSubview:_dueDateLabel];
    [self addSubview:_label];
    [self setBackgroundColor:UIColor.randomFlatColor];
    self.layer.masksToBounds = YES;
    self.layer.cornerRadius = 15;
    
    
    return self;
    
}


- (void)configureCellWithModel:(ToDoItem *)item {
    [_label setText:item.title];

    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"MMM-dd HH:mm"];
    NSString *str = [formatter stringFromDate:item.endsAtDate];
    NSString *placeholderText = @"Ends at: ";
    [_dueDateLabel setText:[placeholderText stringByAppendingString:str]];
}


@end

//
//  CustomTableViewCell.m
//  Todos
//
//  Created by Amr Hossam on 28/01/2022.
//

#import "CustomTableViewCell.h"
#import <ChameleonFramework/Chameleon.h>

@implementation CustomTableViewCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    _customContent = [[UIView alloc] initWithFrame:CGRectMake(10, 10, UIScreen.mainScreen.bounds.size.width - 20, 100)];
    [_customContent setBackgroundColor: [UIColor colorWithHexString:@"#E5F7FF"]];
    _customContent.layer.masksToBounds = YES;
    _customContent.layer.cornerRadius = 25;
    _doneIndicator = [[UIImageView alloc] initWithImage: [UIImage systemImageNamed:@"checkmark"]];
    
    
    _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 20, _customContent.frame.size.width -40, _customContent.frame.size.height - 40)];
    _titleLabel.textColor = UIColor.darkGrayColor;
    _titleLabel.font = [UIFont systemFontOfSize:22 weight:UIFontWeightBold];
    _titleLabel.text = @"Testing the layout if it's working";
    [_customContent addSubview:_titleLabel];
    [self addSubview:_customContent];
    
    
    _disclosureButton = [[UIButton alloc] initWithFrame:CGRectMake(UIScreen.mainScreen.bounds.size.width - 80, 18, 60, 60)];
    [_disclosureButton setImage:[UIImage systemImageNamed:@"chevron.right" withConfiguration: [UIImageSymbolConfiguration configurationWithPointSize:28 weight:UIImageSymbolWeightBold]] forState:UIControlStateNormal];
    [self sendSubviewToBack:self.contentView];
    [_customContent addSubview:_disclosureButton];
    [_disclosureButton addTarget:self action:@selector(didTapDisclosure) forControlEvents:UIControlEventTouchUpInside];
    [self bringSubviewToFront:_customContent];
    [_customContent bringSubviewToFront:_disclosureButton];
    [_doneIndicator setHidden:YES];
    [_doneIndicator setTintColor:[UIColor colorWithHexString:@"#ede4e4"]];
    [self.customContent addSubview:_doneIndicator];
    return self;
}


-(void) didTapDisclosure {
    [_delegate didTapDisclosureForIndexPath:_indexPath];
}

- (void) configureCellWithModel:(ToDoItem *) model {
    [_titleLabel setText:model.title];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    _doneIndicator.frame = CGRectMake(self.frame.size.width - 110, self.frame.size.height / 2 - 25, 30, 30);
}

@end

//
//  CustomTableViewCellDelegate.h
//  Todos
//
//  Created by Amr Hossam on 29/01/2022.
//

#import <UIKit/UIKit.h>



@protocol CustomTableViewCellDelegate <NSObject>


-(void) didTapDisclosureForIndexPath: (NSIndexPath*) indexPath;

@end





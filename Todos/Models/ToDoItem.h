//
//  ToDoItem.h
//  Todos
//
//  Created by Amr Hossam on 29/01/2022.
//

#import <Foundation/Foundation.h>

@interface ToDoItem : NSObject // <NSCoding, NSSecureCoding>

@property NSString *title;
@property NSString *taskDescription;
@property NSDate *endsAtDate;
@property int priorityFlag;
@property BOOL isStarted;
@property BOOL isFinished;



- (instancetype)initWithItemTitle:(NSString *) title itemDescription :(NSString*) itemDescription endsAtTask:(NSDate*) date andPriority:(int) priority;
@end




//
//  ToDoItem.m
//  Todos
//
//  Created by Amr Hossam on 29/01/2022.
//

#import "ToDoItem.h"

@implementation ToDoItem

- (instancetype)initWithItemTitle:(NSString *)title itemDescription:(NSString *)itemDescription endsAtTask:(NSDate *)date andPriority:(int) priority {
    _title = title;
    _taskDescription = itemDescription;
    _endsAtDate = date;
    _priorityFlag = priority;
    _isStarted = NO;
    _isFinished = NO;
    return self;
}
- (void) encodeWithCoder:(nonnull NSCoder *)coder {
    [coder encodeObject:_title forKey:@"title"];
    [coder encodeObject:_taskDescription forKey:@"taskDescription"];
    [coder encodeObject:_endsAtDate forKey:@"endsAtDate"];
    [coder encodeInt:_priorityFlag forKey:@"priorityFlag"];
    [coder encodeBool:_isStarted forKey:@"isStarted"];
    [coder encodeBool:_isFinished forKey:@"isFinished"];

    
}

- (nullable instancetype)initWithCoder:(nonnull NSCoder *)coder {
    if (self == [super init]) {
        _title = [coder decodeObjectOfClass:[NSString class] forKey:@"title"];
        _taskDescription = [coder decodeObjectOfClass:[NSString class] forKey:@"taskDescription"];
        _endsAtDate = [coder decodeObjectOfClass:[NSDate class] forKey:@"endsAtDate"];
        _priorityFlag = [coder decodeIntForKey:@"priorityFlag"];
        _isStarted = [coder decodeBoolForKey:@"isStarted"];
        _isFinished = [coder decodeBoolForKey:@"isFinished"];
    }
    
    return self;
}

+ (BOOL)supportsSecureCoding {
    return YES;
}

@end

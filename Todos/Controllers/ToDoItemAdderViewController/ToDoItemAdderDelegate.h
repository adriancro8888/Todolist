//
//  ToDoItemAdderDelegate.h
//  Todos
//
//  Created by Amr Hossam on 29/01/2022.
//

#import <Foundation/Foundation.h>
#import "ToDoItem.h"


@protocol ToDoItemAdderDelegate <NSObject>

- (void)toDoItemAdderDidSaveWith:(ToDoItem *)todo andContext: (NSManagedObjectContext*) context;


@end



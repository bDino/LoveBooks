//
//  ModelManager.m
//  LoveBooks
//
//  Created by Dino on 17/05/14.
//  Copyright (c) 2014 Haw-Hamburg. All rights reserved.
//

#import "ModelManager.h"
#import "AppDelegate.h"
#import "BookItem.h"
#import "Genre.h"

@interface ModelManager ()

@property AppDelegate * appDelegate;

@end

@implementation ModelManager

- (id)init
{
    if (self = [super init])
    {
        self.appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    }

    return self;
}

- (NSUInteger)countAllGenres
{
    NSFetchRequest *fr = [NSFetchRequest fetchRequestWithEntityName:@"Genre"];
    return [self.appDelegate.managedObjectContext countForFetchRequest:fr error:nil];
}

- (NSUInteger)countAllBooks
{
    NSFetchRequest *fr = [NSFetchRequest fetchRequestWithEntityName:@"BookItem"];
    return [self.appDelegate.managedObjectContext countForFetchRequest:fr error:nil];
}

- (NSArray *)getAllGenres
{
    NSFetchRequest *fetchRequest = [NSFetchRequest
                                    fetchRequestWithEntityName:@"Genre"];

    NSSortDescriptor *orderByName = [NSSortDescriptor sortDescriptorWithKey:@"name"
                                                                  ascending:YES];

    [fetchRequest setSortDescriptors:@[orderByName]];

    return [self.appDelegate.managedObjectContext
            executeFetchRequest:fetchRequest error:nil];
}

- (NSArray *)getAllBooks
{
    NSFetchRequest *fetchRequest = [NSFetchRequest
                                    fetchRequestWithEntityName:@"BookItem"];
    return [self.appDelegate.managedObjectContext
            executeFetchRequest:fetchRequest error:nil];
}

- (BookItem *)createBookItem {
    return [NSEntityDescription insertNewObjectForEntityForName:@"BookItem" inManagedObjectContext:self.appDelegate.managedObjectContext];
}

- (void)saveContext
{
    [self.appDelegate saveContext];
}

- (void)rollbackContext {
    [self.appDelegate.managedObjectContext rollback];
}

@end

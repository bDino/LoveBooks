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

@interface ModelManager ()

@property AppDelegate * appDelegate;

-(BOOL) addNewBookItem:(NSString *)_author title:(NSString *)_title isbn:(NSString *)_isbn;
-(NSArray *) fetchImtes:(NSString *) entityName;

@end

@implementation ModelManager

-(id)init
{
    if (self = [super init])
    {
        self.appDelegate =(AppDelegate *)[[UIApplication sharedApplication] delegate];
    }
    
    return self;
}

-(NSArray *) getAllGenres
{
    return [self fetchImtes:@"Genre"];
}


-(NSArray *) getAllBooks
{
    return [self fetchImtes:@"BookItem"];
}

#pragma mark - Private Functions

-(BOOL) addNewBookItem:(NSString *)_author title:(NSString *)_title isbn:(NSString *)_isbn
{
    BookItem* book1 = (BookItem*)[NSEntityDescription insertNewObjectForEntityForName:@"BookItem" inManagedObjectContext:self.appDelegate.managedObjectContext];
    
    [book1 setTitle:_title];
    [book1 setIsbn:_isbn];
    [book1 setAuthor:_author];
    [book1 setCreateDate:[NSDate date]];
    
    NSError * error = nil;
    [self.appDelegate saveContext];
    
    if(error == nil) return YES; else return NO;
}

-(NSArray *) fetchImtes:(NSString *)entityName
{
    NSFetchRequest *fetchGenres = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:entityName inManagedObjectContext:self.appDelegate.managedObjectContext];
    
    [fetchGenres setEntity:entity];
    
    NSError *error = nil;
    NSArray *fetchedObjects = [self.appDelegate.managedObjectContext executeFetchRequest:fetchGenres error:&error];
    
    return fetchedObjects;
}

#pragma mark - ModelManagerDelegate
-(void) createNewBookWithAuthor:(NSString *)_author title:(NSString *)_title isbn:(NSString *)_isbn
{
    [self addNewBookItem:_author title:_title isbn:_isbn];
}

@end

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

-(BOOL) addNewBookItem:(NSString *)_author title:(NSString *)_title isbn:(NSString *)_isbn genreSet:(NSSet *)_set;
-(NSArray *) fetchItemsWithName:(NSString *) entityName predicate:(NSPredicate *)pred;

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
    return [self fetchItemsWithName:@"Genre" predicate:nil];
}


-(NSArray *) getAllBooks
{
    return [self fetchItemsWithName:@"BookItem" predicate:nil];
}

#pragma mark - Private Functions

-(BOOL) addNewBookItem:(NSString *)_author title:(NSString *)_title isbn:(NSString *)_isbn genreSet:(NSSet *)_set
{
    BookItem* book1 = (BookItem*)[NSEntityDescription insertNewObjectForEntityForName:@"BookItem" inManagedObjectContext:self.appDelegate.managedObjectContext];
    
    NSMutableSet  * tmpSet = [[NSMutableSet alloc] init];
    
    for (int i = 0; i< _set.count; i++) {
        [tmpSet addObject:(Genre*)[NSEntityDescription insertNewObjectForEntityForName:@"Genre" inManagedObjectContext:self.appDelegate.managedObjectContext]];
    }
    
    [book1 setTitle:_title];
    [book1 setIsbn:_isbn];
    [book1 setAuthor:_author];
    [book1 setGenre:tmpSet];
    [book1 setCreateDate:[NSDate date]];
    
    NSError * error = nil;
    [self.appDelegate saveContext];
    
    if(error == nil) return YES; else return NO;
}

-(NSArray *) fetchItemsWithName:(NSString *)entityName predicate:(NSPredicate *)pred
{
    NSFetchRequest *fetchGenres = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:entityName inManagedObjectContext:self.appDelegate.managedObjectContext];
    
    [fetchGenres setEntity:entity];
    
    if(pred != nil)
    {
        [fetchGenres setPredicate:pred];
    }
    
    NSError *error = nil;
    NSArray *fetchedObjects = [self.appDelegate.managedObjectContext executeFetchRequest:fetchGenres error:&error];
    
    return fetchedObjects;
}

#pragma mark - ModelManagerDelegate
-(void) createOrUpdateBookWithAuthor:(NSString *)_author title:(NSString *)_title isbn:(NSString *)_isbn genreSet:(NSSet *)_set
{
    NSPredicate * predicate = [NSPredicate predicateWithFormat:@"isbn = %@",_isbn];
    NSArray * foundResult = [self fetchItemsWithName:@"BookItem" predicate:predicate];
    
    if(foundResult == nil || foundResult.count == 0)
    {
        [self addNewBookItem:_author title:_title isbn:_isbn genreSet:_set];
    }else
    {
        BookItem * book1 = (BookItem *) foundResult.firstObject;
        
        book1.author = _author;
        book1.title = _title;
        book1.isbn = _isbn;
        book1.genre = _set;
    
        [self.appDelegate saveContext];
    }
}


@end

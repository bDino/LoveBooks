//
//  BookItem.h
//  LoveBooks
//
//  Created by Dino on 17/05/14.
//  Copyright (c) 2014 Haw-Hamburg. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface BookItem : NSManagedObject

@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) NSString * author;
@property (nonatomic, retain) NSString * isbn;
@property (nonatomic, retain) NSDate * createDate;
@property (nonatomic, retain) NSSet *genre;
@end

@interface BookItem (CoreDataGeneratedAccessors)

- (void)addGenreObject:(NSManagedObject *)value;
- (void)removeGenreObject:(NSManagedObject *)value;
- (void)addGenre:(NSSet *)values;
- (void)removeGenre:(NSSet *)values;

@end

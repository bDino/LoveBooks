//
//  BookItem.h
//  LoveBooks
//
//  Created by Luciano Maiwald on 19.05.14.
//  Copyright (c) 2014 Haw-Hamburg. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Genre;

@interface BookItem : NSManagedObject

@property (nonatomic, retain) NSString * author;
@property (nonatomic, retain) NSString * isbn;
@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) NSSet * genres;
@end

@interface BookItem (CoreDataGeneratedAccessors)

- (void)addGenresObject:(Genre *)value;
- (void)removeGenresObject:(Genre *)value;
- (void)addGenres:(NSSet *)values;
- (void)removeGenres:(NSSet *)values;

- (NSString *)genreNames;

@end

//
//  Genre.h
//  LoveBooks
//
//  Created by Luciano Maiwald on 19.05.14.
//  Copyright (c) 2014 Haw-Hamburg. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class BookItem;

@interface Genre : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSSet *bookItems;
@end

@interface Genre (CoreDataGeneratedAccessors)

- (void)addBookItemsObject:(BookItem *)value;
- (void)removeBookItemsObject:(BookItem *)value;
- (void)addBookItems:(NSSet *)values;
- (void)removeBookItems:(NSSet *)values;

@end

//
//  ModelManager.h
//  LoveBooks
//
//  Created by Dino on 17/05/14.
//  Copyright (c) 2014 Haw-Hamburg. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BookItem.h"
#import "Genre.h"

@interface ModelManager : NSObject

- (NSUInteger)countAllGenres;
- (NSUInteger)countAllBooks;

- (NSArray *)getAllGenres;
- (NSArray *)getAllBooks;

- (BookItem *)createBookItem;

- (void) saveContext;
- (void)rollbackContext;

@end

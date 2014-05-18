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

@protocol ModelManagerDelegate <NSObject>

-(void) createOrUpdateBookWithAuthor:(NSString *) _author
                      title:(NSString *) _title
                      isbn:(NSString *) _isbn
                       genreSet:(NSSet *) _set;

//-(void) addGenreToBook:(BookItem *)book genre:(Genre *)gen;
//-(void) removeGenreFromBook:(BookItem *)book genre:(Genre *)gen;

@end

@interface ModelManager : NSObject <ModelManagerDelegate>

-(NSArray *) getAllGenres;
-(NSArray *) getAllBooks;

@end

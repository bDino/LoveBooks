//
//  ModelManager.h
//  LoveBooks
//
//  Created by Dino on 17/05/14.
//  Copyright (c) 2014 Haw-Hamburg. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ModelManagerDelegate <NSObject>

-(void) createNewBookWithAuthor:(NSString *) _author
                      title:(NSString *) _title
                      isbn:(NSString *) _isbn;
@end

@interface ModelManager : NSObject <ModelManagerDelegate>

-(NSArray *) getAllGenres;
-(NSArray *) getAllBooks;

@end

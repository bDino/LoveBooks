//
//  BookItem.m
//  LoveBooks
//
//  Created by Dino on 16/06/14.
//  Copyright (c) 2014 Haw-Hamburg. All rights reserved.
//

#import "BookItem.h"
#import "Genre.h"


@implementation BookItem

@dynamic author;
@dynamic isbn;
@dynamic title;
@dynamic image;
@dynamic genres;

- (NSString*)genreNames
{
    NSMutableArray * result = [[NSMutableArray alloc] init];
    for (Genre *genre in self.genres)
    {
        [result addObject:genre.name];
    }
    
    [result sortUsingComparator:^(id o1, id o2){
        return [(NSString *)o1 compare:(NSString *)o2];
    }];
    
    return [result componentsJoinedByString:@", "];
}
@end

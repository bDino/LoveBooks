//
//  BookDownloaderDelegate.h
//  LoveBooks
//
//  Created by Luciano Maiwald on 11.06.14.
//  Copyright (c) 2014 Haw-Hamburg. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BookItem.h"

#define BOOK_API_ENDPOINT @"https://isbndb.com/api/v2/json/WWOAWQAE/book/"

@protocol BookDownloaderDelegate <NSObject>

-(void)didUpdateBook:(BookItem *)book;

@end

@interface BookDownloader : NSObject

@property (weak, nonatomic) id<BookDownloaderDelegate> delegate;

-(void)updateBook:(BookItem *)book ByIsbn:(NSString *)isbn;

@end

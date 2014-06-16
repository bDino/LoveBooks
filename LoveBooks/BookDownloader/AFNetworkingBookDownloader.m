//
//  AFNetworkingBookDownloader.m
//  LoveBooks
//
//  Created by Luciano Maiwald on 11.06.14.
//  Copyright (c) 2014 Haw-Hamburg. All rights reserved.
//

#import "AFNetworkingBookDownloader.h"

@implementation AFNetworkingBookDownloader

-(void)updateBook:(BookItem *)book byIsbn:(NSString *)isbn
{
    NSLog(@"Using AFNetworkingBookDownloader");

    NSURL * url = [NSURL URLWithString:[BOOK_API_ENDPOINT stringByAppendingString:isbn]];
    NSURLRequest * request = [NSURLRequest requestWithURL:url];

    [AFJSONRequestOperation addAcceptableContentTypes:[NSSet setWithObject:@"text/plain"]];
    AFJSONRequestOperation * operation = [[AFJSONRequestOperation alloc] initWithRequest:request];
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *data = [[responseObject objectForKey:@"data"] objectAtIndex:0];

        if (data)
        {
            NSArray *authorData = [data objectForKey:@"author_data"];
            
            if([authorData isKindOfClass:[NSArray class]]
               && authorData.count > 0)
            {
                NSDictionary *author = [[data objectForKey:@"author_data"] objectAtIndex:0];
            
                book.author = [author objectForKey:@"name"];
            }else
            {
                book.author = @"Couldn retrieve author";
            }
            
            book.isbn = [data objectForKey:@"isbn10"];
            book.title = [data objectForKey:@"title"];

            dispatch_async(dispatch_get_main_queue(), ^{
                [self.delegate didUpdateBook:book];
            });

        }
        else
        {
            NSString * errorMessage = [NSString stringWithFormat:@"Could not find Book with ISBN: %@", isbn];

            dispatch_async(dispatch_get_main_queue(), ^{
                [self.delegate didReceiveErrorUpdatingBook:errorMessage];
            });
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"error: %@", error);
        NSString * errorMessage = @"Could not connect to isbndb.com";

        dispatch_async(dispatch_get_main_queue(), ^{
            [self.delegate didReceiveErrorUpdatingBook:errorMessage];
        });
    }];

    [operation start];
}

@end

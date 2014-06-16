//
//  NSURLSessionBookDownloader.m
//  LoveBooks
//
//  Created by Luciano Maiwald on 11.06.14.
//  Copyright (c) 2014 Haw-Hamburg. All rights reserved.
//

#import "NSURLSessionBookDownloader.h"

@interface NSURLSessionBookDownloader ()

@property (strong) NSURLSession * session;

@end

@implementation NSURLSessionBookDownloader

-(id)init
{
    if (self = [super init])
    {
        NSURLSessionConfiguration * configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
        self.session = [NSURLSession sessionWithConfiguration:configuration];
    }

    return self;
}

//Testing with ISBN 0615464807
-(void)updateBook:(BookItem *)book byIsbn:(NSString *)isbn
{
    NSURL * url = [NSURL URLWithString:[BOOK_API_ENDPOINT stringByAppendingString:isbn]];
    [[self.session dataTaskWithURL:url
                 completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                    if (!error)
                    {
                        NSDictionary *jsonObject = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];

                        NSDictionary *data = [[jsonObject objectForKey:@"data"] objectAtIndex:0];

                        if (data)
                        {
                            NSDictionary *author = [[data objectForKey:@"author_data"] objectAtIndex:0];

                            book.author = [author objectForKey:@"name"];
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
                    }
                    else
                    {
                        NSString * errorMessage = @"Could not connect to isbndb.com";

                        dispatch_async(dispatch_get_main_queue(), ^{
                            [self.delegate didReceiveErrorUpdatingBook:errorMessage];
                        });                    }
                    }
     ] resume];
}


@end

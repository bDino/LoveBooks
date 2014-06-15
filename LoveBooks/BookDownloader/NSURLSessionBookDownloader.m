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
-(void)updateBook:(BookItem *)book ByIsbn:(NSString *)isbn
{
    NSURL * url = [NSURL URLWithString:[BOOK_API_ENDPOINT stringByAppendingString:isbn]];
    [[self.session dataTaskWithURL:url
                 completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                    if (!error) {
                        NSDictionary *jsonObject = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];

                        @try
                        {
                            NSArray *data = [jsonObject objectForKey:@"data"];
                            NSArray *author = ([(NSDictionary *)[data objectAtIndex:0] objectForKey:@"author_data"]);
                        
                            book.isbn = ([(NSDictionary *)[data objectAtIndex:0] objectForKey:@"isbn10"]);
                            book.author = ([(NSDictionary *)[author objectAtIndex:0] objectForKey:@"name"]);
                            book.title = ([(NSDictionary *)[data objectAtIndex:0] objectForKey:@"title"]);
                        
                            [self.delegate didUpdateBook:book];
                        }
                        @catch
                        (NSException * e) {
                            NSLog(@"Exception: %@", e);
                        }
                        @finally
                        {
                            [self.delegate didUpdateBook:nil];                        
                        }
                        
                    }else
                    {
                        NSLog(@"Error: %@ %@", error, [error userInfo]);
                        [self.delegate didUpdateBook:nil];
                    }
                }
     ] resume];
}


@end

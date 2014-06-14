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

-(void)updateBook:(BookItem *)book ByIsbn:(NSString *)isbn
{
    NSURL * url = [NSURL URLWithString:[BOOK_API_ENDPOINT stringByAppendingString:isbn]];
    [self.session dataTaskWithURL:url
                completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                    if (!error) {
                        NSObject *jsonObject = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];

                        NSLog(jsonObject);
                    }

                }
     ];
}

@end

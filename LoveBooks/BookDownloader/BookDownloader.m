//
//  BookDownloader.m
//  LoveBooks
//
//  Created by Luciano Maiwald on 11.06.14.
//  Copyright (c) 2014 Haw-Hamburg. All rights reserved.
//

#import "BookDownloader.h"

@implementation BookDownloader

-(void)updateBook:(BookItem *)book ByIsbn:(NSString *)isbn
{
    [NSException raise:@"Must be overridden by subclass"
                format:@"Must be overridden by subclass"];
}

@end
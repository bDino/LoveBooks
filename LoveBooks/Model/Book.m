//
//  Book.m
//  iOS_Praktikum_1
//
//  Created by Dino on 05.04.14.
//  Copyright (c) 2014 Haw-Hamburg. All rights reserved.
//

#import "Book.h"

@implementation Book

-(id)init
{
    if (self = [super init])
    {
        self.author = @"";
        self.isbn = @"";
    }

    return self;
}

- initWithTitle:(NSString *)title author:(NSString*)autor isbn:(NSString*)isbn image:(UIImage *)image
{
    if (self = [self init])
    {
        self.title = title;
        self.author = autor;
        self.isbn = isbn;
        self.image = image;
    }

    return self;
}

- (BOOL)isEqual:(id)object
{
    if (![super isEqual: object]) return NO;

    Book *other = (Book*) object;
    return [self.author isEqualToString: other.author]
        && [self.isbn isEqualToString: other.isbn];
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"Title: %@, Author: %@, ISBN: %@",
            self.title, self.author, self.isbn];
}
@end

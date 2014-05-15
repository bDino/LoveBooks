//
//  Item.m
//  iOS_Praktikum_1
//
//  Created by Dino on 06.04.14.
//  Copyright (c) 2014 Haw-Hamburg. All rights reserved.
//

#import "Item.h"

@implementation Item

-(id)init
{
    if (self = [super init])
    {
        self.title = @"";
    }

    return self;
}

-(BOOL)isEqual:(id)object
{
    if (![object isKindOfClass: self.class]) return NO;

    Item *other = (Item*) object;
    return [self.title isEqualToString: other.title];
}

@end

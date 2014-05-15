//
//  Book.h
//  iOS_Praktikum_1
//
//  Created by Dino on 05.04.14.
//  Copyright (c) 2014 Haw-Hamburg. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Item.h"

@interface Book : Item

@property (strong,nonatomic) NSString *author;
@property (strong,nonatomic) NSString *isbn;

- initWithTitle:(NSString *)title author:(NSString*)autor isbn:(NSString*)isbn image:(UIImage *)image;

@end

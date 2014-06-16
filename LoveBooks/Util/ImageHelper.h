//
//  ImageHelper.h
//  LoveBooks
//
//  Created by Dino on 17/06/14.
//  Copyright (c) 2014 Haw-Hamburg. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ImageHelper : NSObject

+ (UIImage *)imageByScalingProportionallyToSize:(CGSize)targetSize Image:(UIImage*) image;

@end

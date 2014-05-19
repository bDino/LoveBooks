//
//  GenreTableViewCell.m
//  LoveBooks
//
//  Created by Dino on 18/05/14.
//  Copyright (c) 2014 Haw-Hamburg. All rights reserved.
//

#import "GenreTableViewCell.h"

@implementation GenreTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)switchChanged:(id)sender {
    if ([sender isOn])
    {
        [self.bookItem addGenresObject:self.genre];
    } else {
        [self.bookItem removeGenresObject:self.genre];
    }
}
@end

//
//  GenreTableViewCell.h
//  LoveBooks
//
//  Created by Dino on 18/05/14.
//  Copyright (c) 2014 Haw-Hamburg. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GenreTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *lblName;
@property (weak, nonatomic) IBOutlet UISwitch *switchUsed;

@end

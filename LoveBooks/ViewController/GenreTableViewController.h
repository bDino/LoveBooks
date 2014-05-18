//
//  GenreTableViewController.h
//  LoveBooks
//
//  Created by Dino on 17/05/14.
//  Copyright (c) 2014 Haw-Hamburg. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ModelManager.h"
#import "BookDetailViewController.h"


@interface GenreTableViewController : UITableViewController <UITableViewDataSource, UITableViewDelegate>

@property (strong,nonatomic) ModelManager * managerInstance;
@property id sender;

@end

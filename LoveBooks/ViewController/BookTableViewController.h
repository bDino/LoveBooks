//
//  BookTableViewController.h
//  iOS_Praktikum_1
//
//  Created by Luciano Maiwald on 25.04.14.
//  Copyright (c) 2014 Haw-Hamburg. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ModelManager.h"


@interface BookTableViewController : UITableViewController <UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) ModelManager * manager;
@property (strong,nonatomic) UIBarButtonItem *btnPushToNewBook;

@end


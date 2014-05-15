//
//  BookTableViewController.h
//  iOS_Praktikum_1
//
//  Created by Luciano Maiwald on 25.04.14.
//  Copyright (c) 2014 Haw-Hamburg. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ItemListManager.h"

@protocol BookItemManagerDelegate <NSObject>

-(void) itemAdded:(Item *) item;

@end

@interface BookTableViewController : UITableViewController <UITableViewDelegate, UITableViewDataSource, BookItemManagerDelegate>

@property (strong, nonatomic) ItemListManager *itemListManager;
@property (strong,nonatomic) UIBarButtonItem *btnPushToNewBook;

@end


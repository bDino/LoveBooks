//
//  ViewController.h
//  iOS_Praktikum_1
//
//  Created by Dino on 05.04.14.
//  Copyright (c) 2014 Haw-Hamburg. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NSURLSessionBookDownloader.h"
#import "ModelManager.h"
#import "BookItem.h"
#import "Genre.h"

@interface BookDetailViewController : UIViewController <UITableViewDataSource, BookDownloaderDelegate>

@property (weak, nonatomic) IBOutlet UITextField *txtAuthor;
@property (weak, nonatomic) IBOutlet UITextField *txtTitle;
@property (weak, nonatomic) IBOutlet UITextField *txtIsbn;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator1;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator2;
@property (weak, nonatomic) IBOutlet UIImageView *bookImageView;

@property (strong, nonatomic) BookDownloader *bookDownloader;
@property (strong, nonatomic) ModelManager *modelManager;
@property (strong, nonatomic) BookItem *book;

- (IBAction)completeByIsbn:(id)sender;

@end

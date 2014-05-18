//  ViewController.m
//  iOS_Praktikum_1
//
//  Created by Dino on 05.04.14.
//  Copyright (c) 2014 Haw-Hamburg. All rights reserved.
//

#import "BookDetailViewController.h"

@interface BookDetailViewController ()

@end

@implementation BookDetailViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    UIBarButtonItem *btnSave  = [[UIBarButtonItem alloc] initWithTitle:@"Save" style:UIBarButtonItemStylePlain target:self action:@selector(actionAddNewBook)];
    
    self.navigationItem.rightBarButtonItem = btnSave;
    self.genreSet = [[NSMutableSet alloc] initWithSet:self.book.genre];
    
    if(self.isEdit)
    {
        self.txtAuthor.text = self.book.author;
        self.txtTitle.text = self.book.title;
        self.txtISBN.text  = self.book.isbn;
    }
}

-(void) viewDidAppear:(BOOL)animated
{
    if(self.genreSet.count != 0)
    {
        NSMutableString * fullGenre = [[NSMutableString alloc] init];
    
        for (Genre * genre1 in self.genreSet) {
            [fullGenre appendFormat:@"%@,",genre1.name];
        }
    
        self.btnSelectGenre.titleLabel.text = fullGenre;
        }
}

-(void)viewDidDisappear:(BOOL)animated
{
    self.genreSet = nil;
    self.book = nil;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)actionAddNewBook
{
    if(![self.txtTitle.text isEqualToString:@""] && ![self.txtISBN.text isEqualToString:@""])
    {
        self.isEdit = NO;
        [self.managerDelegate createOrUpdateBookWithAuthor:self.txtAuthor.text title:self.txtTitle.text isbn:self.txtISBN.text genreSet:self.genreSet];
        [self.navigationController popToRootViewControllerAnimated:YES];
    }
}

- (IBAction)selectGenrePressed:(id)sender {
    [self performSegueWithIdentifier:@"pushToGenre" sender:self];
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    GenreTableViewController *targetVB = (GenreTableViewController *)segue.destinationViewController;
    targetVB.sender = self;
}

@end

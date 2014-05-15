//  ViewController.m
//  iOS_Praktikum_1
//
//  Created by Dino on 05.04.14.
//  Copyright (c) 2014 Haw-Hamburg. All rights reserved.
//

#import "BookDetailViewController.h"

@implementation BookDetailViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    UIBarButtonItem *btnSave  = [[UIBarButtonItem alloc] initWithTitle:@"Save" style:UIBarButtonItemStylePlain target:self action:@selector(actionAddBookToView)];
    
        self.navigationItem.rightBarButtonItem = btnSave;
    
        self.txtAuthor.text = self.bookItem.author;
        self.txtTitle.text = self.bookItem.title;
        self.txtISBN.text = self.bookItem.isbn;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)actionAddBookToView
{
    if(![self.txtTitle.text isEqualToString:@""] && ![self.txtISBN.text isEqualToString:@""])
    {
        [self.bookManagerDelegate itemAdded:[self createBookFromInputs]];
        self.isEdit = NO;
        
        [self.navigationController popToRootViewControllerAnimated:YES];
    }
}

- (Book*)createBookFromInputs
{
    Book *book;
    
    if(self.isEdit)
    {
        book = self.bookItem;
    }else
    {
        book = [[Book alloc] init];
    }
    
    book.title = self.txtTitle.text;
    book.author = self.txtAuthor.text;
    book.isbn = self.txtISBN.text;
    
    return book;
}

@end

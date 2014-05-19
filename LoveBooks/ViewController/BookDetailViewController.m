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
    UIBarButtonItem *btnSave  = [[UIBarButtonItem alloc] initWithTitle:@"Save" style:UIBarButtonItemStylePlain target:self action:@selector(saveBook)];
    
    self.navigationItem.rightBarButtonItem = btnSave;

    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]
                                   initWithTarget:self
                                   action:@selector(dismissKeyboard)];

    [self.view addGestureRecognizer:tap];
}

-(void)dismissKeyboard {
    [self.view resignFirstResponder];
    for(UIView *subview in self.view.subviews)
    {
        [subview resignFirstResponder];
    }
}

-(void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];

    self.txtTitle.text = self.book.title;
    self.txtAuthor.text = self.book.author;
    self.txtIsbn.text = self.book.isbn;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

- (IBAction)saveBook
{
    if(![self.txtTitle.text isEqualToString:@""]
       && ![self.txtIsbn.text isEqualToString:@""])
    {
        self.book.title = self.txtTitle.text;
        self.book.author = self.txtAuthor.text;
        self.book.isbn = self.txtIsbn.text;

        [self.modelManagerDelegate saveContext];
        [self.navigationController popToRootViewControllerAnimated:YES];
    }
}

@end

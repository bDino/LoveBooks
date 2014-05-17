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
    UIBarButtonItem *btnSave  = [[UIBarButtonItem alloc] initWithTitle:@"Save" style:UIBarButtonItemStylePlain target:self action:@selector(actionAddNewBook)];
    
        self.navigationItem.rightBarButtonItem = btnSave;
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
        [self.managerDelegate createNewBookWithAuthor:self.txtAuthor.text title:self.txtTitle.text isbn:self.txtISBN.text];
        [self.navigationController popToRootViewControllerAnimated:YES];
    }
}

@end

//  ViewController.m
//  iOS_Praktikum_1
//
//  Created by Dino on 05.04.14.
//  Copyright (c) 2014 Haw-Hamburg. All rights reserved.
//

#import "BookDetailViewController.h"
#import "GenreTableViewCell.h"

@interface BookDetailViewController ()

@property (strong, nonatomic) NSArray *genres;
@property (strong,nonatomic) UIActivityIndicatorView *activityView;
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

    self.bookDownloader = [[NSURLSessionBookDownloader alloc] init];
    self.bookDownloader.delegate = self;
}

- (void)dismissKeyboard {
    [self.view resignFirstResponder];
    for(UIView *subview in self.view.subviews)
    {
        [subview resignFirstResponder];
    }
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];

    self.genres = [self.modelManager getAllGenres];

    self.txtTitle.text = self.book.title;
    self.txtAuthor.text = self.book.author;
    self.txtIsbn.text = self.book.isbn;
    
    [self.bookImageView.layer setBorderColor: [[UIColor blackColor] CGColor]];
    [self.bookImageView.layer setBorderWidth: 1.0];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

- (IBAction)saveBook
{
    if ([self userEnteredValidData])
    {
        self.book.title = self.txtTitle.text;
        self.book.author = self.txtAuthor.text;
        self.book.isbn = self.txtIsbn.text;

        [self.modelManager saveContext];
        [self.navigationController popViewControllerAnimated:YES];
    }
    else
    {
        UIAlertView *errorAlert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                             message:@"Please enter valid Data!"
                                                            delegate:nil
                                                   cancelButtonTitle:@"OK"
                                                   otherButtonTitles:nil];
        [errorAlert show];
    }
}

- (BOOL)userEnteredValidData
{
    return ![self.txtAuthor.text isEqualToString:@""]
        && ![self.txtTitle.text isEqualToString:@""]
        && ![self.txtIsbn.text isEqualToString:@""];
}

# pragma mark - UITableViewDataSource

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    GenreTableViewCell *cell = (GenreTableViewCell*)[tableView dequeueReusableCellWithIdentifier:@"selectGenreCell" forIndexPath:indexPath];

    Genre* genre = (Genre*)[self.genres objectAtIndex:indexPath.row];

    cell.genre = genre;
    cell.bookItem = self.book;

    cell.lblName.text = genre.name;
    cell.switchUsed.on = [self.book.genres containsObject:genre];

    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.modelManager countAllGenres];
}

# pragma mark - BookDownloaderDelegate
-(void)didUpdateBook:(BookItem *)book;
{
    
    dispatch_async(dispatch_get_main_queue(), ^{
            [self.activityIndicator1 stopAnimating];
            [self.activityIndicator2 stopAnimating];
            
            if(book != nil)
            {
                [self.txtIsbn setEnabled:NO];
                self.txtAuthor.text = book.author;
                self.txtTitle.text = book.title;
            }
            else
            {
                self.txtAuthor.text = @"Error loading resource";
                self.txtTitle.text = @"Error loading resource";
            }
        });
}

- (IBAction)actionIsbnEditingDidEnd:(id)sender {
    if(self.txtIsbn.text.length == 10)
    {
        [self.activityIndicator1 startAnimating];
        [self.activityIndicator2 startAnimating];
        [self.bookDownloader updateBook:self.book ByIsbn:self.txtIsbn.text];
    }

}
@end

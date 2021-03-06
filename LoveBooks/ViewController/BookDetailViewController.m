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
@property (strong, nonatomic) UIActivityIndicatorView *activityView;
@property (strong, nonatomic) UIBarButtonItem *saveButton;
@property (strong,nonatomic) UIImagePickerController *imagePickerController;
@end

@implementation BookDetailViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.saveButton = [[UIBarButtonItem alloc] initWithTitle:@"Save" style:UIBarButtonItemStylePlain target:self action:@selector(saveBook)];
    
    self.navigationItem.rightBarButtonItem = self.saveButton;

    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]
                                   initWithTarget:self
                                   action:@selector(dismissKeyboard)];

    [self.view addGestureRecognizer:tap];

    self.bookDownloader = [[NSURLSessionBookDownloader alloc] init];
    self.bookDownloader.delegate = self;
    
    
    
    self.imagePickerController = [[UIImagePickerController alloc] init];
    self.imagePickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    self.imagePickerController.delegate = self;
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
    
    if(self.book.image != nil)
    {
        [self.imageView setImage:[ImageHelper imageByScalingProportionallyToSize:self.imageView.frame.size
                                                                           Image:[UIImage imageWithData:self.book.image]]];
    }
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

- (IBAction)completeByIsbn:(id)sender {
    if (![self.txtIsbn.text isEqualToString:@""])
    {
        [self.activityIndicator1 startAnimating];
        [self.activityIndicator2 startAnimating];

        self.navigationItem.rightBarButtonItem.enabled = NO;

        [self.bookDownloader updateBook:self.book byIsbn:self.txtIsbn.text];
    }
}

- (IBAction)changedDownloader:(UISegmentedControl *)sender {
    BookDownloader * downloader;

    if (sender.selectedSegmentIndex == 0)
    {
         downloader = [[NSURLSessionBookDownloader alloc] init];
    }
    else
    {
        downloader = [[AFNetworkingBookDownloader alloc] init];
    }

    self.bookDownloader = downloader;
    self.bookDownloader.delegate = self;
}

- (IBAction)setImage:(id)sender {
    [self presentViewController:self.imagePickerController animated:YES completion:nil];
}

- (IBAction)isbnEdited:(id)sender
{
    if(self.txtIsbn.text.length == 10)
    {
        CGRect frame = self.txtIsbn.frame;
        frame.size.width = 105;
        self.txtIsbn.frame = frame;
        
        self.btnComplete.enabled = YES;
        self.btnComplete.hidden = NO;
    }
    else
    {
        self.btnComplete.enabled = NO;
        self.btnComplete.hidden = YES;
    }
}

# pragma mark - BookDownloaderDelegate
-(void)didUpdateBook:(BookItem *)book
{
    [self.activityIndicator1 stopAnimating];
    [self.activityIndicator2 stopAnimating];

    self.navigationItem.rightBarButtonItem.enabled = YES;

    self.txtAuthor.text = book.author;
    self.txtTitle.text = book.title;
}

- (void)didReceiveErrorUpdatingBook:(NSString *)errorMessage
{
    [self.activityIndicator1 stopAnimating];
    [self.activityIndicator2 stopAnimating];

    self.navigationItem.rightBarButtonItem.enabled = YES;

    UIAlertView *errorAlert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                         message:errorMessage
                                                        delegate:nil
                                               cancelButtonTitle:@"OK"
                                               otherButtonTitles:nil];
    [errorAlert show];
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
# pragma mark - UIImagePickerDelegate

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage *image = [info valueForKey:UIImagePickerControllerOriginalImage];
    self.book.image = UIImagePNGRepresentation(image);
    [self.imageView setImage:[ImageHelper imageByScalingProportionallyToSize:self.imageView.frame.size
                                                                       Image:image]];
    [picker dismissViewControllerAnimated:YES completion:^{
    }];
}


@end

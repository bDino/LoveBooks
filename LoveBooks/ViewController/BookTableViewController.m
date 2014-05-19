//
//  BookTableViewController.m
//  iOS_Praktikum_1
//
//  Created by Luciano Maiwald on 25.04.14.
//  Copyright (c) 2014 Haw-Hamburg. All rights reserved.
//

#import "AppDelegate.h"
#import "BookTableViewController.h"
#import "BookItem.h"
#import "BookTableViewCell.h"
#import "BookDetailViewController.h"

@interface BookTableViewController ()

@property NSUInteger selectedIndex;
@property (weak, nonatomic) AppDelegate * appDelegate;
@property (strong, nonatomic) ModelManager * modelManager;

@property (strong, nonatomic) NSArray * items;

@end

@implementation BookTableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.btnPushToNewBook = [[UIBarButtonItem alloc]
                             initWithTitle:@"New"
                             style:UIBarButtonItemStylePlain
                             target:self
                             action:@selector(addBook)];

    self.navigationItem.rightBarButtonItem = self.btnPushToNewBook;
    self.modelManager = [[ModelManager alloc] init];
}

-(void)viewWillAppear:(BOOL)animated
{
    [self.modelManager rollbackContext];
    self.items = [self.modelManager getAllBooks];
    [self.tableView reloadData];
}

-(IBAction)addBook
{
    [self performSegueWithIdentifier:@"pushToAddBook" sender:self];
}

# pragma mark - UITableViewDataSource methods

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    BookTableViewCell *cell = (BookTableViewCell*)[tableView dequeueReusableCellWithIdentifier:@"bookCell" forIndexPath:indexPath];

    BookItem* book = (BookItem*)[self.items objectAtIndex:indexPath.row];

    
    cell.genre.text = [book genreNames];
    cell.title.text = book.title;
    cell.author.text = book.author;
    cell.isbn.text = book.isbn;

    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.modelManager countAllBooks];
}

# pragma mark - UITableViewDelegate methods

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 108;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.selectedIndex = indexPath.row;
    [self performSegueWithIdentifier:@"pushToEditBook" sender:self];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    BookDetailViewController *destination = (BookDetailViewController*)segue.destinationViewController;
    destination.modelManager = self.modelManager;

    if ([segue.identifier isEqualToString:@"pushToEditBook"]) {       
        destination.book = (BookItem*)[self.items objectAtIndex:self.selectedIndex];
    } else if ([segue.identifier isEqualToString:@"pushToAddBook"]) {
        destination.book = [self.modelManager createBookItem];
    }
}


@end

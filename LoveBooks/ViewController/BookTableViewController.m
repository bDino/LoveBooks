//
//  BookTableViewController.m
//  iOS_Praktikum_1
//
//  Created by Luciano Maiwald on 25.04.14.
//  Copyright (c) 2014 Haw-Hamburg. All rights reserved.
//

#import "BookTableViewController.h"
#import "BookItem.h"
#import "BookTableViewCell.h"
#import "BookDetailViewController.h"

@interface BookTableViewController ()

@property NSUInteger selectedIndex;

@end

@implementation BookTableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.btnPushToNewBook = [[UIBarButtonItem alloc] initWithTitle:@"New" style:UIBarButtonItemStylePlain target:self action:@selector(pushToNewBookView)];
    self.navigationItem.rightBarButtonItem = self.btnPushToNewBook;
    self.manager = [[ModelManager alloc] init];
}

-(void)viewWillAppear:(BOOL)animated
{
    [self.tableView reloadData];
}

-(IBAction)pushToNewBookView
{
    [self performSegueWithIdentifier:@"pushSeqNewBook" sender:self];
}

# pragma mark - UITableViewDataSource methods

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    BookTableViewCell *cell = (BookTableViewCell*)[tableView dequeueReusableCellWithIdentifier:@"bookCell" forIndexPath:indexPath];

    NSArray *items = [self.manager getAllBooks];
    BookItem* book = (BookItem*)[items objectAtIndex:indexPath.row];

    cell.title.text = book.title;
    cell.author.text = book.author;
    cell.isbn.text = book.isbn;

    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.manager.getAllBooks count];
}

# pragma mark - UITableViewDelegate methods

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 108;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.selectedIndex = indexPath.row;
    [self performSegueWithIdentifier:@"pushSeqToAddBook" sender:self];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    BookDetailViewController  *targetVB = (BookDetailViewController*)segue.destinationViewController;
    targetVB.managerDelegate = self.manager;
    
    if ([segue.identifier isEqualToString:@"pushSeqToAddBook"]) {
        targetVB.isEdit = YES;
    }
}

# pragma mark - BookItemManagerDelegate

@end

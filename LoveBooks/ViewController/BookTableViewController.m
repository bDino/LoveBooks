//
//  BookTableViewController.m
//  iOS_Praktikum_1
//
//  Created by Luciano Maiwald on 25.04.14.
//  Copyright (c) 2014 Haw-Hamburg. All rights reserved.
//

#import "BookTableViewController.h"
#import "Book.h"
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
    
    self.itemListManager = [[ItemListManager alloc] init];

    Book *book1 = [[Book alloc] initWithTitle:@"Fight Club"
                                       author:@"Chuck Palahniuk"
                                         isbn:@"978-3442542109"
                                        image:[UIImage imageNamed:@"fight_club.jpg"]];

    Book *book2 = [[Book alloc] initWithTitle:@"On the Road"
                                       author:@"Jack Kerouac"
                                         isbn:@"978-0141182674"
                                        image:[UIImage imageNamed:@"on_the_road.jpg"]];

    Book *book3 = [[Book alloc] initWithTitle:@"Pippi Langstrumpf"
                                       author:@"Astrid Lindgren"
                                         isbn:@"978-3789141614"
                                        image:[UIImage imageNamed:@"pippi_langstrump.jpg"]];

    
    Book *book4 = [[Book alloc] initWithTitle:@"The Ultimate of Power Fail"
                                       author:@"POWER FAIL"
                                         isbn:@"876-9384756384"
                                        image:[UIImage imageNamed:@"power_fail.png"]];
    
    [self.itemListManager addItem: book1];
    [self.itemListManager addItem: book2];
    [self.itemListManager addItem: book3];
    [self.itemListManager addItem: book4];
    
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

    Book* book = (Book*)[self.itemListManager objectAtIntex:indexPath.row];

    cell.title.text = book.title;
    cell.author.text = book.author;
    cell.isbn.text = book.isbn;
    cell.image.image = book.image;

    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.itemListManager count];
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
    
    if ([segue.identifier isEqualToString:@"pushSeqToAddBook"]) {

        Book* book = (Book*)[self.itemListManager objectAtIntex:self.selectedIndex];
        targetVB.bookItem = book;
        targetVB.isEdit = YES;
    }
    
        targetVB.bookManagerDelegate = self;
}

# pragma mark - BookItemManagerDelegate

-(void)itemAdded:(Item *) item
{
    [self.itemListManager addItem:item];
}

@end

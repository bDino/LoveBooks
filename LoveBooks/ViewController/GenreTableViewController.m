//
//  GenreTableViewController.m
//  LoveBooks
//
//  Created by Dino on 17/05/14.
//  Copyright (c) 2014 Haw-Hamburg. All rights reserved.
//

#import "GenreTableViewController.h"
#import "Genre.h"
#import "GenreTableViewCell.h"

@interface GenreTableViewController ()

@property NSArray * allGenre;
@property NSUInteger selectedIndex;
@property BookDetailViewController * target;

@end

@implementation GenreTableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.managerInstance = [[ModelManager alloc] init];
    self.allGenre = [self.managerInstance getAllGenres];

    self.target = (BookDetailViewController *) self.sender;
}

-(void)viewWillAppear:(BOOL)animated
{
    [self.tableView reloadData];
    
        for (Genre * g in self.target.genreSet)
        {
            NSPredicate *predicate = [NSPredicate predicateWithFormat:@"name == %@", g.name];
            NSArray *filteredArray = [self.allGenre filteredArrayUsingPredicate:predicate];
            
            if(filteredArray != nil && filteredArray.count != 0)
            {
                Genre * g2 = (Genre *)filteredArray.firstObject;
                g2.selected = [[NSNumber alloc] initWithBool:YES];
            }
        }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.allGenre count];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.selectedIndex = indexPath.row;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    GenreTableViewCell *cell = (GenreTableViewCell*)[tableView dequeueReusableCellWithIdentifier:@"genreCell" forIndexPath:indexPath];

    Genre * genre = (Genre*) [self.allGenre objectAtIndex:indexPath.row];
    cell.lblName.text = genre.name;
    [cell.switchUsed setOn:[genre.selected boolValue]];
    
    return cell;
}


- (IBAction)switchPressed:(id)sender {
    
    CGPoint buttonPosition = [sender convertPoint:CGPointZero toView:self.tableView];
    NSIndexPath *indexPath = [self.tableView indexPathForRowAtPoint:buttonPosition];
    UISwitch *switchInCell = (UISwitch *)sender;
    
    Genre * genre = (Genre*) [self.allGenre objectAtIndex:indexPath.row];
    
    if ([switchInCell isOn])
    {
        [self.target.genreSet addObject:genre];
    }
    else
    {
        Genre * genre2 = (Genre*) [self.allGenre objectAtIndex:indexPath.row];
        genre2.selected = [[NSNumber alloc] initWithBool:NO];
        
        [self.target.genreSet removeObject:genre];
    }
}
 
@end

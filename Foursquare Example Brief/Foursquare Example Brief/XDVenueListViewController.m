//
//  XDTableViewController.m
//  Foursquare Example Brief
//
//  Created by Valentin Hinov on 07/04/2014.
//  Copyright (c) 2014 xDesign365. All rights reserved.
//

#import "XDVenueListViewController.h"
#import "VenueTableViewCell.h"

@interface XDVenueListViewController ()

@property (strong, nonatomic) NSArray *names;
@property (strong, nonatomic) NSArray *distances;
@property (strong, nonatomic) NSArray *addresses;
@property (strong, nonatomic) NSArray *types;
@property (strong, nonatomic) NSArray *scores;

@end

@implementation XDVenueListViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.names = @[@"Subway", @"Pizza Hut", @"Dominos"];
    self.distances = @[@0.3, @0.5, @0.7];
    self.addresses = @[@"15 Simpsons Road", @"16 Simpsons Road", @"17 Simpsons Road"];
    self.types = @[@"Sandwhich Shop", @"Pizza Place", @"Pizza Place"];
    self.scores = @[@2.5, @5.6, @8.9];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table View Creation

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.names count];
}

- (UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"VenueCell";
    VenueTableViewCell *cell = (VenueTableViewCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    cell.name.text = [self.names objectAtIndex:[indexPath row]];
    cell.address.text = [self.addresses objectAtIndex:[indexPath row]];
    cell.type.text = [self.types objectAtIndex:[indexPath row]];
    
    NSNumber *distance = [self.distances objectAtIndex:[indexPath row]];
    cell.distance.text = [NSString stringWithFormat:@"(%@ %@)", [distance stringValue], NSLocalizedString(@"miles", nil)];
    
    NSNumber *score = [self.scores objectAtIndex:[indexPath row]];
    [cell.rating setRating:score];
    
    return cell;
}

#pragma mark - Table View Delegates


@end

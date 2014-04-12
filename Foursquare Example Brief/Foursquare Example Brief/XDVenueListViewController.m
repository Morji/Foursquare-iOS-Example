//
//  XDTableViewController.m
//  Foursquare Example Brief
//
//  Created by Valentin Hinov on 07/04/2014.
//  Copyright (c) 2014 xDesign365. All rights reserved.
//

#import "XDVenueListViewController.h"
#import <RestKit/RestKit.h>
#import "VenueTableViewCell.h"
#import "XDUtilities.h"

@interface XDVenueListViewController () {
    UIRefreshControl *refreshControl;
}

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic, strong) NSFetchedResultsController *fetchedResultsController;

@end

@implementation XDVenueListViewController

@synthesize fetchedResultsController;

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
    [self setupPullToRefresh];
    [self setupFetchedResultsController];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setupPullToRefresh {
    refreshControl = [[UIRefreshControl alloc] init];
    
    refreshControl.attributedTitle = [[NSAttributedString alloc] initWithString:@"Pull to Refresh"];
    [refreshControl addTarget:self action:@selector(pullToRefresh) forControlEvents:UIControlEventValueChanged];
    [self.tableView addSubview:refreshControl];
}

- (void)setupFetchedResultsController {
    NSDictionary *mapDictionary = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"Default map info"];
    float mileReach = [[mapDictionary objectForKey:@"Mile reach"] floatValue];
    int meterReach = [XDUtilities milesToMetersFromFloat:mileReach];
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"Venue"];
    NSPredicate *categoryPredicate = [NSPredicate predicateWithFormat:@"location.distance <= %d", meterReach];
    fetchRequest.predicate = categoryPredicate;
    NSSortDescriptor *distanceDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"location.distance" ascending:YES];
    fetchRequest.sortDescriptors = @[distanceDescriptor];
    
    // Setup fetched results
    fetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest
                                                                        managedObjectContext:[RKManagedObjectStore defaultStore].mainQueueManagedObjectContext
                                                                          sectionNameKeyPath:nil
                                                                                   cacheName:nil]; // TODO - caching?
    [fetchedResultsController setDelegate:self];
    [self refreshTable];
}

- (void)pullToRefresh {
    [[NSNotificationCenter defaultCenter] postNotificationName:@"Reload Venues" object:nil];
}

- (void)refreshTable {
    NSError *error = nil;
    BOOL fetchSuccessful = [fetchedResultsController performFetch:&error];
    BOOL hasObjects = [fetchedResultsController fetchedObjects].count > 0;
    if (!fetchSuccessful) {
        [XDUtilities showAlert:@"Venue List Error" withMessage:error.description];
    }
    if (hasObjects) {
        [[NSUserDefaults standardUserDefaults] setObject:[NSDate date] forKey:@"LastUpdatedAt"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        [self.tableView reloadData];
    }
    [refreshControl endRefreshing];
}

#pragma mark - Table View Creation

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    id<NSFetchedResultsSectionInfo> sectionInfo = [fetchedResultsController.sections objectAtIndex:section];
    NSUInteger numberOfObjects = [sectionInfo numberOfObjects];
    return numberOfObjects;
}

- (UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"VenueCell";
    VenueTableViewCell *cell = (VenueTableViewCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    VenueObject *venue = [fetchedResultsController objectAtIndexPath:indexPath];
    [cell setVenueObject:venue];
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    NSDate *lastUpdatedAt = [[NSUserDefaults standardUserDefaults] objectForKey:@"LastUpdatedAt"];
    NSString *dateString = [NSDateFormatter localizedStringFromDate:lastUpdatedAt dateStyle:NSDateFormatterShortStyle timeStyle:NSDateFormatterMediumStyle];
    if (dateString == nil) {
        dateString = @"Never";
    }
    return [NSString stringWithFormat:@"Last Loaded: %@", dateString];
}

#pragma mark - Table View Delegates


#pragma mark - NSFetchedResultsControllerDelegate methods

- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller {
    [self refreshTable];
    
}
@end

//
//  XDSettingsTableViewController.m
//  Foursquare Example Brief
//
//  Created by Valentin Hinov on 12/04/2014.
//  Copyright (c) 2014 xDesign365. All rights reserved.
//

#import "XDSettingsTableViewController.h"
#import "SWRevealViewController.h"

@interface XDSettingsTableViewController ()
- (IBAction)showUnratedVenuesChanged:(id)sender;
@property (weak, nonatomic) IBOutlet UISwitch *unratedVenuesSwitch;

@end

@implementation XDSettingsTableViewController

- (id)initWithStyle:(UITableViewStyle)style {
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    self.unratedVenuesSwitch.on = [[NSUserDefaults standardUserDefaults] boolForKey:@"Show Unrated Venues"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)showUnratedVenuesChanged:(id)sender {
    UISwitch *switchView = (UISwitch*)sender;
    BOOL showUnratedVenues = switchView.on;
    [[NSUserDefaults standardUserDefaults] setBool:showUnratedVenues forKey:@"Show Unrated Venues"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

#pragma mark - Table View Delegates

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.revealViewController revealToggleAnimated:YES];
}

@end

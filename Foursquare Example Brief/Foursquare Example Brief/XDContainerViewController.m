//
//  XDViewController.m
//  Foursquare Example Brief
//
//  Created by Valentin Hinov on 07/04/2014.
//  Copyright (c) 2014 xDesign365. All rights reserved.
//

#import "XDContainerViewController.h"
#import <Restkit/RestKit.h>

#import "SWRevealViewController.h"
#import "XDMapViewController.h"
#import "XDVenueListViewController.h"
#import "FoursquareModelObject.h"
#import "XDUtilities.h"

// This view controller will be in charge of retrieving the data for both the map view and the list view
// from the Foursquare API.

#define CLIENT_ID @"UJ2SX3CVD4GRIEOLFPUANIFU51S4R55Y2XVU0K31YCMNP3VF"
#define CLIENT_SECRET @"D4ROG5ZCWWYDDCU3E4A1CKZEN4N3MZFIKVCJR2YQYHWZAJAZ"
#define BASE_URL @"https://api.foursquare.com"

@interface XDContainerViewController ()

@property (strong, nonatomic) FoursquareModelObject *model;
@property (strong, nonatomic) XDMapViewController *mapVC;
@property (strong, nonatomic) XDVenueListViewController *tableVC;
@property (weak, nonatomic) UIViewController *currentChildVC;

@property (weak, nonatomic) IBOutlet UIView *childView;
@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentedControl;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *sidebarButton;

- (IBAction)changeViewController:(id)sender;

@end

@implementation XDContainerViewController

@synthesize currentChildVC;
@synthesize childView;
@synthesize mapVC, tableVC;
@synthesize model;

- (void)addChildToThisContainerViewController:(UIViewController *)childController
{
    [self addChildViewController:childController];
    [childController didMoveToParentViewController:self];
    childController.view.frame = CGRectMake(0.0,
                                            0.0,
                                            self.childView.frame.size.width,
                                            self.childView.frame.size.height);
}

- (void)viewDidLoad {
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    [self initDataModel];
    
    // create view controllers and provide them with a pointer to the model
    mapVC = (XDMapViewController*)[[self storyboard] instantiateViewControllerWithIdentifier:@"XDMapViewController"];
    tableVC = (XDVenueListViewController*)[[self storyboard] instantiateViewControllerWithIdentifier:@"XDTableViewController"];
    [self addChildToThisContainerViewController:mapVC];
    [self addChildToThisContainerViewController:tableVC];
    
    [mapVC setModelObject:model];
    [tableVC setModelObject:model];
    
    currentChildVC = [self.childViewControllers objectAtIndex:self.segmentedControl.selectedSegmentIndex];
    [self.childView addSubview:currentChildVC.view];
    
    [self initRevealLogic];
}

- (void)initDataModel {
    // initialise Foursquare API data
    [self configureRestKit];
    [self loadVenues];
    model = [[FoursquareModelObject alloc] init];
}

- (void)initRevealLogic {    
    // Set the side bar button action. When it's tapped, it'll show up the sidebar.
    _sidebarButton.target = self.revealViewController;
    _sidebarButton.action = @selector(revealToggle:);
    
    // Set the gesture
    [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated {
    [self.mapVC centerMapOnDefaultCoords];
}

#pragma mark - IB Actions
- (IBAction)changeViewController:(UISegmentedControl *)sender {
    UIViewController *oldChildVC = currentChildVC;
    UIViewController *newChildVC = [self.childViewControllers objectAtIndex:sender.selectedSegmentIndex];
    UIViewAnimationOptions options;
    
    if (sender.selectedSegmentIndex == 0) {
        options = UIViewAnimationOptionTransitionFlipFromLeft;
    } else {
        options = UIViewAnimationOptionTransitionFlipFromRight;
    }
    [self transitionFromViewController:oldChildVC
                      toViewController:newChildVC
                              duration:0.5
                               options:options
                            animations:nil
                            completion:nil];
    
    currentChildVC = newChildVC;
}

#pragma mark - RestKit Actions
- (void)configureRestKit {
    // initialize AFNetworking HTTPClient
    NSURL *baseURL = [NSURL URLWithString:BASE_URL];
    AFHTTPClient *client = [[AFHTTPClient alloc] initWithBaseURL:baseURL];
    
    // initialize RestKit
    RKObjectManager *objectManager = [[RKObjectManager alloc] initWithHTTPClient:client];
    
    RKObjectMapping *objectMapping = [GroupObject getObjectMapping];
        
    // register mappings with the provider using a response descriptor
    RKResponseDescriptor *responseDescriptor =
    [RKResponseDescriptor responseDescriptorWithMapping:objectMapping
                                                 method:RKRequestMethodGET
                                            pathPattern:@"/v2/venues/explore"
                                                keyPath:@"response.groups"
                                            statusCodes:[NSIndexSet indexSetWithIndex:200]];
    
    [objectManager addResponseDescriptor:responseDescriptor];
}

- (void)loadVenues {
    NSString *latLon = [NSString stringWithFormat:@"%g,%g", DEFAULT_LATITUDE, DEFAULT_LONGITUDE];
    NSString *currDate = [XDUtilities getCurrentDateWithFormat:@"yyyyMMdd"];
    
    NSDictionary *queryParams = @{@"ll" : latLon,
                                  @"client_id" : CLIENT_ID,
                                  @"client_secret" : CLIENT_SECRET,
                                  @"limit": @"10",
                                  @"sortByDistance": @"1",
                                  @"radius": @"2000", // 2 km
                                  @"v" : currDate};
    
    [[RKObjectManager sharedManager] getObjectsAtPath:@"/v2/venues/explore"
                                           parameters:queryParams
                                              success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
                                                  model.groupObjects = mappingResult.array;
                                                  [mapVC setModelObject:model];
                                                  [tableVC setModelObject:model];
                                              }
                                              failure:^(RKObjectRequestOperation *operation, NSError *error) {
                                                  NSLog(@"What do you mean by 'there is no coffee?': %@", error);
                                              }];
}

@end

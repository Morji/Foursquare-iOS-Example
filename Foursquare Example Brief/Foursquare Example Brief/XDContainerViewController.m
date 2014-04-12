//
//  XDViewController.m
//  Foursquare Example Brief
//
//  Created by Valentin Hinov on 07/04/2014.
//  Copyright (c) 2014 xDesign365. All rights reserved.
//

#import "XDContainerViewController.h"

#import "SWRevealViewController.h"
#import "XDMapViewController.h"
#import "XDVenueListViewController.h"
#import "Explore.h"
#import "XDUtilities.h"

@interface XDContainerViewController ()

@property (strong, nonatomic) XDServer *server;

@property (strong, nonatomic) XDMapViewController *mapVC;
@property (strong, nonatomic) XDVenueListViewController *tableVC;
@property (weak, nonatomic) UIViewController *currentChildVC;

@property (weak, nonatomic) IBOutlet UIView *childView;
@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentedControl;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *sidebarButton;

- (IBAction)changeViewController:(id)sender;
- (IBAction)refreshData:(id)sender;

@end

@implementation XDContainerViewController

@synthesize currentChildVC;
@synthesize childView;
@synthesize mapVC, tableVC;
@synthesize server;

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
    [self initViewControllers];
    [self initRevealLogic];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshData:) name:@"Reload Venues" object:nil];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"Reload Venues" object:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated {
    [self.mapVC centerMapOnDefaultCoords];
}

- (void)initDataModel {
    // initialise Foursquare API data
    server = [XDServer initWithDelegate:self];
    [server configureRestKit];
}

- (void)initViewControllers {
    // create view controllers
    mapVC = (XDMapViewController*)[[self storyboard] instantiateViewControllerWithIdentifier:@"XDMapViewController"];
    tableVC = (XDVenueListViewController*)[[self storyboard] instantiateViewControllerWithIdentifier:@"XDVenueListViewController"];
    [self addChildToThisContainerViewController:mapVC];
    [self addChildToThisContainerViewController:tableVC];
    
    currentChildVC = [self.childViewControllers objectAtIndex:self.segmentedControl.selectedSegmentIndex];
    [self.childView addSubview:currentChildVC.view];
}

- (void)initRevealLogic {    
    // Set the side bar button action. When it's tapped, it'll show up the sidebar.
    _sidebarButton.target = self.revealViewController;
    _sidebarButton.action = @selector(revealToggle:);
    
    // Set the gesture
    [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
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

- (IBAction)refreshData:(id)sender {
    NSDictionary *mapDictionary = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"Default map info"];
    double defaultLatitude = [[mapDictionary objectForKey:@"Latitude"] doubleValue];
    double defaultLongitude = [[mapDictionary objectForKey:@"Longitude"] doubleValue];
    float mileReach = [[mapDictionary objectForKey:@"Mile reach"] floatValue];
    NSArray *queries = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"Foursquare queries"];
    
    CLLocationCoordinate2D userLoc = [mapVC getUserLocation];
    double latitude, longitude;
    if (userLoc.latitude == 0 && userLoc.longitude == 0) {
        latitude = defaultLatitude;
        longitude = defaultLongitude;
    } else {
        latitude = userLoc.latitude;
        longitude = userLoc.longitude;
    }
    
    for (NSString *query in queries) {
        [server loadVenuesAtLatitude:latitude andLongitude:longitude withinMileRadius:mileReach withQueryType:query];
    }
}

#pragma mark - Server Callbacks
- (void) didRetrieveExploreObject: (Explore *) exploreObject {
    [tableVC refreshTable];
    NSArray *recommendedVenues = [exploreObject getRecommendedVenues];
    [mapVC addVenues:recommendedVenues];
}

- (void) callFailedWithError: (NSString *) error {
    [XDUtilities showAlert:@"Server Error" withMessage:error];
}

@end

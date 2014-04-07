//
//  XDViewController.m
//  Foursquare Example Brief
//
//  Created by Valentin Hinov on 07/04/2014.
//  Copyright (c) 2014 xDesign365. All rights reserved.
//

#import "XDVContainerViewController.h"
#import "XDMapViewController.h"
#import "XDTableViewController.h"


// This view controller will be in charge of retrieving the data for both the map view and the list view
// from the Foursquare API. 

@interface XDVContainerViewController ()

@property (strong, nonatomic) XDMapViewController *mapVC;
@property (strong, nonatomic) XDTableViewController *tableVC;
@property (weak, nonatomic) UIViewController *currentChildVC;
@property (weak, nonatomic) IBOutlet UIView *childView;
@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentedControl;
- (IBAction)changeViewController:(id)sender;

@end

@implementation XDVContainerViewController

@synthesize currentChildVC;
@synthesize childView;
@synthesize mapVC, tableVC;

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
    tableVC = (XDTableViewController*)[[self storyboard] instantiateViewControllerWithIdentifier:@"XDTableViewController"];
    [self addChildToThisContainerViewController:mapVC];
    [self addChildToThisContainerViewController:tableVC];
    
    currentChildVC = [self.childViewControllers objectAtIndex:self.segmentedControl.selectedSegmentIndex];
    [self.childView addSubview:currentChildVC.view];
}

- (void)initDataModel {
    // initialise Foursquare API data
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated {
    [self.mapVC centerMapOnDefaultCoords];
}

#pragma mark IB ACTIONS
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
@end

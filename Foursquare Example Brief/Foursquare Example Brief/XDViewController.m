//
//  XDViewController.m
//  Foursquare Example Brief
//
//  Created by Valentin Hinov on 07/04/2014.
//  Copyright (c) 2014 xDesign365. All rights reserved.
//

#import "XDViewController.h"
#import <MapKit/MapKit.h>

#define METERS_PER_MILE 1609.344f
#define DEFAULT_LATITUDE 55.947367
#define DEFAULT_LONGITUDE -3.214507

@interface XDViewController ()
@property (weak, nonatomic) IBOutlet MKMapView *mapView;

@end

@implementation XDViewController

- (void)viewDidLoad {
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated {
    [self centerMapOnDefaultCoords];
}

- (void)centerMapOnDefaultCoords {
    CLLocationCoordinate2D zoomLocation = CLLocationCoordinate2DMake(DEFAULT_LATITUDE, DEFAULT_LONGITUDE);
    // display a mile - good enough region
    float mileReach = 1.0f;
    MKCoordinateRegion viewRegion = MKCoordinateRegionMakeWithDistance(zoomLocation, mileReach*METERS_PER_MILE, mileReach*METERS_PER_MILE);
    [_mapView setRegion:viewRegion animated:YES];
}

@end

//
//  XDMapViewController.m
//  Foursquare Example Brief
//
//  Created by Valentin Hinov on 07/04/2014.
//  Copyright (c) 2014 xDesign365. All rights reserved.
//

#import "XDMapViewController.h"
#import <MapKit/MapKit.h>

#define METERS_PER_MILE 1609.344f
#define DEFAULT_LATITUDE 55.947367
#define DEFAULT_LONGITUDE -3.214507

@interface XDMapViewController ()
@property (weak, nonatomic) IBOutlet MKMapView *mapView;

@end

@implementation XDMapViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)centerMapOnDefaultCoords {
    CLLocationCoordinate2D zoomLocation = CLLocationCoordinate2DMake(DEFAULT_LATITUDE, DEFAULT_LONGITUDE);
    // display a mile - good enough region
    float mileReach = 1.0f;
    MKCoordinateRegion viewRegion = MKCoordinateRegionMakeWithDistance(zoomLocation, mileReach*METERS_PER_MILE, mileReach*METERS_PER_MILE);
    [_mapView setRegion:viewRegion animated:YES];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

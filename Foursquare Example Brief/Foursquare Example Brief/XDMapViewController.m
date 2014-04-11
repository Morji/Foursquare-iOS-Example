//
//  XDMapViewController.m
//  Foursquare Example Brief
//
//  Created by Valentin Hinov on 07/04/2014.
//  Copyright (c) 2014 xDesign365. All rights reserved.
//

#import "XDMapViewController.h"
#import <MapKit/MapKit.h>
#import "XDUtilities.h"
#import "VenueLocation.h"
#import "Venue.h"

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
    NSDictionary *mapDictionary = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"Default map info"];
    NSNumber *latitude = [mapDictionary objectForKey:@"Latitude"];
    NSNumber *longitude = [mapDictionary objectForKey:@"Longitude"];
    NSNumber *mileReach = [mapDictionary objectForKey:@"Mile reach"];
    
    CLLocationCoordinate2D zoomLocation = CLLocationCoordinate2DMake([latitude doubleValue], [longitude doubleValue]);
    // display a mile - good enough region
    int meterReach = [XDUtilities milesToMetersFromNumber:mileReach];
    MKCoordinateRegion viewRegion = MKCoordinateRegionMakeWithDistance(zoomLocation, meterReach, meterReach);
    [_mapView setRegion:viewRegion animated:YES];
    
}

- (void)addVenues:(NSArray *)venuesArray {
    for (Venue *venue in venuesArray) {
        VenueLocation *location = venue.location;
        [_mapView addAnnotation:location];
    }
}
     
- (CLLocationCoordinate2D) getUserLocation {
    MKUserLocation *userLoc = [_mapView userLocation];
    return [userLoc.location coordinate];
}

- (MKPinAnnotationColor) pinColorForQueryType:(NSString*) queryType {
    NSArray *viableQueries = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"Foursquare queries"];
    
    // only support two queries here
    if ([queryType isEqualToString:[viableQueries objectAtIndex:0]]) {
        return MKPinAnnotationColorGreen;
    } else if ([queryType isEqualToString:[viableQueries objectAtIndex:1]]) {
        return MKPinAnnotationColorPurple;
    } else {
       return MKPinAnnotationColorRed;
    }
}

#pragma mark - MKMapView delegate methods
- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation {
    static NSString *identifier = @"VenueLocation";
    if ([annotation isKindOfClass:[VenueLocation class]]) {
        VenueLocation *venueLocation = (VenueLocation*)annotation;
        MKPinAnnotationView *pinAnnotationView = (MKPinAnnotationView *) [mapView dequeueReusableAnnotationViewWithIdentifier:identifier];
        if (pinAnnotationView == nil) {
            pinAnnotationView = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:identifier];
            pinAnnotationView.enabled = YES;
            pinAnnotationView.animatesDrop = YES;
            pinAnnotationView.canShowCallout = YES;
        } else {
            pinAnnotationView.annotation = annotation;
        }
        NSString *venueQueryType = [venueLocation.venue getQueryType];
        pinAnnotationView.pinColor = [self pinColorForQueryType:venueQueryType];
        
        return pinAnnotationView;
    }
    
    return nil;
}



@end

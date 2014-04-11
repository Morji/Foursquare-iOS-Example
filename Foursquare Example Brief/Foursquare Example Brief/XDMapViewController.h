//
//  XDMapViewController.h
//  Foursquare Example Brief
//
//  Created by Valentin Hinov on 07/04/2014.
//  Copyright (c) 2014 xDesign365. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@interface XDMapViewController : UIViewController <MKMapViewDelegate>

- (void)centerMapOnDefaultCoords;

- (void)addVenues:(NSArray *)venuesArray;

- (CLLocationCoordinate2D) getUserLocation;

@end

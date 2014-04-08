//
//  XDMapViewController.h
//  Foursquare Example Brief
//
//  Created by Valentin Hinov on 07/04/2014.
//  Copyright (c) 2014 xDesign365. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FoursquareModelObject.h"

#define DEFAULT_LATITUDE 55.947367
#define DEFAULT_LONGITUDE -3.214507

@interface XDMapViewController : UIViewController

- (void)centerMapOnDefaultCoords;
- (void)setModelObject:(FoursquareModelObject *)modelObject;

@end

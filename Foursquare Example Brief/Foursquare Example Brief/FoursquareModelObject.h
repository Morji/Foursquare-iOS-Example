//
//  FoursquareModelObject.h
//  Foursquare Example Brief
//
//  Created by Valentin Hinov on 07/04/2014.
//  Copyright (c) 2014 xDesign365. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GroupObject.h"

@interface FoursquareModelObject : NSObject

@property (assign, nonatomic) NSArray *groupObjects;

// these are the venue objects from the "recommended" group
@property (strong, nonatomic) NSArray *venueObjects;

@end

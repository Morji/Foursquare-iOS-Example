//
//  VenueObject.h
//  Foursquare Example Brief
//
//  Created by Valentin Hinov on 07/04/2014.
//  Copyright (c) 2014 xDesign365. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "VenueLocation.h"
#import "VenueCategory.h"

@class RKObjectMapping;

@interface VenueObject : NSObject

@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) VenueLocation *location;
@property (strong, nonatomic) NSArray *categories;
@property (strong, nonatomic) NSNumber *rating;

- (VenueCategory*)getMainCategory;

+ (RKObjectMapping*)getObjectMapping;

@end

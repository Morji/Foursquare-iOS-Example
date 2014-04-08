//
//  Venue.h
//  Foursquare Example Brief
//
//  Created by Valentin Hinov on 08/04/2014.
//  Copyright (c) 2014 xDesign365. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class VenueCategory, VenueLocation, Group;
@class RKEntityMapping;
@class RKManagedObjectStore;

@interface Venue : NSManagedObject

@property (nonatomic, copy) NSNumber * rating;
@property (nonatomic, copy) NSString * name;
@property (nonatomic, copy) NSString * venueId;
@property (nonatomic, strong) NSSet *categories;
@property (nonatomic, strong) VenueLocation *location;

@property (nonatomic, strong) Group *group;

+ (RKEntityMapping*)getEntityMappingForManagedObjectStore:(RKManagedObjectStore*) store;
- (VenueCategory*)getMainCategory;

@end
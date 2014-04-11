//
//  Explore.h
//  Foursquare Example Brief
//
//  Created by Valentin Hinov on 08/04/2014.
//  Copyright (c) 2014 xDesign365. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

// Explore Entity - this is the base level entity returned from the v2/venues/explore call

@class Group;
@class RKEntityMapping;
@class RKManagedObjectStore;

@interface Explore : NSManagedObject

// Query type - one of food, drinks, coffee, shops, arts, outdoors, sights, trending, specials or nextVenues
// This is the passed "section" to the api/venues/explore call
@property (nonatomic, strong) NSString *queryType;

// All returned groups of venues - typically has only one
@property (nonatomic, strong) NSSet *groups;

+ (RKEntityMapping*)getEntityMappingForManagedObjectStore:(RKManagedObjectStore*) store;
- (NSArray*) getRecommendedVenues;

@end


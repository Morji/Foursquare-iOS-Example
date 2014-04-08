//
//  VenueLocation.h
//  Foursquare Example Brief
//
//  Created by Valentin Hinov on 08/04/2014.
//  Copyright (c) 2014 xDesign365. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Venue;
@class RKEntityMapping;
@class RKManagedObjectStore;

@interface VenueLocation : NSManagedObject

@property (nonatomic, copy) NSString * address;
@property (nonatomic, copy) NSNumber * distance;
@property (nonatomic, copy) NSNumber * lat;
@property (nonatomic, copy) NSNumber * lng;
@property (nonatomic, strong) Venue *venue;

+ (RKEntityMapping*)getEntityMappingForManagedObjectStore:(RKManagedObjectStore*) store;

@end

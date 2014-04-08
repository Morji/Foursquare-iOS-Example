//
//  VenueCategory.h
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

@interface VenueCategory : NSManagedObject

@property (nonatomic, copy) NSString * name;
@property (nonatomic, copy) NSString * categoryId;
@property (nonatomic, copy) NSString * shortName;
@property (nonatomic, copy) NSNumber * primary;

@property (nonatomic, strong) Venue *venue;

+ (RKEntityMapping*)getEntityMappingForManagedObjectStore:(RKManagedObjectStore*) store;

@end

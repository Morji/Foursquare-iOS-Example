//
//  Group.h
//  Foursquare Example Brief
//
//  Created by Valentin Hinov on 08/04/2014.
//  Copyright (c) 2014 xDesign365. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Venue, Explore;
@class RKEntityMapping;
@class RKManagedObjectStore;

@interface Group : NSManagedObject

@property (nonatomic, copy) NSString * type;
@property (nonatomic, copy) NSString * name;
@property (nonatomic, strong) NSSet *venues;

@property (nonatomic, strong) Explore *explore;

+ (RKEntityMapping*)getEntityMappingForManagedObjectStore:(RKManagedObjectStore*) store;

@end
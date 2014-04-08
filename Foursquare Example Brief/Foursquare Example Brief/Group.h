//
//  Group.h
//  Foursquare Example Brief
//
//  Created by Valentin Hinov on 08/04/2014.
//  Copyright (c) 2014 xDesign365. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Venue;
@class RKObjectMapping;
@class RKEntityMapping;
@class RKManagedObjectStore;

@interface Group : NSManagedObject

@property (nonatomic, copy) NSString * type;
@property (nonatomic, copy) NSString * name;
@property (nonatomic, strong) NSSet *venues;

+ (RKEntityMapping*)getEntityMappingForManagedObjectStore:(RKManagedObjectStore*) store;


@end

/*@interface Group (CoreDataGeneratedAccessors)

- (void)addVenuesObject:(Venue *)value;
- (void)removeVenuesObject:(Venue *)value;
- (void)addVenues:(NSSet *)values;
- (void)removeVenues:(NSSet *)values;

@end*/

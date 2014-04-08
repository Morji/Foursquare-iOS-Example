//
//  Venue.h
//  Foursquare Example Brief
//
//  Created by Valentin Hinov on 08/04/2014.
//  Copyright (c) 2014 xDesign365. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class VenueCategory, VenueLocation;
@class RKEntityMapping;
@class RKManagedObjectStore;

@interface Venue : NSManagedObject

@property (nonatomic, copy) NSNumber * rating;
@property (nonatomic, copy) NSString * name;
@property (nonatomic, copy) NSString * venueId;
@property (nonatomic, strong) NSSet *categories;
@property (nonatomic, strong) VenueLocation *location;

+ (RKEntityMapping*)getEntityMappingForManagedObjectStore:(RKManagedObjectStore*) store;
- (VenueCategory*)getMainCategory;

@end

/*@interface Venue (CoreDataGeneratedAccessors)

- (void)addCategoriesObject:(VenueCategory *)value;
- (void)removeCategoriesObject:(VenueCategory *)value;
- (void)addCategories:(NSSet *)values;
- (void)removeCategories:(NSSet *)values;

@end*/

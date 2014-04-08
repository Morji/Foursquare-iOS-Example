//
//  Venue.m
//  Foursquare Example Brief
//
//  Created by Valentin Hinov on 08/04/2014.
//  Copyright (c) 2014 xDesign365. All rights reserved.
//

#import "Venue.h"
#import "VenueCategory.h"
#import "VenueLocation.h"
#import <RestKit/CoreData.h>


@implementation Venue

@dynamic venueId;
@dynamic rating;
@dynamic name;
@dynamic categories;
@dynamic location;

+ (RKEntityMapping*)getEntityMappingForManagedObjectStore:(RKManagedObjectStore*) store {
    RKEntityMapping *venueMapping = [RKEntityMapping mappingForEntityForName:@"Venue" inManagedObjectStore:store];
    venueMapping.identificationAttributes = @[ @"venueId" ];
    [venueMapping addAttributeMappingsFromDictionary:@{
                                                      @"id": @"venueId"
                                                      }];
    [venueMapping addAttributeMappingsFromArray:@[@"name", @"rating"]];
    
    // define location object mapping
    RKEntityMapping *locationMapping = [VenueLocation getEntityMappingForManagedObjectStore:store];
    
    // define category object mapping
    RKEntityMapping *categoryMapping = [VenueCategory getEntityMappingForManagedObjectStore:store];

    // define relationship mappings
    [venueMapping addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:@"location" toKeyPath:@"location" withMapping:locationMapping]];
    
    [venueMapping addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:@"categories" toKeyPath:@"categories" withMapping:categoryMapping]];
    
    return venueMapping;
}

- (VenueCategory*)getMainCategory {
    if ([self.categories count] < 1) {
        return nil;
    }
    NSSet *results = [self.categories objectsPassingTest:^BOOL(id obj, BOOL *stop) {
        VenueCategory *category = obj;
        if ([category.primary boolValue] == YES) {
            *stop = YES;
            return YES;
        }
        return NO;
    }];
    assert([results count] == 1);
    return [results anyObject]; // should just be one object
}

@end

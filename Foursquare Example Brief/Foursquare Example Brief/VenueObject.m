//
//  VenueObject.m
//  Foursquare Example Brief
//
//  Created by Valentin Hinov on 07/04/2014.
//  Copyright (c) 2014 xDesign365. All rights reserved.
//

#import "VenueObject.h"
#import <RestKit/RestKit.h>

@implementation VenueObject

+ (RKObjectMapping*)getObjectMapping {
    // setup object mappings    
    RKObjectMapping *venueMapping = [RKObjectMapping mappingForClass:[VenueObject class]];
    [venueMapping addAttributeMappingsFromArray:@[@"name", @"rating"]];
    
    // define location object mapping
    RKObjectMapping *locationMapping = [RKObjectMapping mappingForClass:[VenueLocation class]];
    [locationMapping addAttributeMappingsFromArray:@[@"address", @"distance"]];
    
    // define category object mapping
    RKObjectMapping *categoryMapping = [RKObjectMapping mappingForClass:[VenueCategory class]];
    [categoryMapping addAttributeMappingsFromArray:@[@"name", @"shortName", @"primary"]];
    
    // define relationship mappings
    [venueMapping addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:@"location" toKeyPath:@"location" withMapping:locationMapping]];
    
    [venueMapping addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:@"categories" toKeyPath:@"categories" withMapping:categoryMapping]];
    
    return venueMapping;
}

- (VenueCategory*)getMainCategory {
    if ([self.categories count] < 1) {
        return nil;
    }
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"primary==%@", [NSNumber numberWithBool: YES]];
    NSArray *results = [self.categories filteredArrayUsingPredicate:predicate];
    assert([results count] == 1);
    return [results objectAtIndex:0];
}

@end

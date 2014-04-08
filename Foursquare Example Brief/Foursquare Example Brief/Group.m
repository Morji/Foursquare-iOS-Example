//
//  Group.m
//  Foursquare Example Brief
//
//  Created by Valentin Hinov on 08/04/2014.
//  Copyright (c) 2014 xDesign365. All rights reserved.
//

#import "Group.h"
#import "Venue.h"
#import <RestKit/CoreData.h>

@implementation Group

@dynamic type;
@dynamic name;
@dynamic venues;

+ (RKEntityMapping*)getEntityMappingForManagedObjectStore:(RKManagedObjectStore*) store {
    RKEntityMapping *groupMapping = [RKEntityMapping mappingForEntityForName:@"Group" inManagedObjectStore:store];
    groupMapping.identificationAttributes = @[ @"type" ];
    [groupMapping addAttributeMappingsFromArray:@[@"type", @"name"]];

    RKEntityMapping *venueMapping = [Venue getEntityMappingForManagedObjectStore:store];
    
    [groupMapping addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:@"items.venue" toKeyPath:@"venues" withMapping:venueMapping]];
    
    return groupMapping;
}

@end

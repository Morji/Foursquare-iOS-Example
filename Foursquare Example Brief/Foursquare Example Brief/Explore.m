//
//  Explore.m
//  Foursquare Example Brief
//
//  Created by Valentin Hinov on 08/04/2014.
//  Copyright (c) 2014 xDesign365. All rights reserved.
//

#import "Explore.h"
#import "Group.h"
#import <RestKit/CoreData.h>

@implementation Explore

@dynamic query;
@dynamic groups;

+ (RKEntityMapping*)getEntityMappingForManagedObjectStore:(RKManagedObjectStore*) store {
    RKEntityMapping *exploreMapping = [RKEntityMapping mappingForEntityForName:@"Explore" inManagedObjectStore:store];
    exploreMapping.identificationAttributes = @[ @"query" ];
    [exploreMapping addAttributeMappingsFromArray:@[@"query"]];
    
    RKEntityMapping *groupMapping = [Group getEntityMappingForManagedObjectStore:store];
    
    [exploreMapping addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:@"groups" toKeyPath:@"groups" withMapping:groupMapping]];
    
    return exploreMapping;
}

@end

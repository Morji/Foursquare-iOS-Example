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

@dynamic queryType;
@dynamic groups;

+ (RKEntityMapping*)getEntityMappingForManagedObjectStore:(RKManagedObjectStore*) store {
    RKEntityMapping *exploreMapping = [RKEntityMapping mappingForEntityForName:@"Explore" inManagedObjectStore:store];
    exploreMapping.identificationAttributes = @[ @"queryType" ];
    [exploreMapping addAttributeMappingsFromDictionary:@{
                                                       @"query": @"queryType"
                                                       }];
    
    RKEntityMapping *groupMapping = [Group getEntityMappingForManagedObjectStore:store];
    
    [exploreMapping addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:@"groups" toKeyPath:@"groups" withMapping:groupMapping]];
    
    return exploreMapping;
}

- (NSArray*) getRecommendedVenues {
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"type==%@", @"Recommended Places"];
    NSSet *results = [self.groups filteredSetUsingPredicate:predicate];
    assert([results count] == 1);
    
    Group *recommendedGroup = [results anyObject];
    return [recommendedGroup.venues allObjects];
}

@end

//
//  GroupObject.m
//  Foursquare Example Brief
//
//  Created by Valentin Hinov on 07/04/2014.
//  Copyright (c) 2014 xDesign365. All rights reserved.
//

#import "GroupObject.h"
#import <RestKit/RestKit.h>
#import "VenueObject.h"

@implementation GroupObject

+ (RKObjectMapping*)getObjectMapping {
    
    RKObjectMapping *groupMapping = [RKObjectMapping mappingForClass:[GroupObject class]];
    [groupMapping addAttributeMappingsFromArray:@[@"type", @"name"]];
    
    // setup object mappings
    RKObjectMapping *venueMapping = [VenueObject getObjectMapping];
    
    // define relationship mappings
    [groupMapping addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:@"items.venue" toKeyPath:@"venues" withMapping:venueMapping]];

    
    return groupMapping;

}

@end

//
//  VenueCategory.m
//  Foursquare Example Brief
//
//  Created by Valentin Hinov on 08/04/2014.
//  Copyright (c) 2014 xDesign365. All rights reserved.
//

#import "VenueCategory.h"
#import <RestKit/CoreData.h>
#import "Venue.h"

@implementation VenueCategory

@dynamic name;
@dynamic shortName;
@dynamic primary;
@dynamic venue;
@dynamic categoryId;

+ (RKEntityMapping*)getEntityMappingForManagedObjectStore:(RKManagedObjectStore*) store {
    // define category object mapping
    RKEntityMapping *categoryMapping = [RKEntityMapping mappingForEntityForName:@"VenueCategory" inManagedObjectStore:store];
    categoryMapping.identificationAttributes = @[ @"categoryId" ];
    [categoryMapping addAttributeMappingsFromDictionary:@{
                                                          @"id": @"categoryId"
                                                          }];
    [categoryMapping addAttributeMappingsFromArray:@[@"name", @"shortName", @"primary"]];
    
    return categoryMapping;
}

@end

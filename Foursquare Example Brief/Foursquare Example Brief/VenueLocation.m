//
//  VenueLocation.m
//  Foursquare Example Brief
//
//  Created by Valentin Hinov on 08/04/2014.
//  Copyright (c) 2014 xDesign365. All rights reserved.
//

#import "VenueLocation.h"
#import <RestKit/CoreData.h>
#import "Venue.h"

@implementation VenueLocation

@dynamic address;
@dynamic distance;
@dynamic lat;
@dynamic lng;
@dynamic venue;

+ (RKEntityMapping*)getEntityMappingForManagedObjectStore:(RKManagedObjectStore*) store {
    RKEntityMapping *locationMapping = [RKEntityMapping mappingForEntityForName:@"VenueLocation" inManagedObjectStore:store];
    locationMapping.identificationAttributes = @[ @"lat", @"lng" ];
    [locationMapping addAttributeMappingsFromArray:@[@"address", @"distance", @"lat", @"lng"]];
    
    return locationMapping;
}

@end

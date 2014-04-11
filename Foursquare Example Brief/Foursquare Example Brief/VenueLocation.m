//
//  VenueLocation.m
//  Foursquare Example Brief
//
//  Created by Valentin Hinov on 08/04/2014.
//  Copyright (c) 2014 xDesign365. All rights reserved.
//

#import "VenueLocation.h"
#import <RestKit/CoreData.h>
#import <AddressBook/AddressBook.h>
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

#pragma mark - MK Annotation Methods

- (NSString *)title {
    return [self.venue name];
}

- (NSString *)subtitle {
    return [self address];
}

- (CLLocationCoordinate2D)coordinate {
    return CLLocationCoordinate2DMake([self.lat doubleValue], [self.lng doubleValue]);
}

- (MKMapItem*)mapItem {
    NSDictionary *addressDict = @{(NSString*)kABPersonAddressStreetKey : self.address};
    MKPlacemark *placemark = [[MKPlacemark alloc]
                              initWithCoordinate:self.coordinate
                              addressDictionary:addressDict];
    
    MKMapItem *mapItem = [[MKMapItem alloc] initWithPlacemark:placemark];
    mapItem.name = self.title;
    
    return mapItem;
}

@end

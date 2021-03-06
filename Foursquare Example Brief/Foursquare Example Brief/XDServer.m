//
//  XDServer.m
//  Foursquare Example Brief
//
//  Created by Valentin Hinov on 08/04/2014.
//  Copyright (c) 2014 xDesign365. All rights reserved.
//

#import "XDServer.h"
#import <Restkit/RestKit.h>

#import "Explore.h"
#import "XDUtilities.h"

#define CLIENT_ID @"UJ2SX3CVD4GRIEOLFPUANIFU51S4R55Y2XVU0K31YCMNP3VF"
#define CLIENT_SECRET @"D4ROG5ZCWWYDDCU3E4A1CKZEN4N3MZFIKVCJR2YQYHWZAJAZ"
#define BASE_URL @"https://api.foursquare.com"

@implementation XDServer

@synthesize delegate;

+ (id)initWithDelegate:(id)delegateObj {
    XDServer *server = [[XDServer alloc] init];
    server.delegate = delegateObj;
    
    return server;
}

- (void) dealloc {
    [AFNetworkActivityIndicatorManager sharedManager].enabled = NO;
}

- (void)configureRestKit {
    // initialize AFNetworking HTTPClient
    NSURL *baseURL = [NSURL URLWithString:BASE_URL];
    AFHTTPClient *client = [[AFHTTPClient alloc] initWithBaseURL:baseURL];
    
    // initialize RestKit
    RKObjectManager *objectManager = [[RKObjectManager alloc] initWithHTTPClient:client];
    
    // Initialize managed object store
    NSManagedObjectModel *managedObjectModel = [NSManagedObjectModel mergedModelFromBundles:nil];
    RKManagedObjectStore *managedObjectStore = [[RKManagedObjectStore alloc] initWithManagedObjectModel:managedObjectModel];
    objectManager.managedObjectStore = managedObjectStore;
    
    RKMapping *mapping = [Explore getEntityMappingForManagedObjectStore:managedObjectStore];
    
    // register mappings with the provider using a response descriptor
    RKResponseDescriptor *responseDescriptor =
    [RKResponseDescriptor responseDescriptorWithMapping:mapping
                                                 method:RKRequestMethodGET
                                            pathPattern:@"/v2/venues/explore"
                                                keyPath:@"response"
                                            statusCodes:[NSIndexSet indexSetWithIndex:200]];
    
    [objectManager addResponseDescriptor:responseDescriptor];
    
    
    /**
     Complete Core Data stack initialization
     */
    [managedObjectStore createPersistentStoreCoordinator];
    NSString *storePath = [RKApplicationDataDirectory() stringByAppendingPathComponent:@"XDDatabase.sqlite"];
    NSString *seedPath = [[NSBundle mainBundle] pathForResource:@"XDSeedDatabase" ofType:@"sqlite"];
    NSError *error;
    NSPersistentStore *persistentStore = [managedObjectStore addSQLitePersistentStoreAtPath:storePath fromSeedDatabaseAtPath:seedPath withConfiguration:nil options:nil error:&error];
    NSAssert(persistentStore, @"Failed to add persistent store with error: %@", error);
    
    // Create the managed object contexts
    [managedObjectStore createManagedObjectContexts];
    
    // Configure a managed object cache to ensure we do not create duplicate objects
    managedObjectStore.managedObjectCache = [[RKInMemoryManagedObjectCache alloc] initWithManagedObjectContext:managedObjectStore.persistentStoreManagedObjectContext];
    
    [AFNetworkActivityIndicatorManager sharedManager].enabled = YES;
}

- (void)loadVenuesAtLatitude:(double)Lat andLongitude:(double)Lon withinMileRadius:(float)miles withQueryType:(NSString *) queryType {
    [[AFNetworkActivityIndicatorManager sharedManager] incrementActivityCount];
    
    NSString *latLon = [NSString stringWithFormat:@"%g,%g", Lat, Lon];
    NSString *currDate = [XDUtilities getCurrentDateWithFormat:@"yyyyMMdd"];
    int meters = [XDUtilities milesToMetersFromFloat:miles];
    NSString *metersStr = [NSString stringWithFormat:@"%d", meters];
    NSDictionary *queryParams = @{@"ll" : latLon,
                                  @"client_id" : CLIENT_ID,
                                  @"client_secret" : CLIENT_SECRET,
                                  @"limit": @"10",
                                  @"sortByDistance": @"1",
                                  @"radius": metersStr, 
                                  @"section": queryType,
                                  @"v" : currDate};
    
    RKObjectManager *objectManager = [RKObjectManager sharedManager];

    [objectManager getObjectsAtPath:@"/v2/venues/explore"
                                           parameters:queryParams
                                              success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
                                                  Explore *exploreObject = mappingResult.firstObject;
                                                  // callback
                                                  [delegate didRetrieveExploreObject:exploreObject forQueryType:queryType];
                                                  [[AFNetworkActivityIndicatorManager sharedManager] decrementActivityCount];

                                              }
                                              failure:^(RKObjectRequestOperation *operation, NSError *error) {
                                                  NSLog(@"Call failed with error: %@", error);
                                                  [delegate callFailedWithError:[error description] forQueryType:queryType];
                                                  [[AFNetworkActivityIndicatorManager sharedManager] decrementActivityCount];
                                              }];
}


@end

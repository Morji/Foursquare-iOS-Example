//
//  XDServer.h
//  Foursquare Example Brief
//
//  Created by Valentin Hinov on 08/04/2014.
//  Copyright (c) 2014 xDesign365. All rights reserved.
//

#import <Foundation/Foundation.h>

// Performs all calls to the Venues API

@class Explore;

@protocol XDServerDelegate <NSObject>
- (void) didRetrieveExploreObject: (Explore *) exploreObject;
- (void) callFailedWithError: (NSString *) error;
@end

@interface XDServer : NSObject {
    id <XDServerDelegate> delegate;
}

@property (strong, nonatomic) id delegate;

+ (id)initWithDelegate:(id)delegate;

- (void)configureRestKit;
- (void)loadVenuesAtLatitude:(double)Lat andLongitude:(double)Lon withinMileRadius:(float) miles withQueryType:(NSString *) queryType;

@end

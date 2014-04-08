//
//  XDServer.h
//  Foursquare Example Brief
//
//  Created by Valentin Hinov on 08/04/2014.
//  Copyright (c) 2014 xDesign365. All rights reserved.
//

#import <Foundation/Foundation.h>

// Performs all calls to the Venues API

@class FoursquareModelObject;

@protocol XDServerDelegate <NSObject>
- (void) didRetrieveModelObject: (FoursquareModelObject *) modelObject;
- (void) callFailedWithError: (NSString *) error;
@end

@interface XDServer : NSObject {
    id <XDServerDelegate> delegate;
}

@property (strong, nonatomic) id delegate;

+ (id)initWithDelegate:(id)delegate;

- (void)configureRestKit;
- (void)loadVenuesAtLatitude:(double)Lat andLongitude:(double)Lon;

@end

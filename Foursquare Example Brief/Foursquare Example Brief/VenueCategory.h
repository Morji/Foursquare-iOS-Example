//
//  VenueCategory.h
//  Foursquare Example Brief
//
//  Created by Valentin Hinov on 07/04/2014.
//  Copyright (c) 2014 xDesign365. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface VenueCategory : NSObject

@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *shortName;
@property (assign, nonatomic) BOOL primary;

@end

//
//  XDUtilities.h
//  Foursquare Example Brief
//
//  Created by Valentin Hinov on 07/04/2014.
//  Copyright (c) 2014 xDesign365. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XDUtilities : NSObject

+ (float) metersToMilesFromFloat: (float) meters;
+ (float) metersToMilesFromNumber: (NSNumber *) metersNumber;

+ (NSString*) getCurrentDateWithFormat: (NSString *) format;
@end

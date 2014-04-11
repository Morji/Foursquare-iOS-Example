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

+ (int) milesToMetersFromFloat: (float) miles;
+ (float) milesToMetersFromNumber: (NSNumber *) milesNumber;

+ (NSString*) getCurrentDateWithFormat: (NSString *) format;

+ (NSString*) getTimeDifferenceBetweenDate: (NSDate*) first andDate:(NSDate*) second;

// Displays a UIAlertView with the given title and message and an OK button
+(void)showAlert:(NSString *)alertTitle withMessage:(NSString *)alertMessage;

@end

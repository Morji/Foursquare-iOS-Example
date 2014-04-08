//
//  XDUtilities.m
//  Foursquare Example Brief
//
//  Created by Valentin Hinov on 07/04/2014.
//  Copyright (c) 2014 xDesign365. All rights reserved.
//

#import "XDUtilities.h"

@implementation XDUtilities

+ (float) metersToMilesFromNumber: (NSNumber *) metersNumber {
    return [self metersToMilesFromFloat:[metersNumber floatValue]];
}

+ (float) metersToMilesFromFloat: (float) meters {
    return meters * 0.00062137f;
}

+ (NSString*) getCurrentDateWithFormat: (NSString *) format {
    NSDateFormatter *formatter;
    NSString        *dateString;
    
    formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:format];
    
    dateString = [formatter stringFromDate:[NSDate date]];
    return dateString;
}

@end

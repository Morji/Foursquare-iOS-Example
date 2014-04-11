//
//  XDUtilities.m
//  Foursquare Example Brief
//
//  Created by Valentin Hinov on 07/04/2014.
//  Copyright (c) 2014 xDesign365. All rights reserved.
//

#import "XDUtilities.h"

#define METERS_PER_MILE 1609.344f
#define MILES_PER_METER 0.00062137f

@implementation XDUtilities

+ (float) metersToMilesFromNumber: (NSNumber *) metersNumber {
    return [self metersToMilesFromFloat:[metersNumber floatValue]];
}

+ (float) metersToMilesFromFloat: (float) meters {
    return meters * MILES_PER_METER;
}

+ (float) milesToMetersFromNumber: (NSNumber *) milesNumber {
    return [self milesToMetersFromFloat:[milesNumber floatValue]];
}

+ (int) milesToMetersFromFloat: (float) miles {
    return miles * METERS_PER_MILE;
}

+ (NSString*) getCurrentDateWithFormat: (NSString *) format {
    NSDateFormatter *formatter;
    NSString        *dateString;
    
    formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:format];
    
    dateString = [formatter stringFromDate:[NSDate date]];
    return dateString;
}

+ (void)showAlert:(NSString *)alertTitle withMessage:(NSString *)alertMessage{
    UIAlertView *alert = [[UIAlertView alloc]
                          initWithTitle:alertTitle
                          message:alertMessage
                          delegate:nil cancelButtonTitle:@"OK"
                          otherButtonTitles:nil];
    [alert show];
    alert = nil;
}

+ (NSString*) getTimeDifferenceBetweenDate: (NSDate*) first andDate:(NSDate*) second {
    unsigned int unitFlags = NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit;
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *conversionInfo = [calendar components:unitFlags fromDate:first  toDate:second  options:0];
    
    NSInteger hours = [conversionInfo hour];
    NSInteger minutes = [conversionInfo minute];
    NSInteger seconds = [conversionInfo second];
    
    NSString *hourStr = @"";
    NSString *minutesStr = @"";
    NSString *secondsStr = @"";
    NSString *temp;
    
    if (hours > 0) {
        temp = hours > 1 ? @"hours" : @"hour";
        hourStr = [NSString stringWithFormat:@"%d %@", hours, temp];
    }
    if (minutesStr > 0) {
        temp = minutes > 1 ? @"minutes" : @"minute";
        minutesStr = [NSString stringWithFormat:@"%d %@", minutes, temp];
    }
    if (secondsStr > 0) {
        temp = seconds > 1 ? @"seconds" : @"second";
        secondsStr = [NSString stringWithFormat:@"%d %@", seconds, temp];
    }
    
    NSString *result = [NSString stringWithFormat:@"%@ %@ %@", hourStr, minutesStr, secondsStr];
    return result;
}

@end

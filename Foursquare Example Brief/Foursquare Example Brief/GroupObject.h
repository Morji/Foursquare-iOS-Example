//
//  GroupObject.h
//  Foursquare Example Brief
//
//  Created by Valentin Hinov on 07/04/2014.
//  Copyright (c) 2014 xDesign365. All rights reserved.
//

#import <Foundation/Foundation.h>

@class RKObjectMapping;

@interface GroupObject : NSObject

@property (strong, nonatomic) NSString *type;
@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSArray *venues;

+ (RKObjectMapping*)getObjectMapping;

@end

//
//  ABFRestaurantObject.m
//  ABFRealmSearchControllerExample
//
//  Created by Adam Fish on 5/29/15.
//  Copyright (c) 2015 Adam Fish. All rights reserved.
//

#import "ABFRestaurantObject.h"

@implementation ABFRestaurantObject

// Specify default values for properties

+ (NSDictionary *)defaultPropertyValues
{
    return @{@"businessId": @"",
             @"name": @"",
             @"address": @"",
             @"city": @"",
             @"state": @"",
             @"postalCode": @"",
             @"latitude": @(kCLLocationCoordinate2DInvalid.latitude),
             @"longitude": @(kCLLocationCoordinate2DInvalid.longitude),
             @"phoneNumber": @"",
             };
             
}

+ (NSString *)primaryKey
{
    return @"businessId";
}

@end

//
//  ABFViolationObject.m
//  ABFRealmSearchControllerExample
//
//  Created by Adam Fish on 5/29/15.
//  Copyright (c) 2015 Adam Fish. All rights reserved.
//

#import "ABFViolationObject.h"

@implementation ABFViolationObject

// Specify default values for properties

+ (NSDictionary *)defaultPropertyValues
{
    return @{@"date": [NSDate distantPast],
             @"violationDescription": @"",
             };
}

@end

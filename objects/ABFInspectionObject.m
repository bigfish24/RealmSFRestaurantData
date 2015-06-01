//
//  ABFInspectionObject.m
//  ABFRealmSearchControllerExample
//
//  Created by Adam Fish on 5/29/15.
//  Copyright (c) 2015 Adam Fish. All rights reserved.
//

#import "ABFInspectionObject.h"

@implementation ABFInspectionObject

// Specify default values for properties

+ (NSDictionary *)defaultPropertyValues
{
    return @{@"score": @(-1),
             @"date": [NSDate distantPast],
             @"type": @(-1),
             };
}

@end

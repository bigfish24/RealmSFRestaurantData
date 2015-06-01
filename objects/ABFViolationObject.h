//
//  ABFViolationObject.h
//  ABFRealmSearchControllerExample
//
//  Created by Adam Fish on 5/29/15.
//  Copyright (c) 2015 Adam Fish. All rights reserved.
//

#import <Realm/Realm.h>

@class ABFRestaurantObject;

@interface ABFViolationObject : RLMObject

/**
 *  Business for which this violation applies
 */
@property ABFRestaurantObject *restaurant;

/**
 *  Date of violation (YYYYMMDD original format). This should correspond with the related inspection
 */
@property NSDate *date;

/**
 *  One line description of the violation
 */
@property NSString *violationDescription;

@end

// This protocol enables typed collections. i.e.:
// RLMArray<ABFViolationObject>
RLM_ARRAY_TYPE(ABFViolationObject)

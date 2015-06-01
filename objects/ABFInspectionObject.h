//
//  ABFInspectionObject.h
//  ABFRealmSearchControllerExample
//
//  Created by Adam Fish on 5/29/15.
//  Copyright (c) 2015 Adam Fish. All rights reserved.
//

#import <Realm/Realm.h>

@class ABFRestaurantObject;

typedef NS_ENUM(NSInteger, ABFInspectionType) {
    ABFInspectionTypeInitial = 0,
    ABFInspectionTypeRoutine,
    ABFInspectionTypeFollowUp
};

@interface ABFInspectionObject : RLMObject

/**
 *  Business for which this inspection was done
 */
@property ABFRestaurantObject *restaurant;

/**
 *  Inspection score on a 0-100 scale. 100 is the highest score
 */
@property NSInteger score;

/**
 *  Date of the inspection in (YYYYMMDD original format)
 */
@property NSDate *date;

/**
 *  Type of inspection (initial, routine, followup strings original format)
 */
@property ABFInspectionType type;

@end

// This protocol enables typed collections. i.e.:
// RLMArray<ABFInspectionObject>
RLM_ARRAY_TYPE(ABFInspectionObject)

//
//  ABFRestaurantObject.h
//  ABFRealmSearchControllerExample
//
//  Created by Adam Fish on 5/29/15.
//  Copyright (c) 2015 Adam Fish. All rights reserved.
//

#import <Realm/Realm.h>

#import "ABFInspectionObject.h"
#import "ABFViolationObject.h"

@import MapKit;

@interface ABFRestaurantObject : RLMObject

/**
 *  Unique identifier for the business. For many cities, this may be the license #
 */
@property NSString *businessId;

/**
 *  Common name of the business
 */
@property NSString *name;

/**
 *  Street address of the business. For example 706 Mission St
 */
@property NSString *address;

/**
 *  City of the business. This field must be included if the file contains businesses from multiple cities
 */
@property NSString *city;

/**
 *  State or province for the business. In the U.S. this should be the two-letter code for the state
 */
@property NSString *state;

/**
 *  Zip code or other postal code
 */
@property NSString *postalCode;

/**
 *  Latitude of the business. This field must be a valid WGS 84 latitude. For example 37.7859547
 */
@property CLLocationDegrees latitude;

/**
 *  Longitude of the business. This field must be a valid WGS 84 longitude. For example - 122.4024658
 */
@property CLLocationDegrees longitude;

/**
 *  Phone number for a business including country specific dialing information. For example +14159083801
 */
@property NSString *phoneNumber;

/**
 *  All violations for the restaurant
 */
@property RLMArray<ABFViolationObject> *violations;

/**
 *  All inspections for the restaurant
 */
@property RLMArray<ABFInspectionObject> *inspections;

@end

// This protocol enables typed collections. i.e.:
// RLMArray<ABFRestaurantObject>
RLM_ARRAY_TYPE(ABFRestaurantObject)

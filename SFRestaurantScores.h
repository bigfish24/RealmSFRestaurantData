//
//  SFRestaurantScores.h
//  
//
//  Created by Adam Fish on 6/1/15.
//
//

#import <Foundation/Foundation.h>

#import "ABFInspectionObject.h"
#import "ABFRestaurantObject.h"
#import "ABFViolationObject.h"

/**
 *  Retrieve the path for the prebuilt SFRestaurantScores Realm file
 *
 *  @return path to SFRestaurantScores.realm
 */
NSString * ABFRestaurantScoresPath() {
    return [[NSBundle mainBundle] pathForResource:@"SFRestaurantScores" ofType:@"realm"];
}

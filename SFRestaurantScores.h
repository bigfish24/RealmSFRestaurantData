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

static inline NSString * ABFRestaurantScoresPath() {
    return [[NSBundle mainBundle] pathForResource:@"SFRestaurantScores" ofType:@"realm"];
}

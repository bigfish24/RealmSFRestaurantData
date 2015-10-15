//
//  main.m
//  RestaurantDataImporter
//
//  Created by Adam Fish on 6/9/15.
//  Copyright (c) 2015 Adam Fish. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <Realm/Realm.h>
#import "ABFRealmCSVImporter.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        // insert code here...
        NSString *currentPath = [[NSFileManager defaultManager] currentDirectoryPath];
        
        NSString *fullPath = [NSString stringWithFormat:@"%@/SFRestaurantScores.realm",currentPath];
        
        RLMRealmConfiguration *defaultConfiguration = [RLMRealmConfiguration defaultConfiguration];
        defaultConfiguration.path = fullPath;
        
        [RLMRealmConfiguration setDefaultConfiguration:defaultConfiguration];
        
        [ABFRealmCSVImporter loadRestaurantData];
    }
    return 0;
}

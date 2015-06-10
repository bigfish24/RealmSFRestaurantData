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
        
        [RLMRealm setDefaultRealmPath:fullPath];
        
        [ABFRealmCSVImporter loadRestaurantData];
    }
    return 0;
}

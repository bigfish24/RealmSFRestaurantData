//
//  ABFRealmCSVImporter.m
//  ABFRealmSearchControllerExample
//
//  Created by Adam Fish on 5/29/15.
//  Copyright (c) 2015 Adam Fish. All rights reserved.
//

#import "ABFRealmCSVImporter.h"

#import "ABFRestaurantObject.h"

@implementation ABFRealmCSVImporter

+ (void)loadRestaurantData
{
    [ABFRealmCSVImporter cleanUpRealm];
    
    NSArray *restaurantRows = [ABFRealmCSVImporter getRowsFromCSVWithName:@"businesses"];
    NSArray *inspectionsRows = [ABFRealmCSVImporter getRowsFromCSVWithName:@"inspections"];
    NSArray *violationsRows = [ABFRealmCSVImporter getRowsFromCSVWithName:@"violations"];
    
    [ABFRealmCSVImporter loadRestaurantsWithRows:restaurantRows];
    
    [ABFRealmCSVImporter loadInspectionsWithRows:inspectionsRows];
    
    [ABFRealmCSVImporter loadViolationsWithRows:violationsRows];
}

#pragma mark - Private Class

+ (void)cleanUpRealm
{
    RLMRealm *realm = [RLMRealm defaultRealm];
    
    [realm transactionWithBlock:^() {
        [realm deleteObjects:[ABFRestaurantObject allObjects]];
        [realm deleteObjects:[ABFInspectionObject allObjects]];
        [realm deleteObjects:[ABFViolationObject allObjects]];
    }];
}

+ (NSArray *)getRowsFromCSVWithName:(NSString *)name
{
    NSString *currentPath = [[NSFileManager defaultManager] currentDirectoryPath];
    
    NSString *fullPath = [NSString stringWithFormat:@"%@/raw-data/%@.csv",currentPath,name];
    
    NSError *error = nil;
    
    NSString *csvString = [NSString stringWithContentsOfFile:fullPath
                                                    encoding:NSASCIIStringEncoding
                                                       error:&error];
    
    if (error) {
        NSLog(@"CSV Load Error: %@",error.description);
        
        error = nil;
    }
    
    NSArray *csvRows = [csvString componentsSeparatedByString:@"\n"];
    
    csvRows = [ABFRealmCSVImporter removeFirstObjectInArray:csvRows];
    
    return csvRows;
}

+ (NSArray *)removeFirstObjectInArray:(NSArray *)array
{
    NSMutableArray *mutableArray = [NSMutableArray arrayWithArray:array];
    
    [mutableArray removeObject:mutableArray.firstObject];
    
    return mutableArray.copy;
}

+ (void)loadRestaurantsWithRows:(NSArray *)restaurantRows
{
    RLMRealm *realm = [RLMRealm defaultRealm];
    
    [realm beginWriteTransaction];
    
    for (NSString *restaurant in restaurantRows) {
        @autoreleasepool {
            NSArray *columns = [restaurant componentsSeparatedByString:@","];
            
            // Adjust if we have extra street
            if (columns.count > 9) {
                
                NSMutableArray *mutableColumns = [NSMutableArray arrayWithArray:columns];
                
                [mutableColumns removeObjectAtIndex:2];
                
                columns = mutableColumns.copy;
            }
            
            ABFRestaurantObject *restaurantObject = [[ABFRestaurantObject alloc] init];
            
            for (NSInteger index = 0; index < columns.count; index++) {
                NSString *column = columns[index];
                
                column = [column stringByTrimmingCharactersInSet:[NSCharacterSet newlineCharacterSet]];
                
                column = [column stringByReplacingOccurrencesOfString:@"\"" withString:@""];
                
                if (index == 0) {
                    restaurantObject.businessId = column;
                }
                else if (index == 1) {
                    restaurantObject.name= column;
                }
                else if (index == 2) {
                    restaurantObject.address= column;
                }
                else if (index == 3) {
                    restaurantObject.city= column;
                }
                else if (index == 4) {
                    restaurantObject.state= column;
                }
                else if (index == 5) {
                    restaurantObject.postalCode= column;
                }
                else if (index == 6) {
                    restaurantObject.latitude= column.doubleValue;
                }
                else if (index == 7) {
                    restaurantObject.longitude = column.doubleValue;
                }
                else if (index == 8) {
                    restaurantObject.phoneNumber= column;
                }
            }
            
            if (![restaurantObject.name isEqualToString:@""] &&
                restaurantObject.longitude != 0 &&
                restaurantObject.latitude != 0) {
                
                [realm addObject:restaurantObject];
            }
        }
    }
    
    [realm commitWriteTransaction];
}

+ (void)loadInspectionsWithRows:(NSArray *)inspectionsRows
{
    RLMRealm *realm = [RLMRealm defaultRealm];
    
    [realm beginWriteTransaction];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"YYYYMMDD";
    
    for (NSString *inspection in inspectionsRows) {
        @autoreleasepool {
            
            NSArray *columns = [inspection componentsSeparatedByString:@","];
            
            ABFInspectionObject *inspectionObject = [[ABFInspectionObject alloc] init];
            
            for (NSInteger index = 0; index < columns.count; index++) {
                NSString *column = columns[index];
                
                column = [column stringByTrimmingCharactersInSet:[NSCharacterSet newlineCharacterSet]];
                
                column = [column stringByReplacingOccurrencesOfString:@"\"" withString:@""];
                
                if (index == 0) {
                    ABFRestaurantObject *restaurant = [ABFRestaurantObject objectForPrimaryKey:column];
                    
                    if (restaurant) {
                        inspectionObject.restaurant = restaurant;
                        
                        [restaurant.inspections addObject:inspectionObject];
                    }
                }
                if (index == 1) {
                    inspectionObject.score = column.integerValue;
                }
                if (index == 2) {
                    NSDate *date = [dateFormatter dateFromString:column];
                    
                    if (date) {
                        inspectionObject.date = date;
                    }
                }
                if (index == 3) {
                    
                    if ([column isEqualToString:@"routine"]) {
                        inspectionObject.type = ABFInspectionTypeRoutine;
                    }
                    else if ([column isEqualToString:@"initial"]) {
                        inspectionObject.type = ABFInspectionTypeInitial;
                    }
                    else if ([column isEqualToString:@"followup"]) {
                        inspectionObject.type = ABFInspectionTypeFollowUp;
                    }
                }
            }
            
            if (inspectionObject.restaurant) {
                [realm addObject:inspectionObject];
            }
        }
    }
    
    [realm commitWriteTransaction];
}

+ (void)loadViolationsWithRows:(NSArray *)violationsRows
{
    RLMRealm *realm = [RLMRealm defaultRealm];
    
    [realm beginWriteTransaction];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"YYYYMMDD";
    
    for (NSString *violation in violationsRows) {
        
        @autoreleasepool {
            
            NSArray *columns = [violation componentsSeparatedByString:@","];
            
            ABFViolationObject *violationObject = [[ABFViolationObject alloc] init];
            
            for (NSInteger index = 0; index < columns.count; index++) {
                NSString *column = columns[index];
                
                column = [column stringByTrimmingCharactersInSet:[NSCharacterSet newlineCharacterSet]];
                
                column = [column stringByReplacingOccurrencesOfString:@"\"" withString:@""];
                
                if (index == 0) {
                    ABFRestaurantObject *restaurant = [ABFRestaurantObject objectForPrimaryKey:column];
                    
                    if (restaurant) {
                        violationObject.restaurant = restaurant;
                        
                        [restaurant.violations addObject:violationObject];
                    }
                }
                else if (index == 1) {
                    NSDate *date = [dateFormatter dateFromString:column];
                    
                    if (date) {
                        violationObject.date = date;
                    }
                }
                else if (index == 2) {
                    violationObject.violationDescription = column;
                }
                
            }
            
            if (violationObject.restaurant) {
                [realm addObject:violationObject];
            }
        }
    }
    
    [realm commitWriteTransaction];
}

@end

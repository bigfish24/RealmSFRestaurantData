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
 *  Retrieve the path for a given file name in the documents directory
 *
 *  @param fileName the name of the file in the documents directory
 *
 *  @return path to SFRestaurantScores.realm
 */
static NSString * ABFDocumentFilePathWithName(NSString *fileName)
{
#if TARGET_OS_IPHONE
    // On iOS the Documents directory isn't user-visible, so put files there
    NSString *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
#else
    // On OS X it is, so put files in Application Support. If we aren't running
    // in a sandbox, put it in a subdirectory based on the bundle identifier
    // to avoid accidentally sharing files between applications
    NSString *path = NSSearchPathForDirectoriesInDomains(NSApplicationSupportDirectory, NSUserDomainMask, YES)[0];
    if (![[NSProcessInfo processInfo] environment][@"APP_SANDBOX_CONTAINER_ID"]) {
        NSString *identifier = [[NSBundle mainBundle] bundleIdentifier];
        if ([identifier length] == 0) {
            identifier = [[[NSBundle mainBundle] executablePath] lastPathComponent];
        }
        path = [path stringByAppendingPathComponent:identifier];
        
        // create directory
        [[NSFileManager defaultManager] createDirectoryAtPath:path
                                  withIntermediateDirectories:YES
                                                   attributes:nil
                                                        error:nil];
    }
#endif
    return [path stringByAppendingPathComponent:fileName];
}

/**
 *  Retrieve the path for the prebuilt SFRestaurantScores Realm file
 *
 *  @return path to SFRestaurantScores.realm
 */
static NSString * ABFRestaurantScoresPath()
{
    // Move the file from bundle to the documents folder for read/write access
    NSString *fileInDocuments = ABFDocumentFilePathWithName(@"SFRestaurantScores.realm");
    
    if (![[NSFileManager defaultManager] fileExistsAtPath:fileInDocuments]) {
        
        NSBundle *bundle = [NSBundle bundleForClass:[ABFRestaurantObject class]];
        
        NSString *fileInBundle = [bundle pathForResource:@"SFRestaurantScores" ofType:@"realm"];
        
        NSError *error = nil;
        
        NSFileManager *fileManager = [NSFileManager defaultManager];
        
        if (![fileManager copyItemAtPath:fileInBundle
                                  toPath:fileInDocuments
                                   error:&error]) {
            
            NSLog(@"Copy File Error: %@",error.localizedDescription);
            
            error = nil;
        }
        
        if (![fileManager setAttributes:@{NSFilePosixPermissions : @(0644)}
                           ofItemAtPath:fileInDocuments
                                  error:&error]) {
            
            NSLog(@"File Permission Error: %@",error.localizedDescription);
        }
    }
    
    return fileInDocuments;
}

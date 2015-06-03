# RealmSFRestaurantData
Prebuilt Realm dataset composed of San Francisco restaurant scores

[Data Source](https://data.sfgov.org/data?search=restaurants)

####Data Model
RLMObject subclasses corresponding to the data model are included in the objects folder. 

Data model structure:

* `ABFRestaurantObject`
  * businessId: `NSString` (primary key)
  * name: `NSString`
  * address: `NSString`
  * city: `NSString`
  * state: `NSString`
  * postalCode: `NSString`
  * latitude: `CLLocationDegrees`
  * longitude: `CLLocationDegrees`
  * phoneNumber: `NSString`
  * violations: `RLMArray<ABFViolationObject>`
  * inspections: `RLMArray<ABFInspectionObject>`
* `ABFInspectionObject`
  * restaurant: `ABFRestaurantObject`
  * score: `NSInteger`
  * date: `NSDate`
  * type: `ABFInspectionType`
* `ABFViolationObject`
  * restaurant: `ABFRestaurantObject`
  * date: `NSDate`
  * violationDescription: `NSString`

####Installation
RealmSFRestaurantData is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:
```
pod "RealmSFRestaurantData"
```
Cocoapods has a [reported issue](https://github.com/CocoaPods/CocoaPods/issues/3557) that overwrites the file permissions for resources included with the pod. To fix perform this call after `pod install`:
```
chmod 644 Pods/RealmSFRestaurantData/SFRestaurantScores.realm
```

From your project:
```objc
#import <RealmSFRestaurantData/SFRestaurantScores.h>
...
RLMRealm *restaurantRealm = [RLMRealm realmWithPath:ABFRestaurantScoresPath()];

RLMResults *restaurants = [ABFRestaurantObject allObjectsInRealm:restaurantRealm];
```

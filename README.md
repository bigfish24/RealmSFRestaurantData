# RealmSFRestaurantData
Prebuilt Realm dataset composed of San Francisco restaurant scores

[Data Source](https://data.sfgov.org/data?search=restaurants)

####Data Model
`RLMObject` subclasses corresponding to the data model are included in the objects folder. 

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
`RealmSFRestaurantData` is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:
```
pod "RealmSFRestaurantData"
```
From your project:
```objc
#import <RealmSFRestaurantData/SFRestaurantScores.h>
...
RLMRealm *restaurantRealm = [RLMRealm realmWithPath:ABFRestaurantScoresPath()];

RLMResults *restaurants = [ABFRestaurantObject allObjectsInRealm:restaurantRealm];
```
####Demo
An example project that uses `RealmSFRestaurantData` is provided in the [ABFRealmSearchViewController](https://github.com/bigfish24/ABFRealmSearchViewController) repo. To install follow the instructions provided.

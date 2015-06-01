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

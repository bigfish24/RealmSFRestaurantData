Pod::Spec.new do |s|
  s.name         = "RealmSFRestaurantData"
  s.version      = "0.0.6"
  s.summary      = "San Francisco Restaurant Score Data In Realm"
  s.description  = <<-DESC
Prebuilt Realm dataset composed of San Francisco restaurant scores
                   DESC
  s.homepage     = "https://github.com/bigfish24/RealmSFRestaurantData"
  s.license      = { :type => "MIT", :file => "LICENSE" }
  s.author       = { "Adam Fish" => "af@realm.io" }
  s.ios.deployment_target = "7.0"
  s.osx.deployment_target = "10.9"
  s.source       = { :git => "https://github.com/bigfish24/RealmSFRestaurantData.git", :tag => "v#{s.version}" }
  s.source_files  = "SFRestaurantScores.h", "objects/*.{h,m}"
  s.requires_arc = true
  s.dependency "Realm"
  s.resource = "SFRestaurantScores.realm"

end
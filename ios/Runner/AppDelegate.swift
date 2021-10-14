import UIKit
import Flutter
import GoogleMaps

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {

//     var keys: NSDictionary?
//
//     if let path = Bundle.main.path(forResource: "Keys", ofType: "plist") {
//              keys = NSDictionary(contentsOfFile: path)
//     }
//     if let dict = keys {
//         let googleMapsAPIKey = dict["GOOGLE_MAPS_API_KEY"] as! String
//
//         print(googleMapsAPIKey)
//
//         GMSServices.provideAPIKey(googleMapsAPIKey)
//     }




    GeneratedPluginRegistrant.register(with: self)

    guard let filePath = Bundle.main.path(forResource: "keys", ofType: "plist") else {
        fatalError("Couldn't find file 'keys.plist'.")
    }

    let plist = NSDictionary(contentsOfFile: filePath)
    guard let apiKey = plist?.object(forKey: "GOOGLE_MAPS_API_KEY") as? String else {
        fatalError("Couldn't find key 'GOOGLE_MAPS_API_KEY' in 'keys.plist'.")
    }

    GMSServices.provideAPIKey(apiKey)

    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}

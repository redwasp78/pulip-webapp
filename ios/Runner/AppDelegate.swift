import Flutter
import UIKit
import Firebase

@main
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    // Firebase 초기화 (실패해도 앱은 정상 작동)
    do {
      if let path = Bundle.main.path(forResource: "GoogleService-Info", ofType: "plist") {
        if let plist = NSDictionary(contentsOfFile: path) {
          print("GoogleService-Info.plist found, initializing Firebase...")
          FirebaseApp.configure()
          print("Firebase initialized successfully")
        } else {
          print("GoogleService-Info.plist is invalid - Firebase initialization skipped")
        }
      } else {
        print("GoogleService-Info.plist not found - Firebase initialization skipped")
      }
    } catch {
      print("Firebase initialization failed: \(error.localizedDescription) - App will continue without Firebase")
    }
    
    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}

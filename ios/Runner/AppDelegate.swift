import UIKit
import Flutter

//add for local notification
import flutter_local_notifications

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {

    //start for local notification
    FlutterLocalNotificationsPlugin.setPluginRegistrantCallback { (registry) in
    GeneratedPluginRegistrant.register(with: registry)}
    //end for local notification

    GeneratedPluginRegistrant.register(with: self)

    //start for local notification
    if #available(iOS 10.0, *) {
         UNUserNotificationCenter.current().delegate = self as? UNUserNotificationCenterDelegate
      }
      application.registerForRemoteNotifications()
    //end for local notification

    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}

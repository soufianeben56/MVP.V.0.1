// import 'dart:async';
//
// import 'package:ahlan_hr/exports.dart';
// import 'package:ahlan_hr/service/notification_manager.dart';
// import 'package:awesome_notifications/awesome_notifications.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:firebase_crashlytics/firebase_crashlytics.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
//
// class FirebaseService {
//   static late FirebaseApp firebaseApp;
//   static FirebaseCrashlytics crashlytics = FirebaseCrashlytics.instance;
//   static FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;
//
//   static void initialise() async {
//     firebaseApp = await Firebase.initializeApp();
//     FlutterError.onError = crashlytics.recordFlutterError;
//
//     await setUpNotification();
//     print("FCM Token ${await getFcmToken()}");
//     await crashlytics.setCrashlyticsCollectionEnabled(true);
//
//     NotificationManager.checkNotificationEnabledOrNot();
//
//     AwesomeNotifications().setListeners(
//       onActionReceivedMethod: NotificationManager.onActionReceivedMethod,
//       onNotificationCreatedMethod: NotificationManager.onNotificationCreatedMethod,
//       onNotificationDisplayedMethod: NotificationManager.onNotificationDisplayedMethod,
//       onDismissActionReceivedMethod: NotificationManager.onDismissActionReceivedMethod,
//     );
//   }
//
//   static void firebaseRecordError(Object error, StackTrace stackTrace) async {
//     await crashlytics.recordError(error, stackTrace);
//   }
//
//   static Future<String?> getFcmToken() async {
//     return await firebaseMessaging.getToken();
//   }
//
//   static Future<String?> getAPNToken() async {
//     return await firebaseMessaging.getAPNSToken();
//   }
//
//   static String? refreshFcmToken() {
//     String? refreshToken = "";
//     firebaseMessaging.onTokenRefresh.listen((newToken) async {
//       refreshToken = newToken;
//     });
//     return refreshToken;
//   }
//
//   static Future<void> setUpNotification() async {
//     await firebaseMessaging.setForegroundNotificationPresentationOptions(
//       sound: true,
//     );
//     FirebaseMessaging.onMessage.listen(onMessage);
//     FirebaseMessaging.onMessageOpenedApp.listen(onMessage);
//     FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
//   }
//
//   static void onMessage(RemoteMessage message) {
//     LogUtils.writeLog(
//         message: "Message from onMessage : ${message.data}",
//         tag: "FCM onMessage");
//     NotificationManager.initialise(message);
//   }
//
//   @pragma('vm:entry-point')
//   static Future<void> firebaseMessagingBackgroundHandler(
//       RemoteMessage message) async {
//     initialise();
//     await setUpNotification();
//     print('Handling a background message ${message.data}');
//   }
// }
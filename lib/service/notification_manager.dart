// import 'dart:math';
//
// import 'package:ahlan_hr/exports.dart';
// import 'package:ahlan_hr/presentation/widgets/confirmation_dialog_widget.dart';
// import 'package:awesome_notifications/awesome_notifications.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
//
// class NotificationManager {
//   final NavigationService navigationService = NavigationService();
//
//   static void initialise(RemoteMessage message) {
//
//   }
//
//   static Future<void> checkNotificationEnabledOrNot() async {
//     AwesomeNotifications().isNotificationAllowed().then(
//       (isAllowed) {
//         if (!isAllowed) {
//           showDialog(
//             context: NavigationService.navigationKey.currentContext!,
//             barrierDismissible: false,
//             builder: (context) {
//               return ConfirmationDialogWidget(
//                 title:  S.current.confirmation,
//                 message: S.current.notification_desc_message,
//                 onTapPositive: () {
//                   AwesomeNotifications()
//                                 .requestPermissionToSendNotifications()
//                                 .then((_) {
//                                   Navigator.pop(NavigationService.navigationKey.currentContext!);
//                   });
//                 },
//                 onTapNegative: () {
//                   Navigator.pop(NavigationService.navigationKey.currentContext!);
//
//                 },
//                 positiveText: S.current.allow,
//                 negativeText: S.current.cancel,
//               );
//             },
//           );
//           // Get.generalDialog(
//           //   pageBuilder: (context, animation, secondaryAnimation) {
//           //     return CupertinoAlertDialog(
//           //       title: Text('Allow Notifications'),
//           //       content: Text('Our app would like to send you notifications'),
//           //       actions: [
//           //         TextButton(
//           //           onPressed: () {
//           //             Get.back();
//           //           },
//           //           child: Text(
//           //             'Don\'t Allow',
//           //             style: TextStyle(color: Colors.grey, fontSize: 18),
//           //           ),
//           //         ),
//           //         TextButton(
//           //           onPressed: () => AwesomeNotifications()
//           //               .requestPermissionToSendNotifications()
//           //               .then((_) => Get.back()),
//           //           child: Text(
//           //             'Allow',
//           //             style: TextStyle(
//           //               color: Colors.teal,
//           //               fontSize: 18,
//           //               fontWeight: FontWeight.bold,
//           //             ),
//           //           ),
//           //         ),
//           //       ],
//           //     );
//           //   },
//           // );
//         }
//
//         cancelAll();
//       },
//     );
//   }
//
//   static void cancelAll() async {
//     await AwesomeNotifications().resetGlobalBadge();
//     await AwesomeNotifications().cancelAll();
//     await AwesomeNotifications().dismissAllNotifications();
//   }
//
//   static void setupLocalNotification({
//     String title = "",
//     String body = "",
//     NotificationLayout notificationLayout = NotificationLayout.Default,
//     Map<String, String?>? remoteMessage,
//   }) async {
//     bool isAllowed = await AwesomeNotifications().isNotificationAllowed();
//     try {
//       await AwesomeNotifications().createNotification(
//         content: NotificationContent(
//           id: getUniqueNotificationId(),
//           channelKey: 'tap_in_notification',
//           title: title,
//           body: body,
//           notificationLayout: notificationLayout,
//           locked: true,
//           payload: remoteMessage,
//           actionType: ActionType.Default,
//         ),
//       );
//     } catch (e) {
//       print(e.toString());
//     }
//   }
//
//   static int getUniqueNotificationId() {
//     var randomNumber = Random();
//     var resultOne = randomNumber.nextInt(2000);
//     var resultTwo = randomNumber.nextInt(100);
//     if (resultTwo >= resultOne) resultTwo += 1;
//     return resultTwo;
//   }
//
//   @pragma("vm:entry-point")
//   static Future<void> onNotificationCreatedMethod(
//       ReceivedNotification receivedNotification) async {
//     LogUtils.writeLog(
//         message: receivedNotification.toMap().toString(),
//         tag: "onNotificationCreatedMethod");
//   }
//
//   /// Use this method to detect every time that a new notification is displayed
//
//   @pragma("vm:entry-point")
//   static Future<void> onNotificationDisplayedMethod(
//       ReceivedNotification receivedNotification) async {
//     LogUtils.writeLog(
//         message: receivedNotification.toMap().toString(),
//         tag: "onNotificationDisplayedMethod");
//   }
//
//   /// Use this method to detect if the user dismissed a notification
//   @pragma("vm:entry-point")
//   static Future<void> onDismissActionReceivedMethod(
//       ReceivedAction receivedAction) async {
//     LogUtils.writeLog(
//         message: receivedAction.toMap().toString(),
//         tag: "onDismissActionReceivedMethod");
//   }
//
//   /// Use this method to detect when the user taps on a notification or action button
//
//   @pragma("vm:entry-point")
//   static Future<void> onActionReceivedMethod(
//       ReceivedAction receivedAction) async {
//     LogUtils.writeLog(
//         message: receivedAction.toMap().toString(),
//         tag: "onActionReceivedMethod");
//   }
//
//
// }

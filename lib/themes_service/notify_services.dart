import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';

class NotifyHelper {
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  initializeNotification() async {
    final IOSInitializationSettings initializationSettingsIOS =
        IOSInitializationSettings(
            requestSoundPermission: false,
            requestBadgePermission: false,
            requestAlertPermission: false,
            onDidReceiveLocalNotification: onDidReceiveLocalNotification);

    final AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings("appicon");

    InitializationSettings initializationSettings = InitializationSettings(
        android: AndroidInitializationSettings("appicon"),
        iOS: IOSInitializationSettings());
    await flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: selectNotification);
  }

  void requestIOSPermissions() {
    flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            IOSFlutterLocalNotificationsPlugin>()
        ?.requestPermissions(
          alert: true,
          badge: true,
          sound: true,
        );
  }

  displayNotification({required String title, required String body}) async {
    print("doing test");
    var androidPlatformChannelSpecifics = new AndroidNotificationDetails(
        'your channel id', 'your channel name',
        importance: Importance.max, priority: Priority.high);
    var iOSPlatformChannelSpecifics = new IOSNotificationDetails();
    var platformChannelSpecifics = new NotificationDetails(
        android: androidPlatformChannelSpecifics,
        iOS: iOSPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.show(
      0,
      'You change your theme',
      'You changed your theme back !',
      platformChannelSpecifics,
      payload: 'It could be anything you pass',
    );
  }

  Future selectNotification(String? payload) async {
    if (payload != null) {
      print('notification payload: $payload');
    } else {
      print("Notification Done");
    }
    Get.to(() => Container(
          color: Colors.white,
        ));
  }

  // var ios = new IOSInitializationSettings();
  Future onDidReceiveLocalNotification(
      int id, String? title, String? body, String? payload) async {
    // display a dialog with the notification details, tap ok to go to another page
    //   showDialog(
    //     //context: context,
    //     builder: (BuildContext context) => CupertinoAlertDialog(
    //       title: Text(title),
    //       content: Text(body),
    //       actions: [
    //         CupertinoDialogAction(
    //           isDefaultAction: true,
    //           child: Text('Ok'),
    //           onPressed: () async {
    //             Navigator.of(context, rootNavigator: true).pop();
    //             await Navigator.push(
    //               context,
    //               MaterialPageRoute(
    //                 builder: (context) => SecondScreen(payload),
    //               ),
    //             );
    //           },
    //         )
    //       ],
    //     ),
    //   );
    // }
    Get.dialog(Text("Welcome To Flutter"));
  }
}
  // void initState() {
  //   super.initState();
  //   notifyHelper = NotifyHelper();
  //   notifyHelper.initializeNotification();
  //   notifyHelper.requestIOSPermissions();
  // }
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:sezon/src/config/constants.dart';

class LocalNotificationsManager {
  static LocalNotificationsManager? _instance;
  late final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  int _id = 0;

  // private constructor.
  LocalNotificationsManager._();

  // singleton pattern.
  static LocalNotificationsManager get instance =>
      _instance ?? (_instance = LocalNotificationsManager._());

  // init.
  Future<void> init() async {
    AndroidInitializationSettings androidInitializationSettings =
        // const AndroidInitializationSettings('@mipmap/launcher_icon');
        const AndroidInitializationSettings('@mipmap/ic_launcher');
    DarwinInitializationSettings iosInitializationSettings =
        DarwinInitializationSettings(
            onDidReceiveLocalNotification: _onDidReceiveLocalNotification);
    InitializationSettings initializationSettings = InitializationSettings(
        android: androidInitializationSettings, iOS: iosInitializationSettings);
    await _flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      // onSelectNotification: onNotificationTapped
    );
  }

  // on did received local notification.
  void _onDidReceiveLocalNotification(
      int id, String? title, String? body, String? payload) async {
    // display a dialog with the notification details, tap ok to go to another page
    // showDialog(
    //   context: context,
    //   builder: (BuildContext context) => CupertinoAlertDialog(
    //     title: Text(title),
    //     content: Text(body),
    //     actions: [
    //       CupertinoDialogAction(
    //         isDefaultAction: true,
    //         child: Text('Ok'),
    //         onPressed: () async {
    //           Navigator.of(context, rootNavigator: true).pop();
    //           await Navigator.push(
    //             context,
    //             MaterialPageRoute(
    //               builder: (context) => SecondScreen(payload),
    //             ),
    //           );
    //         },
    //       )
    //     ],
    //   ),
    // );
  }

  // on notification tapped.
  Future onNotificationTapped(String? payload) async {
    debugPrint('starting [onNotificationTapped][LocalNotificationsService]...');
    debugPrint('payload : $payload');
    // if (payload == null) return;
    // RemoteMessage message = RemoteMessage.fromMap(jsonDecode(payload));
    // String? targetType = message.data['target_type'];
    // int? targetId = int.tryParse(message.data['target_id'] ?? '');
  }

  // show notification.
  void showNotification(
    String? title,
    String? message, {
    String? payload,
  }) {
    _flutterLocalNotificationsPlugin.show(
      ++_id,
      title,
      message,
      const NotificationDetails(
        android: AndroidNotificationDetails(
          Constants.androidNotificationChannelId,
          Constants.androidNotificationChannelName,
          enableVibration: true,
          importance: Importance.max,
          priority: Priority.max,
        ),
        iOS: DarwinNotificationDetails(),
      ),
      payload: payload,
    );
  }
}

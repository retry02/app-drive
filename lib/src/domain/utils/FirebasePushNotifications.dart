import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:indriver_clone_flutter/firebase_options.dart';
import 'package:indriver_clone_flutter/main.dart';
import 'package:indriver_clone_flutter/src/presentation/pages/driver/clientRequests/DriverClientRequestsPage.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';


late AndroidNotificationChannel channel;
bool isFlutterLocalNotificationsInitialized = false;
late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

@pragma('vm:entry-point')
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await setupFlutterNotifications();
  showFlutterNotification(message);
  print('Handling a background message ${message.messageId}');
  print('INFORMACION NOTIFICACION BACKGROUND: ${message.data}');
}


Future<void> setupFlutterNotifications() async {
  if (isFlutterLocalNotificationsInitialized) {
    return;
  }
  channel = const AndroidNotificationChannel(
    'high_importance_channel', // id
    'High Importance Notifications', // title
    description:
        'This channel is used for important notifications.', // description
    importance: Importance.high,
  );

  flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);

  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );
  isFlutterLocalNotificationsInitialized = true;
}

void showFlutterNotification(RemoteMessage message) {
  print('---------- NOTIFICACION PRIMER PLANO -----------');
  print('DATA FOREGROUND : ${message.data}');
  print('NOTIFICATION FOREGROUND: ${message.notification?.title}');
  print('NOTIFICATION FOREGROUND: ${message.notification?.body}');
  RemoteNotification? notification = message.notification;
  AndroidNotification? android = message.notification?.android;
  if (notification != null && android != null && !kIsWeb) {
    flutterLocalNotificationsPlugin.show(
      notification.hashCode,
      notification.title,
      notification.body,
      NotificationDetails(
        android: AndroidNotificationDetails(
          channel.id,
          channel.name,
          channelDescription: channel.description,
          // TODO add a proper drawable resource to android, for now using
          //      one that already exists in example app.
          icon: 'launch_background'
        ),
      ),
    );
  }
  
}

void onMessageListener() async {
  FirebaseMessaging.instance.getInitialMessage().then(
      (RemoteMessage? message) {
        if (message != null) {
          print('---------- NOTIFICACION ENTRANTE ---------');
          print('INFORMACION NOTIFICACION NORMAL: ${message.data}');
        }
      }
  );

  // NOTIFICACIONES EN PRIMER PLANO
  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    if (navigatorKey.currentContext != null) {
      showMaterialModalBottomSheet(
        context: navigatorKey.currentContext!,
        builder: (context) => Container(
          height: MediaQuery.of(context).size.height * 0.9,
          child: DriverClientRequestsPage()
        )
      );
    }
  });

  FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
    print('---------- NOTIFICACION CLIKEADA -----------');

    print('INFORMACION NOTIFICACION CLICKEADA: ${message.data}');
    if (message.data['type'] == 'CLIENT_REQUEST') {
      if (navigatorKey.currentContext != null) {
        Navigator.pushNamed(
          navigatorKey.currentContext!,
          'driver/client/request',
          // arguments: MessageArguments(message, true),
        );
      }
    }
  });
}


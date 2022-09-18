import 'package:kyo_base/imports/base_component_import.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

/// TODO: SETUP
/// 1. Add this to manifest
/// <meta-data
///      android:name="com.google.firebase.messaging.default_notification_channel_id"
///      android:value="high_importance_channel" />
/// 2. IOS: https://firebase.flutter.dev/docs/messaging/apple-integration
/// 3. If use IOS lower IOS 10 then add onDidReceiveLocalNotification for flutter_local_notifications
/// 4. Subscribe to  Global Topics
///

const _iconLocation = '@mipmap/ic_launcher';

typedef NotificationPressedCallBack = void Function(
    Map<String, dynamic>? jsonData);

typedef FilterMessage = bool Function(Map<String, dynamic>? jsonData);

/// This must be top-level method
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  await Firebase.initializeApp();

  // In here you can perform logic such as HTTP requests, perform IO operations (e.g. updating local storage)
  logger.i("Handling a background message: ${message.notification?.title}");
}

class FirebaseNotificationService {
  FirebaseNotificationService._();

  static final FirebaseNotificationService _instance =
      FirebaseNotificationService._();

  static FirebaseNotificationService get instance {
    return _instance;
  }

  FlutterLocalNotificationsPlugin? flutterLocalNotificationsPlugin;
  AndroidNotificationChannel? channel;

  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  Future<void> init({
    required NotificationPressedCallBack notificationPressedCallBack,
    required FilterMessage filterMessage,
  }) async {
    await _requestPermission();
    await _initFlutterLocalNotificationPlugin(
        onPressedCallback: notificationPressedCallBack);

    // await _enableAlwaysHeadUpMessageIOS();
    await _setupChannelForAndroid();
    await _setupMessageListener(filterMessage: filterMessage);
    await setupInteractedMessage(callBack: notificationPressedCallBack);

    _firebaseMessaging.getToken().then((value) {
      logger.i('FirebaseMessaging Token: ${value?.toString() ?? ''}');
    });
  }

  Future<String?> getFCMToken() {
    return _firebaseMessaging.getToken();
  }

  Future<void> _requestPermission() async {
    NotificationSettings settings = await _firebaseMessaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.denied ||
        settings.authorizationStatus == AuthorizationStatus.notDetermined) {
      logger
          .e('PushNotification: User declined or has not accepted permission');
    }
  }

  ///
  /// Init flutter_local_notifications for local notification
  ///
  Future<void> _initFlutterLocalNotificationPlugin(
      {required NotificationPressedCallBack onPressedCallback}) async {
    // Android Setting
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings(_iconLocation);
    // IOS Setting
    const IOSInitializationSettings initializationSettingsIOS =
        IOSInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
    );
    // initialise the plugin. app_icon needs to be a added as a drawable resource to the Android head project
    // Combine
    const InitializationSettings initializationSettings =
        InitializationSettings(
            android: initializationSettingsAndroid,
            iOS: initializationSettingsIOS);

    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

    // Handle when FlutterLocalNotificationPlugin notification is clicked
    flutterLocalNotificationsPlugin?.initialize(initializationSettings,
        onSelectNotification: (String? payload) async {
      if (payload != null) {
        try {
          final payloadJson = await jsonDecode(payload);
          onPressedCallback.call(payloadJson);
        } catch (e, trace) {
          logger.e(e.toString(), e, trace);
        }
      }
    });
  }

  void _showMessageHeadUpForeground({
    RemoteMessage? message,
    required FilterMessage filterMessage,
  }) {
    logger.i('_showMessageHeadUp');
    if (message != null) {
      var isShow = filterMessage(message.data);
      if (!isShow) {
        logger.i('Message not show because filtered');
        return;
      }

      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;

      NotificationDetails? notificationDetails;
      if (Platform.isAndroid && android != null && channel != null) {
        notificationDetails = NotificationDetails(
          android: AndroidNotificationDetails(
            channel?.id ?? '',
            channel?.name ?? '',
            channelShowBadge: true,
            // !!! also set the sound in the channel - For Android 8.0 or newer, this (sound) is tied to the specified channel
            sound: const RawResourceAndroidNotificationSound('default_noti'),
            playSound: true
          ),
        );
      } else if (Platform.isIOS) {
        notificationDetails = const NotificationDetails(
          iOS: IOSNotificationDetails(
            presentBadge: true,
            // badgeNumber: 3,
            presentAlert: true,
            presentSound: true,
            sound: 'default_noti.wav'
          ),
        );
      }
      var title = notification?.title ?? getStringFromLocKey(notification?.titleLocKey, notification?.titleLocArgs);
      var body = notification?.body ?? getStringFromLocKey(notification?.bodyLocKey, notification?.bodyLocArgs);
      flutterLocalNotificationsPlugin?.show(
        notification.hashCode,
        title,
        body,
        notificationDetails,
        payload: jsonEncode(message.data),
      );
    }
  }

  String? getStringFromLocKey(String? locKey, List<String>? locArgs) {
    String? rs;
    if (locKey.isNotNullOrEmpty()) {
      rs = locKey?.tr;

      String replaceCode = Platform.isIOS ? '%@': r'%1$s';
      locArgs?.forEach((arg) {
        rs = rs?.replaceFirst(replaceCode, arg);
      });
    }
    return rs;
  }

  Future<void> _setupMessageListener({
    required FilterMessage filterMessage,
  }) async {
    // On Foreground
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      logger.i('onMessage');
      _logMessage(message);
      _showMessageHeadUpForeground(
          message: message, filterMessage: filterMessage);
    });

    // On Background/Terminated
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  }

  ///
  /// App in Foreground -> this will show message both on the navigation and on the screen as well in
  ///
  Future<void> _enableAlwaysHeadUpMessageIOS() async {
    if (Platform.isIOS) {
      _firebaseMessaging.setForegroundNotificationPresentationOptions(
        alert: true, // Required to display a heads up notification
        badge: true,
        sound: true,
      );
    }
  }

  Future<void> _setupChannelForAndroid() async {
    if (Platform.isAndroid) {
      channel = const AndroidNotificationChannel(
        'high_importance_channel',
        // id string - create also in Android Manifest
        'High Importance Notifications',
        importance: Importance.max,
        sound: RawResourceAndroidNotificationSound('default_noti'),
      );

      await flutterLocalNotificationsPlugin
          ?.resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin>()
          ?.createNotificationChannel(channel!);
    }
  }

  Future<void> setupInteractedMessage(
      {required NotificationPressedCallBack callBack}) async {
    // Get any messages which caused the application to open from a terminated state.
    _firebaseMessaging.getInitialMessage().then((RemoteMessage? message) {
      _logMessage(message);
      _onMessageClick(message, callBack);
    });

    // Also handle any interaction when the app is in the background via a Stream listener
    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      logger.i('onMessageOpenedApp ', message);
      _onMessageClick(message, callBack);
    });
  }

  Future<void> subscribeToTopic(String topicName) async {
    _firebaseMessaging.subscribeToTopic(topicName);
  }

  void _onMessageClick(
      RemoteMessage? message, NotificationPressedCallBack callBack) {
    if (message == null) {
      return;
    }

    logger.i('_onMessageClick ', message);
    callBack.call(message.data);
  }

  void _logMessage(RemoteMessage? message) {
    if (message == null) {
      return;
    }

    logger.i('Tag: FirebaseMessaging \n'
        'getInitialMessage:\n'
        '-- data: ${message.data.toString()}\n'
        '-- messageId: ${message.messageId}\n'
        '-- title: ${message.notification?.title}\n'
        '-- messageType: ${message.messageType}\n'
        '-- notification: ${message.notification}\n'
        '-- notification-body: ${message.notification?.body.toString()}\n'
        '-- from: ${message.from}');
  }

  Future<void> hideAllNotification() async {
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: false,
      badge: false,
      sound: false,
    );
  }

  Future<void> enableAllNotification() async {
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
  }

  void removeToken() {
    _firebaseMessaging.deleteToken();
    _firebaseMessaging.getToken();
  }
}

import 'dart:async';
import 'dart:convert';

import 'package:bot_toast/bot_toast.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:provider/provider.dart';
import 'package:shah_investment/auth_module/auth_models/user_model.dart';
import 'package:shah_investment/auth_module/auth_provider.dart';
import 'package:shah_investment/auth_module/auth_views/phone_number_sign_in.dart';
import 'package:shah_investment/auth_module/auth_views/splash_screen.dart';
import 'package:shah_investment/constants/api_info/common_api_structure.dart';
import 'package:shah_investment/constants/colors.dart';
import 'package:shah_investment/constants/share_pref_keys.dart';
import 'package:shah_investment/constants/share_preference.dart';
import 'package:shah_investment/constants/size_config.dart';
import 'package:shah_investment/feed_module/feed_provider.dart';
import 'package:shah_investment/general_helper.dart';
import 'package:shah_investment/logical_functions/debug_print.dart';
import 'package:shah_investment/notification_setup/platform_options.dart';
import 'package:shah_investment/referral_module/referral_provider.dart';
import 'package:shah_investment/subscription_module/subscription_provider.dart';
import 'package:shah_investment/trades_module/trade_provider.dart';



bool isFlutterLocalNotificationsInitialized = false;
late AndroidNotificationChannel channel;
late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

Future<void> setupFlutterNotifications() async {
  if (isFlutterLocalNotificationsInitialized) {
    return;
  }
  channel = const AndroidNotificationChannel(
    "channelId",
    "channelName", // title
    description: 'This channel is used for important notifications.', // description
    importance: Importance.high,
    playSound: true,
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
  RemoteNotification? notification = message.notification;
  AndroidNotification? android = message.notification?.android;

  if (notification != null && android != null && !kIsWeb) {
    try {
      flutterLocalNotificationsPlugin.show(
        notification.hashCode,
        notification.title,
        notification.body,
        NotificationDetails(
          android: AndroidNotificationDetails(
            channel.id,
            channel.name,
            channelDescription: channel.description,
            icon: '@drawable/transparent_logo',
            color: PickColors.primaryColor,

            channelShowBadge: true,
            importance: Importance.max,
            priority: Priority.high,
            colorized: true,
            enableVibration: true,
            fullScreenIntent: true,
            playSound: true,
            showWhen: false,
            // TODO add a proper drawable resource to android, for now using
            //      one that already exists in example app.
          ),
        ),
      );
    } catch (e) {
      print("============Error While show Notification...${e}");
    }
  }
}

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // if (Firebase.apps.isEmpty) {
  //   await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  // }
  await setupFlutterNotifications();
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // if (Firebase.apps.isEmpty) {
    await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  //}

  FirebaseMessaging messaging = FirebaseMessaging.instance;
  await messaging.requestPermission(
    alert: true,
    announcement: true,
    badge: true,
    provisional: false,
    carPlay: false,
    criticalAlert: false,
    sound: true,
  );

  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  if (!kIsWeb) {
    await setupFlutterNotifications();
  }

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => GeneralHelper()),
      ChangeNotifierProvider(create: (_) => AuthProvider()),
      ChangeNotifierProvider(create: (_) => FeedBackProvider()),
      ChangeNotifierProvider(create: (_) => TradeProvider()),
      ChangeNotifierProvider(create: (_) => ReferralProvider()),
      ChangeNotifierProvider(create: (_) => SubscriptionProvider()),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool isLoading = true;
  Timer? timer;

  @override
  void initState() {
    super.initState();
    getLoginData();
  }

  Future<void> getLoginData() async {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    authProvider.fcmToken = await FirebaseMessaging.instance.getToken();
    printDebug(textString: "============FCM Token.....${authProvider.fcmToken}");

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      showFlutterNotification(message);
    });
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('A new onMessageOpenedApp event was published!');
    });

    await Shared_Preferences.prefGetString(SharedP.keyAuthInformation, "")
        .then((value) async {
      if (value != "") {
        authProvider.currentUserData = UserModel.fromJson(jsonDecode(value));
        ApiManager.setAuthenticationToken(token: authProvider.currentUserData?.token ?? "");
      }

      setState(() {
        isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    return MaterialApp(
      title: 'Flutter Demo',
      builder: BotToastInit(),
      theme: ThemeData(fontFamily: 'Nexa'),
      home: !isLoading
          ? authProvider.currentUserData != null && authProvider.currentUserData?.isActive == 1
              ? const SplashScreen()
              : authProvider.currentUserData?.isActive == 0
                  ? const PhoneNumberSignInScreen()
                  : const SplashScreen()
          : const Scaffold(
              body: Center(
                child: CircularProgressIndicator(
                  color: PickColors.primaryColor,
                ),
              ),
            ),
      debugShowCheckedModeBanner: false,
    );
  }
}

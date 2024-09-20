import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:patient/helper/appcolor.dart';
import 'package:patient/languages/app_localization.dart';
import 'package:patient/languages/custom_delgate.dart';
import 'package:patient/providers/auth_provider/change_password_provider.dart';
import 'package:patient/providers/auth_provider/forgot_verification_provider.dart';
import 'package:patient/providers/auth_provider/update_language_provider.dart';
import 'package:patient/providers/dashboard_provider/bookings_provider.dart';
import 'package:patient/providers/dashboard_provider/dashboard_provider.dart';
import 'package:patient/providers/auth_provider/email_verification_provider.dart';
import 'package:patient/providers/auth_provider/forgot_password_provider.dart';
import 'package:patient/providers/auth_provider/login_provider.dart';
import 'package:patient/providers/dashboard_provider/home_provider.dart';
import 'package:patient/providers/dashboard_provider/notification_provider.dart';
import 'package:patient/providers/dashboard_provider/profile_provider.dart';
import 'package:patient/providers/dashboard_provider/view_booking_provider.dart';
import 'package:patient/providers/dashboard_provider/view_service_provider.dart';
import 'package:patient/providers/localization_provider.dart';
import 'package:patient/providers/onboarding_provider.dart';
import 'package:patient/providers/dashboard_provider/required_question_provider.dart';
import 'package:patient/providers/auth_provider/signup_provider.dart';
import 'package:patient/screens/splash_screen.dart';
import 'package:patient/utils/constants.dart';
import 'package:patient/utils/location_service.dart';
import 'package:patient/utils/notification_service.dart';
import 'package:patient/utils/session_manager.dart';
import 'package:patient/utils/utils.dart';

import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await SessionManager().init();
  FirebaseMessaging.onBackgroundMessage(backgroundHandler);

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  getFCMToken();
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (_) => LocalizationProvider()),
    ChangeNotifierProvider(create: (_) => OnboardingProvider()),
    ChangeNotifierProvider(create: (_) => LoginProvider()),
    ChangeNotifierProvider(create: (_) => SignupProvider()),
    ChangeNotifierProvider(create: (_) => ForgotPasswordProvider()),
    ChangeNotifierProvider(create: (_) => EmailVerificationProvider()),
    ChangeNotifierProvider(create: (_) => ForgotVerificationProvider()),
    ChangeNotifierProvider(create: (_) => ChangePasswordProvider()),
    ChangeNotifierProvider(create: (_) => DashboardProvider()),
    ChangeNotifierProvider(create: (_) => RequiredQuestionProvider()),
    ChangeNotifierProvider(create: (_) => ProfileProvider()),
    ChangeNotifierProvider(create: (_) => BookingsProvier()),
    ChangeNotifierProvider(create: (_) => ViewBookingProvider()),
    ChangeNotifierProvider(create: (_) => HomeProvider()),
    ChangeNotifierProvider(create: (_) => UpdateLanguageProvider()),
    ChangeNotifierProvider(create: (_) => ViewServiceProvider()),
    ChangeNotifierProvider(create: (_) => NotificationProvider()),
  ], child: const MyApp()));
}

Future<void> backgroundHandler(RemoteMessage message) async {
  print('Handling a background message ${message.messageId}');
}

getFCMToken() async {
  FirebaseMessaging.instance.requestPermission();
  FirebaseMessaging.instance.getAPNSToken();
  getLocationPermission();
  FirebaseMessaging.instance.getToken().then((token) async {
    SessionManager.setFcmToken = token!;
  });
}

String selectedLanguage = 'en';

void configLoading() {
  EasyLoading.instance
    ..displayDuration = const Duration(milliseconds: 2000)
    ..indicatorType = EasyLoadingIndicatorType.wave
    ..loadingStyle = EasyLoadingStyle.dark
    ..indicatorSize = 45.0
    ..radius = 10.0
    ..maskColor = Colors.blue.withOpacity(0.5)
    ..userInteractions = true
    ..dismissOnTap = false;
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final NotificationService notificationService = NotificationService();

  @override
  Widget build(BuildContext context) {
    List<Locale> locals = [];
    for (var language in Constants.languages) {
      locals.add(Locale(language.languageCode!, language.countryCode));
    }
    // Provider.of<LocalizationProvider>(context).loadCurrentLanguage();
    print("object${Provider.of<LocalizationProvider>(context).locale}");

    notificationService.initialize();
    return GetMaterialApp(
      navigatorKey: navigatorKey,
      title: 'Pflegeruf Patient',
      fallbackLocale: const Locale('de'),
      locale: Provider.of<LocalizationProvider>(context).locale,
      localizationsDelegates: [
        AppLocalization.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        FallbackLocalizationDelegate()
      ],
      supportedLocales: [
        Locale(Provider.of<LocalizationProvider>(context).locale.languageCode)
      ],
      theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
          scaffoldBackgroundColor: AppColor.whiteColor),
      debugShowCheckedModeBanner: false,
      home: const SplashSCreen(),
      builder: EasyLoading.init(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // TRY THIS: Try changing the color here to a specific color (to
        // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
        // change color while the other colors stay the same.
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          //
          // TRY THIS: Invoke "debug painting" (choose the "Toggle Debug Paint"
          // action in the IDE, or press "p" in the console), to see the
          // wireframe for each widget.
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

import 'package:abdi_dalem_alpha/wrapper.dart';
import 'package:flutter/material.dart';
import 'package:abdi_dalem_alpha/shared/shared.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:workmanager/workmanager.dart';

const simpleTaskKey = "simpleTask";
const simpleDelayedTask = "simpleDelayedTask";
const simplePeriodicTask = "simplePeriodicTask";
const simplePeriodic1HourTask = "simplePeriodic1HourTask";

void callbackDispatcher() {
  Workmanager.executeTask((task, inputData) async {
    switch (task) {
      case simpleTaskKey:
        print("$simpleTaskKey was executed. inputData = $inputData");
        final prefs = await SharedPreferences.getInstance();
        prefs.setBool("test", true);
        print("Bool from prefs: ${prefs.getBool("test")}");
        break;
      case simpleDelayedTask:
        print("$simpleDelayedTask was executed");
        break;
      case simplePeriodicTask:
        print("$simplePeriodicTask was executed");
        break;
      case simplePeriodic1HourTask:
        print("$simplePeriodic1HourTask was executed");
        break;
      case Workmanager.iOSBackgroundTask:
        print("The iOS background fetch was triggered");
        break;
    }

    return Future.value(true);
  });
}

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();

  //FIREBASE
  await Firebase.initializeApp();

  //ONESIGNAL
  OneSignal.shared.setLogLevel(OSLogLevel.verbose, OSLogLevel.none);
  OneSignal.shared.init("f9d24a53-49fe-4905-9ae3-b1e06b6ebc27", iOSSettings: {
    OSiOSSettings.autoPrompt: false,
    OSiOSSettings.inAppLaunchUrl: false
  });
  OneSignal.shared.setInFocusDisplayType(OSNotificationDisplayType.notification);
  await OneSignal.shared.promptUserForPushNotificationPermission(fallbackToSettings: true);

  runApp(AbdiDalemRoot());
}

class AbdiDalemRoot extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<SharedPreferences>(
      future: SharedPreferences.getInstance(),
      builder:
          (BuildContext context, AsyncSnapshot<SharedPreferences> snapshot) {
        return ChangeNotifierProvider<SharedPref>.value(
          value: SharedPref(snapshot.data),
          child: _AbdiDalemMaterialApp(),
        );
      },
    );
  }
}

class _AbdiDalemMaterialApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: [
        const Locale('en', 'US'), // English
        const Locale('th', 'TH'), // Thai
      ],
      title: 'Abdi Dalem',
      debugShowCheckedModeBanner: false,
      theme: Provider.of<SharedPref>(context).isDarkMode
          ? buildDarkTheme(Provider.of<SharedPref>(context).primaryColor)
          : buildLightTheme(Provider.of<SharedPref>(context).primaryColor),
      home: AbdiDalem(title: 'Abdi Dalem'),
    );
  }
}

class AbdiDalem extends StatefulWidget {
  AbdiDalem({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _AbdiDalemRootState createState() => _AbdiDalemRootState();
}

class _AbdiDalemRootState extends State<AbdiDalem> {
  
  @override
  void initState() { 
    super.initState();
    OneSignal.shared.setNotificationReceivedHandler((OSNotification notification) {
    // will be called whenever a notification is received
    });

    OneSignal.shared.setNotificationOpenedHandler((OSNotificationOpenedResult result) {
    // will be called whenever a notification is opened/button pressed.
    });
  }

  @override
  Widget build(BuildContext context) {
    return Wrapper();
  }
}

import 'package:abdi_dalem_alpha/wrapper.dart';
import 'package:flutter/material.dart';
import 'package:abdi_dalem_alpha/shared/shared.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_core/firebase_core.dart';
Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  //Remove this method to stop OneSignal Debugging
  OneSignal.shared.setLogLevel(OSLogLevel.verbose, OSLogLevel.none);

  OneSignal.shared.init("f9d24a53-49fe-4905-9ae3-b1e06b6ebc27", iOSSettings: {
    OSiOSSettings.autoPrompt: false,
    OSiOSSettings.inAppLaunchUrl: false
  });
  OneSignal.shared.setInFocusDisplayType(OSNotificationDisplayType.notification);

// The promptForPushNotificationsWithUserResponse function will show the iOS push notification prompt. We recommend removing the following code and instead using an In-App Message to prompt for notification permission
  await OneSignal.shared
      .promptUserForPushNotificationPermission(fallbackToSettings: true);

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

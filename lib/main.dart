import 'package:abdi_dalem_alpha/wrapper.dart';
import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:abdi_dalem_alpha/shared/shared.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_core/firebase_core.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(DevicePreview(builder: (BuildContext context) {
    return AbdiDalemRoot();
  }));
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
  Widget build(BuildContext context) {
    return Wrapper();
  }

  // Future<Widget> loadAndLaunch() async {
  //   // Do some start up things or let the app just wait:
  //   await Future.delayed(const Duration(seconds: 2), () => "2");

  //   return Get.to(Wrapper());
  // }
}

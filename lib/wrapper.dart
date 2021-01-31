import 'package:abdi_dalem_alpha/services/google_signIn.dart';
import 'package:abdi_dalem_alpha/ui/page/pages.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) => ChangeNotifierProvider(
      create: (context) => GoogleSignInProvider(),
      child: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot){
          final provider = Provider.of<GoogleSignInProvider>(context);
          if (provider.isSigningIn) {
            return buildLoading(context);
          } else if (snapshot.hasData){
            return HomePage();
          } else {
            return Login();
          }
        },
      ));

  Widget buildLoading(context) => Stack(
        fit: StackFit.expand,
        children: [
          // CustomPaint(painter: BackgroundPainter()),
          Scaffold(
            backgroundColor: Theme.of(context).backgroundColor,
            body: SpinKitRotatingCircle(
              color: Theme.of(context).accentColor,
              size: 50.0,
            ),
          ),
        ],
      );
}

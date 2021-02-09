part of "widgets.dart";

Future<dynamic> signUpDialog(BuildContext context) {
  return showDialog(
      context: context,
      builder: (_) => BackdropFilter(
            filter: new ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
            child: new AlertDialog(
              backgroundColor: Theme.of(context).backgroundColor,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(30.0))),
              content: Container(
                alignment: Alignment.center,
                height: MediaQuery.of(context).size.height * 0.5,
                width: MediaQuery.of(context).size.width * 1,
                child: Padding(
                  padding: EdgeInsets.all(
                      MediaQuery.of(context).size.height * 0.001),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                          height: MediaQuery.of(context).size.height * 0.1,
                          decoration: BoxDecoration(
                            image: Theme.of(context).backgroundColor == HexColor("1A1B2F")
                                ? DecorationImage(image: AssetImage("assets/logo_dark.png"))
                                : DecorationImage(image: AssetImage("assets/logo_light.png"))
                          )),
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.02),
                      Center(
                        child: Text(
                          "Lets login or register with these options:",
                          style: GoogleFonts.karla().copyWith(
                              color: Theme.of(context).accentColor,
                              fontSize: 18,
                              fontWeight: FontWeight.w500),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.04),
                      Container(
                        height: MediaQuery.of(context).size.height * 0.06,
                        width: MediaQuery.of(context).size.width * 0.65,
                        child: RaisedButton(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.baseline,
                              children: [
                                Icon(FlutterIcons.google_ant,
                                    color: Theme.of(context).backgroundColor, size: 18),
                                SizedBox(width: 10),
                                Text("Google",
                                    style: GoogleFonts.montserrat().copyWith(
                                        color:
                                            Theme.of(context).backgroundColor,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w700)),
                              ],
                            ),
                            elevation: 0,
                            color: Theme.of(context).accentColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50.0),
                            ),
                            onPressed: () async {
                              final provider = Provider.of<SignInProvider>(
                                  context,
                                  listen: false);
                              provider.signInWithGoogle();
                              Navigator.pop(context);
                            }),
                      ),
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.02),
                      Container(
                        height: MediaQuery.of(context).size.height * 0.06,
                        width: MediaQuery.of(context).size.width * 0.65,
                        child: RaisedButton(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.baseline,
                              children: [
                                Icon(FlutterIcons.facebook_f_faw,
                                    color: Theme.of(context).backgroundColor, size: 18),
                                SizedBox(width: 10),
                                Text("Facebook",
                                    style: GoogleFonts.montserrat().copyWith(
                                        color:
                                            Theme.of(context).backgroundColor,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w700)),
                              ],
                            ),
                            elevation: 0,
                            color: Theme.of(context).accentColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50.0),
                            ),
                            onPressed: () {
                              final provider = Provider.of<SignInProvider>(
                                  context,
                                  listen: false);
                              provider.signInWithFacebook();
                              Navigator.pop(context);
                            }),
                      ),
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.02),
                      Container(
                        height: MediaQuery.of(context).size.height * 0.06,
                        width: MediaQuery.of(context).size.width * 0.65,
                        child: RaisedButton(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.baseline,
                              children: [
                                Icon(FlutterIcons.apple_faw,
                                    color: Theme.of(context).backgroundColor, size: 18),
                                SizedBox(width: 10),
                                Text("Apple",
                                    style: GoogleFonts.montserrat().copyWith(
                                        color:
                                            Theme.of(context).backgroundColor,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w700)),
                              ],
                            ),
                            elevation: 0,
                            color: Theme.of(context).accentColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50.0),
                            ),
                            onPressed: () {
                              Navigator.pop(context);
                            }),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ));
}

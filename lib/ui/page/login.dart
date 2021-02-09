part of 'pages.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    //values
    double paddingVal = MediaQuery.of(context).size.height * 0.05;
    EdgeInsetsGeometry animatedPaddingValue;

    return Scaffold(
      body: Stack(alignment: Alignment.topCenter, children: [
        Container(
          decoration: BoxDecoration(
              image: DecorationImage(
            image: AssetImage("assets/login-background.png"),
            fit: BoxFit.cover,
          )),
        ),
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          top: MediaQuery.of(context).size.height * 0.5625,
          child: (BackdropFilter(
            filter: new ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
            child: Container(
              height: MediaQuery.of(context).size.height * 0.4375,
              decoration: BoxDecoration(
                  gradient: new LinearGradient(
                      colors: [
                        const Color(0xFF000000),
                        const Color(0x18C4C4C4),
                      ],
                      begin: const FractionalOffset(-100.0, 200.0),
                      end: const FractionalOffset(100.0, -200.0),
                      stops: [0.0, 1.0],
                      tileMode: TileMode.clamp),
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(40),
                      topRight: Radius.circular(40))),
              child: Padding(
                padding:
                    EdgeInsets.fromLTRB(paddingVal, paddingVal, 0, paddingVal),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Plan better,', style: t28Dark),
                    SizedBox(
                        height: MediaQuery.of(context).size.height * 0.005),
                    Text('Do greater.', style: t28Dark),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.03),
                    Text(
                        'Use three types of fully-customizable assistant to help you get things done',
                        style: GoogleFonts.karla().copyWith(
                            color: buildDarkTheme('a').accentColor,
                            fontSize: 18,
                            fontWeight: FontWeight.w100)),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.04),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          height: MediaQuery.of(context).size.height * 0.07,
                          width: MediaQuery.of(context).size.width * 0.45,
                          child: RaisedButton(
                            elevation: 0,
                            padding: EdgeInsets.only(
                                left: MediaQuery.of(context).size.width * 0.03),
                            color: Theme.of(context).backgroundColor,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text('Get started',
                                    style: GoogleFonts.montserrat().copyWith(
                                        color: Theme.of(context).accentColor,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w600)),
                                SizedBox(
                                    width: MediaQuery.of(context).size.width *
                                        0.005),
                                Container(
                                    padding: EdgeInsets.only(
                                        right:
                                            MediaQuery.of(context).size.width *
                                                0.02),
                                    alignment: Alignment.centerRight,
                                    height: MediaQuery.of(context).size.height *
                                        0.05,
                                    width:
                                        MediaQuery.of(context).size.width * 0.1,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(50),
                                        color: Theme.of(context).accentColor),
                                    child: ClipRect(
                                      child: AnimatedPadding(
                                        onEnd: () {
                                          print(animatedPaddingValue);
                                        },
                                        duration: Duration(milliseconds: 100),
                                        padding: animatedPaddingValue ??
                                            EdgeInsets.only(left: 0),
                                        child: Align(
                                          alignment: Alignment.centerRight,
                                          child: Icon(
                                              Icons.arrow_right_alt_rounded,
                                              color: Theme.of(context)
                                                  .backgroundColor),
                                        ),
                                      ),
                                    ))
                              ],
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50.0),
                            ),
                            onPressed: () {
                              signUpDialog(context);
                            },
                          ),
                        ),
                        Container(
                          height: MediaQuery.of(context).size.height * 0.07,
                          width: MediaQuery.of(context).size.width * 0.35,
                          child: RaisedButton(
                            elevation: 0,
                            padding: EdgeInsets.only(
                                left: MediaQuery.of(context).size.width * 0.03),
                            color: Theme.of(context)
                                .backgroundColor
                                .withOpacity(0.3),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text('or Try It First',
                                    style: GoogleFonts.montserrat().copyWith(
                                        color: buildDarkTheme('a').accentColor,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w100)),
                              ],
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(50),
                                  bottomLeft: Radius.circular(50)),
                            ),
                            onPressed: () {
                              showDialog(
                                  context: context,
                                  builder: (_) => BackdropFilter(
                                        filter: new ImageFilter.blur(
                                            sigmaX: 10.0, sigmaY: 10.0),
                                        child: new AlertDialog(
                                          backgroundColor:
                                              Theme.of(context).backgroundColor,
                                          shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(30.0))),
                                          content: Container(
                                            alignment: Alignment.center,
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.325,
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                1,
                                            child: Padding(
                                              padding: EdgeInsets.all(
                                                  MediaQuery.of(context)
                                                          .size
                                                          .height *
                                                      0.001),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  Container(
                                                      height:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .height *
                                                              0.1,
                                                      child: Image(
                                                          image: Theme.of(context)
                                                                      .backgroundColor ==
                                                                  HexColor(
                                                                      "1A1B2F")
                                                              ? AssetImage(
                                                                  "assets/logo_dark.png")
                                                              : AssetImage(
                                                                  "assets/logo_light.png"))),
                                                  SizedBox(
                                                      height:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .height *
                                                              0.015),
                                                  Center(
                                                    child: Text(
                                                      "You can try Abdi Dalem features without any registration first. So, let's get started!",
                                                      style: GoogleFonts.karla()
                                                          .copyWith(
                                                              color: Theme.of(
                                                                      context)
                                                                  .accentColor,
                                                              fontSize: 18,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500),
                                                      textAlign:
                                                          TextAlign.center,
                                                    ),
                                                  ),
                                                  SizedBox(
                                                      height:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .height *
                                                              0.03),
                                                  GestureDetector(
                                                    onTap: () async {
                                                      AuthServices
                                                          .signInAnonymously();
                                                      Navigator.pop(context);
                                                    },
                                                    child: Container(
                                                        padding: EdgeInsets.only(
                                                            right:
                                                                MediaQuery.of(context)
                                                                        .size
                                                                        .width *
                                                                    0.02),
                                                        alignment: Alignment
                                                            .centerRight,
                                                        height:
                                                            MediaQuery.of(context)
                                                                    .size
                                                                    .height *
                                                                0.05,
                                                        width: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width *
                                                            0.1,
                                                        decoration: BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius.circular(50),
                                                            color: Theme.of(context).accentColor),
                                                        child: Icon(Icons.arrow_right_alt_rounded, color: Theme.of(context).backgroundColor)),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ));
                            },
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          )),
        )
      ]),
    );
  }
}

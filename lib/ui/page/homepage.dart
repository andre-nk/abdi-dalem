part of 'pages.dart';

enum _Platform { android, ios }

class PlatformEnabledButton extends RaisedButton {
  final _Platform platform;

  PlatformEnabledButton({
    this.platform,
    @required Widget child,
    @required VoidCallback onPressed,
  })  : assert(child != null, onPressed != null),
        super(
            child: child,
            onPressed: (Platform.isAndroid && platform == _Platform.android ||
                    Platform.isIOS && platform == _Platform.ios)
                ? onPressed
                : null);
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool heightSwitch = false;

  @override
  Widget build(BuildContext context) {
    //#AUTH
    final User currentUser = FirebaseAuth.instance.currentUser;
    print(currentUser.uid);

    //Display Values
    TextEditingController userNameController = new TextEditingController();

    Widget tabBar = heightSwitch == false
        ? AnimatedContainer(
            duration: Duration(milliseconds: 200),
            height: MediaQuery.of(context).size.height * 0.06,
            width: MediaQuery.of(context).size.width * 1,
            decoration: BoxDecoration(
                color: Theme.of(context).backgroundColor.withOpacity(0.5),
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(25),
                    bottomRight: Radius.circular(25))))
        : AnimatedContainer(
            duration: Duration(milliseconds: 10),
            height: MediaQuery.of(context).size.height * 0.097,
            width: MediaQuery.of(context).size.width * 1,
            decoration: BoxDecoration(
                color: Theme.of(context).backgroundColor.withOpacity(0.97),
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(0),
                    bottomRight: Radius.circular(0))));

    return StreamProvider<UserData>.value(
      value: DatabaseServices().userData,
      catchError: (_, __) {
        DatabaseServices()
            .users
            .doc(currentUser.uid)
            .set({"name": currentUser.displayName});
        return UserData(name: currentUser.displayName);
      },
      child: Scaffold(
          resizeToAvoidBottomInset: false,
          body: SafeArea(
            child: ListView(children: [
              Stack(
                overflow: Overflow.visible,
                children: [
                  GreetingsDisplayer(),
                  TweenAnimationBuilder(
                    child: Padding(
                      padding: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height * 0.035,
                        left: MediaQuery.of(context).size.width * 0.06,
                        right: MediaQuery.of(context).size.width * 0.06,
                      ),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Hero(
                                tag: "iq",
                                child: Material(
                                  color: Colors.transparent,
                                  type: MaterialType.transparency,
                                  child: GestureDetector(
                                    onTap: () {
                                      Get.to(IQLanding());
                                    },
                                    child: Padding(
                                      padding: EdgeInsets.only(
                                          top: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.25),
                                      child: Container(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.3,
                                        decoration: BoxDecoration(
                                          boxShadow: [
                                            BoxShadow(
                                              color: HexColor("08A4BD")
                                                  .withOpacity(0.2),
                                              blurRadius: 10,
                                            )
                                          ],
                                        ),
                                        child: Image(
                                            fit: BoxFit.fill,
                                            height: double.infinity,
                                            image: AssetImage("assets/IQ.png")),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                    top: MediaQuery.of(context).size.height *
                                        0.15),
                                child: Container(
                                  height:
                                      MediaQuery.of(context).size.height * 0.3,
                                  decoration: BoxDecoration(
                                    boxShadow: [
                                      BoxShadow(
                                        color:
                                            HexColor("01D8A1").withOpacity(0.2),
                                        blurRadius: 10,
                                      )
                                    ],
                                  ),
                                  child: Image(
                                      fit: BoxFit.fill,
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.3,
                                      image: AssetImage("assets/EQ.png")),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                    top: MediaQuery.of(context).size.height *
                                        0.05),
                                child: Container(
                                  height:
                                      MediaQuery.of(context).size.height * 0.3,
                                  decoration: BoxDecoration(
                                    boxShadow: [
                                      BoxShadow(
                                        color:
                                            HexColor("D7263D").withOpacity(0.3),
                                        blurRadius: 20,
                                      )
                                    ],
                                  ),
                                  child: Image(
                                      fit: BoxFit.fill,
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.3,
                                      image: AssetImage("assets/SQ.png")),
                                ),
                              )
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: <Widget>[
                                Text("Plugin initialization",
                                    style:
                                        Theme.of(context).textTheme.headline5),
                                RaisedButton(
                                    child: Text(
                                        "Start the Flutter background service"),
                                    onPressed: () {
                                      Workmanager.initialize(
                                        callbackDispatcher,
                                        isInDebugMode: true,
                                      );
                                    }),
                                SizedBox(height: 16),
                                Text("One Off Tasks (Android only)",
                                    style:
                                        Theme.of(context).textTheme.headline5),
                                //This task runs once.
                                //Most likely this will trigger immediately
                                PlatformEnabledButton(
                                    platform: _Platform.android,
                                    child: Text("Register OneOff Task"),
                                    onPressed: () {
                                      Workmanager.registerOneOffTask(
                                        "1",
                                        simpleTaskKey,
                                        inputData: <String, dynamic>{
                                          'int': 1,
                                          'bool': true,
                                          'double': 1.0,
                                          'string': 'string',
                                          'array': [1, 2, 3],
                                        },
                                      );
                                    }),
                                //This task runs once
                                //This wait at least 10 seconds before running
                                PlatformEnabledButton(
                                    platform: _Platform.android,
                                    child: Text("Register Delayed OneOff Task"),
                                    onPressed: () {
                                      Workmanager.registerOneOffTask(
                                        "2",
                                        simpleDelayedTask,
                                        initialDelay: Duration(seconds: 10),
                                      );
                                    }),
                                SizedBox(height: 8),
                                Text("Periodic Tasks (Android only)",
                                    style:
                                        Theme.of(context).textTheme.headline5),
                                //This task runs periodically
                                //It will wait at least 10 seconds before its first launch
                                //Since we have not provided a frequency it will be the default 15 minutes
                                PlatformEnabledButton(
                                    platform: _Platform.android,
                                    child: Text("Register Periodic Task"),
                                    onPressed: () {
                                      Workmanager.registerPeriodicTask(
                                        "3",
                                        simplePeriodicTask,
                                        initialDelay: Duration(seconds: 10),
                                      );
                                    }),
                                //This task runs periodically
                                //It will run about every hour
                                PlatformEnabledButton(
                                    platform: _Platform.android,
                                    child:
                                        Text("Register 1 hour Periodic Task"),
                                    onPressed: () {
                                      Workmanager.registerPeriodicTask(
                                        "5",
                                        simplePeriodic1HourTask,
                                        frequency: Duration(hours: 1),
                                      );
                                    }),
                                PlatformEnabledButton(
                                  platform: _Platform.android,
                                  child: Text("Cancel All"),
                                  onPressed: () async {
                                    await Workmanager.cancelAll();
                                    print('Cancel all tasks completed');
                                  },
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    duration: Duration(milliseconds: 700),
                    tween: Tween<double>(begin: 0.2, end: 1),
                    builder: (BuildContext context, double _val, Widget child) {
                      return Opacity(
                          opacity: _val,
                          child: Padding(
                              padding: EdgeInsets.only(
                                  top: MediaQuery.of(context).size.height *
                                      (_val + 0.025) /
                                      10),
                              child: child));
                    },
                  ),
                  tabBar,
                  DraggableTopBar(
                    onExpansionChanged: (val) {
                      if (val) {
                        setState(() {
                          heightSwitch = true;
                        });
                      } else {
                        setState(() {
                          heightSwitch = false;
                        });
                      }
                    },
                    tilePadding: EdgeInsets.all(0),
                    title: Padding(
                      padding: EdgeInsets.only(
                          top: MediaQuery.of(context).size.height * 0.02),
                      child: CircleAvatar(
                          radius: MediaQuery.of(context).size.height * 0.03,
                          child: ClipOval(
                              child: currentUser.photoURL != null
                                  ? Image(
                                      image: NetworkImage(
                                          currentUser.photoURL ?? ""))
                                  : Image(
                                      image: AssetImage(
                                          "assets/guest_avatar.png")))),
                    ),
                    children: [
                      Column(
                        children: [
                          Container(
                              height: MediaQuery.of(context).size.height * 0.7,
                              width: MediaQuery.of(context).size.width * 1,
                              decoration: BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                        color: Theme.of(context)
                                            .primaryColor
                                            .withOpacity(0.3),
                                        blurRadius: 40,
                                        offset: Offset(0, 4))
                                  ],
                                  color: Theme.of(context)
                                      .backgroundColor
                                      .withOpacity(0.97),
                                  borderRadius: BorderRadius.only(
                                      bottomLeft: Radius.circular(25),
                                      bottomRight: Radius.circular(25))),
                              child: Padding(
                                padding: EdgeInsets.all(
                                    MediaQuery.of(context).size.height * 0.025),
                                child: SingleChildScrollView(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      GestureDetector(
                                          onTap: () {
                                            currentUser.isAnonymous
                                                ? signUpDialog(context)
                                                : showDialog(
                                                    context: context,
                                                    builder: (_) =>
                                                        BackdropFilter(
                                                            filter: ImageFilter
                                                                .blur(
                                                                    sigmaX: 0.5,
                                                                    sigmaY:
                                                                        0.5),
                                                            child: AlertDialog(
                                                                backgroundColor:
                                                                    Theme.of(
                                                                            context)
                                                                        .backgroundColor,
                                                                shape:
                                                                    RoundedRectangleBorder(
                                                                  borderRadius:
                                                                      BorderRadius.all(
                                                                          Radius.circular(
                                                                              30.0)),
                                                                ),
                                                                content:
                                                                    Container(
                                                                        alignment:
                                                                            Alignment
                                                                                .center,
                                                                        height: MediaQuery.of(context).size.height *
                                                                            0.4,
                                                                        width:
                                                                            MediaQuery.of(context).size.width *
                                                                                1,
                                                                        child:
                                                                            Column(
                                                                          mainAxisAlignment:
                                                                              MainAxisAlignment.spaceEvenly,
                                                                          children: [
                                                                            Text("Please enter the display name you desired",
                                                                                textAlign: TextAlign.center,
                                                                                style: GoogleFonts.karla().copyWith(color: Theme.of(context).accentColor, fontSize: 18, fontWeight: FontWeight.w500)),
                                                                            SizedBox(height: MediaQuery.of(context).size.height * 0.035),
                                                                            TextField(
                                                                                controller: userNameController,
                                                                                decoration: new InputDecoration(
                                                                                    contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                                                                                    border: new OutlineInputBorder(
                                                                                      borderSide: BorderSide(color: Theme.of(context).primaryColor),
                                                                                      borderRadius: const BorderRadius.all(
                                                                                        const Radius.circular(50.0),
                                                                                      ),
                                                                                    ),
                                                                                    filled: true,
                                                                                    hintStyle: GoogleFonts.montserrat().copyWith(color: Theme.of(context).accentColor, fontSize: 16, fontWeight: FontWeight.w500),
                                                                                    hintText: "Type in your text",
                                                                                    fillColor: Theme.of(context).backgroundColor)),
                                                                            SizedBox(height: MediaQuery.of(context).size.height * 0.035),
                                                                            Container(
                                                                              width: MediaQuery.of(context).size.width * 0.4,
                                                                              height: MediaQuery.of(context).size.height * 0.065,
                                                                              child: RaisedButton(
                                                                                child: Text("Confirm", textAlign: TextAlign.center, style: GoogleFonts.montserrat().copyWith(color: Theme.of(context).accentColor, fontSize: 18, fontWeight: FontWeight.w500)),
                                                                                color: Theme.of(context).primaryColor,
                                                                                elevation: 0,
                                                                                onPressed: () {
                                                                                  DatabaseServices().updateUserData(userNameController.text);
                                                                                  Navigator.pop(context);
                                                                                },
                                                                                shape: RoundedRectangleBorder(
                                                                                  borderRadius: BorderRadius.circular(18.0),
                                                                                ),
                                                                              ),
                                                                            )
                                                                          ],
                                                                        )))));
                                          },
                                          child: SettingsWidget(
                                              name: "Your display name")),
                                      SizedBox(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.035),
                                      SettingsWidget(
                                          name: "Your e-mail",
                                          value: currentUser.email ??
                                              currentUser.uid,
                                          method: null),
                                      SizedBox(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.035),
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text("Theme Color",
                                              style: GoogleFonts.karla()
                                                  .copyWith(
                                                      color: Theme.of(context)
                                                          .accentColor,
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.w500)),
                                          SizedBox(
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.005),
                                          Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: <Widget>[
                                              Container(
                                                child: IconButton(
                                                  color: HexColor("08A4BD"),
                                                  icon: Icon(Icons.circle),
                                                  onPressed: () {
                                                    changePrimaryColor(
                                                        "08A4BD", context);
                                                  },
                                                ),
                                              ),
                                              IconButton(
                                                color: HexColor("D7263D"),
                                                icon: Icon(Icons.circle),
                                                onPressed: () {
                                                  changePrimaryColor(
                                                      "D7263D", context);
                                                },
                                              ),
                                              IconButton(
                                                color: HexColor("01D8A1"),
                                                icon: Icon(Icons.circle),
                                                onPressed: () {
                                                  changePrimaryColor(
                                                      "01D8A1", context);
                                                },
                                              ),
                                              IconButton(
                                                color: HexColor("573280"),
                                                icon: Icon(Icons.circle),
                                                onPressed: () {
                                                  changePrimaryColor(
                                                      "573280", context);
                                                },
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.020),
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text("Theme Mode",
                                              style: GoogleFonts.karla()
                                                  .copyWith(
                                                      color: Theme.of(context)
                                                          .accentColor,
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.w500)),
                                          SizedBox(
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.005),
                                          Row(
                                            children: [
                                              IconButton(
                                                color: Theme.of(context)
                                                    .accentColor,
                                                icon: Icon(
                                                    Provider.of<SharedPref>(
                                                                context)
                                                            .isDarkMode
                                                        ? FlutterIcons.moon_fea
                                                        : Icons.brightness_low),
                                                onPressed: () {
                                                  changeTheme(
                                                      Provider.of<SharedPref>(
                                                                  context,
                                                                  listen: false)
                                                              .isDarkMode
                                                          ? false
                                                          : true,
                                                      context);
                                                },
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                      SizedBox(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.025),
                                      RaisedButton(
                                        elevation: 0,
                                        color: Theme.of(context)
                                            .backgroundColor
                                            .withOpacity(0),
                                        padding: EdgeInsets.all(0),
                                        onPressed: () async {
                                          if (currentUser.isAnonymous) {
                                            await AuthServices
                                                .signOutAnonymously();
                                          } else {
                                            final provider =
                                                Provider.of<SignInProvider>(
                                                    context,
                                                    listen: false);
                                            provider.signOutWithGoogle();
                                          }
                                        },
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text("Log out",
                                                style: GoogleFonts.montserrat()
                                                    .copyWith(
                                                  color: Theme.of(context)
                                                      .accentColor,
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.w700,
                                                )),
                                            Icon(
                                              FlutterIcons.log_out_fea,
                                              color: Colors.red,
                                            )
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              )),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.06,
                          )
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ]),
          )),
    );
  }

  void changeTheme(bool set, BuildContext context) {
    ///Call setDarkMode method inside our Settings ChangeNotifier class to
    ///Notify all the listeners of the change.
    Provider.of<SharedPref>(context, listen: false).setDarkMode(set);
  }

  void changePrimaryColor(String val, BuildContext context) {
    Provider.of<SharedPref>(context, listen: false).setPrimaryColor(val);
  }
}

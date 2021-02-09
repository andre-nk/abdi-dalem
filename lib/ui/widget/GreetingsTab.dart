part of "widgets.dart";

class GreetingsDisplayer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final int time = new DateTime.now().hour;
    final userData = Provider.of<UserData>(context) ?? UserData(name: "");

    if (time > 5 && time < 12) {
      return Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/home-tab.png"), fit: BoxFit.fill)),
          height: MediaQuery.of(context).size.height * 0.35,
          width: MediaQuery.of(context).size.width * 1,
          child: TweenAnimationBuilder(
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
            child: Padding(
              padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).size.height * 0.07),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('good morning,',
                      style: GoogleFonts.montserrat().copyWith(
                        color: buildDarkTheme('a').accentColor,
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      )),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.005),
                  // nickNameDisplayer()
                  Text(
                      userData.name.length >= 15
                          ? userData.name.substring(0, 15) + "..."
                          : userData.name,
                      style: GoogleFonts.montserrat().copyWith(
                          color: HexColor("FAFAFA"),
                          fontSize: 32,
                          fontWeight: FontWeight.w700))
                ],
              ),
            ),
          ));
    } else if (time >= 12 && time < 18) {
      return Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/home-tab-noon.png"),
                  fit: BoxFit.fill)),
          height: MediaQuery.of(context).size.height * 0.35,
          width: MediaQuery.of(context).size.width * 1,
          child: TweenAnimationBuilder(
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
            child: Padding(
              padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).size.height * 0.07),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('good afternoon,',
                      style: GoogleFonts.montserrat().copyWith(
                        color: buildDarkTheme('a').accentColor,
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      )),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.005),
                  Text(
                      userData.name.length >= 15
                          ? userData.name.substring(0, 15) + "..."
                          : userData.name,
                      style: GoogleFonts.montserrat().copyWith(
                          color: HexColor("FAFAFA"),
                          fontSize: 32,
                          fontWeight: FontWeight.w700))
                ],
              ),
            ),
          ));
    } else if (time >= 18 && time <= 24) {
      return Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/home-tab-night.png"),
                  fit: BoxFit.fill)),
          height: MediaQuery.of(context).size.height * 0.35,
          width: MediaQuery.of(context).size.width * 1,
          child: TweenAnimationBuilder(
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
            child: Padding(
              padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).size.height * 0.07),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('good evening,',
                      style: GoogleFonts.montserrat().copyWith(
                        color: buildDarkTheme('a').accentColor,
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      )),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.005),
                  Text(
                      userData.name.length >= 15
                          ? userData.name.substring(0, 15) + "..."
                          : userData.name,
                      style: GoogleFonts.montserrat().copyWith(
                          color: HexColor("FAFAFA"),
                          fontSize: 32,
                          fontWeight: FontWeight.w700))
                ],
              ),
            ),
          ));
    } else {
      return Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/home-tab-night.png"),
                  fit: BoxFit.fill)),
          height: MediaQuery.of(context).size.height * 0.35,
          width: MediaQuery.of(context).size.width * 1,
          child: Padding(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).size.height * 0.07),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('good evening,',
                    style: GoogleFonts.montserrat().copyWith(
                      color: buildDarkTheme('a').accentColor,
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    )),
                SizedBox(height: MediaQuery.of(context).size.height * 0.005),
                Text(
                    userData.name.length >= 15
                        ? userData.name.substring(0, 15) + "..."
                        : userData.name,
                    style: GoogleFonts.montserrat().copyWith(
                        color: HexColor("FAFAFA"),
                        fontSize: 32,
                        fontWeight: FontWeight.w700))
              ],
            ),
          ));
    }
  }
}

class ToolDisplayer extends StatelessWidget {
  final String heroTag;
  final String photoURL;

  ToolDisplayer({this.heroTag, this.photoURL});

  @override
  Widget build(BuildContext context) {
    return Hero(
        tag: this.heroTag,
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(25),
                  bottomRight: Radius.circular(25)),
              image: DecorationImage(
                  image: AssetImage(this.photoURL), fit: BoxFit.fill)),
          height: MediaQuery.of(context).size.height * 0.35,
          width: MediaQuery.of(context).size.width * 1,
          child: Padding(
            padding: EdgeInsets.only(bottom: MediaQuery.of(context).size.height * 0),
              child: Column(
                children: [
                  SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                          icon: Icon(FlutterIcons.ios_arrow_back_ion,
                              color: HexColor("FAFAFA")),
                          onPressed: () {
                            Get.back();
                          }),
                      IconButton(
                          icon: Icon(FlutterIcons.setting_ant,
                              color: HexColor("FAFAFA")),
                          onPressed: () {
                            Get.back();
                          }),
                    ],
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.03),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('IQ assistant,',
                          style: GoogleFonts.montserrat().copyWith(
                            color: buildDarkTheme('a').accentColor,
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                          )),
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.005),
                      Text("Bunaken",
                          style: GoogleFonts.montserrat().copyWith(
                              color: HexColor("FAFAFA"),
                              fontSize: 32,
                              fontWeight: FontWeight.w700)),
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.005),
                      Text('at your service',
                          style: GoogleFonts.montserrat().copyWith(
                            color: buildDarkTheme('a').accentColor,
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                          )),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
  }
}

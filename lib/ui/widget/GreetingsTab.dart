part of "widgets.dart";

Widget greetingsDisplayer(
    {BuildContext context,
    User currentUser,
    bool isGuest,
    DocumentReference users}) {
  final int time = new DateTime.now().hour;

  Widget nickNameDisplayer() {
    if (isGuest == true) {
      return Text(currentUser.uid.substring(1, 15) + "!" ?? "",
          style: GoogleFonts.montserrat().copyWith(
            color: buildDarkTheme('a').accentColor,
            fontSize: 32,
            fontWeight: FontWeight.bold,
          ));
    } else {
      return StreamBuilder<DocumentSnapshot>(
          stream: users.snapshots(),
          builder: (_, snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data.get("name") == null) {
                return Text(
                    currentUser.displayName.length >= 15
                        ? currentUser.displayName.substring(0, 15) + "..."
                        : currentUser.displayName,
                    style: GoogleFonts.montserrat().copyWith(
                        color: Theme.of(context).accentColor,
                        fontSize: 32,
                        fontWeight: FontWeight.w700));
              } else {
                return Text(
                    snapshot.data.get("name").length >= 15
                        ? snapshot.data.get("name").substring(0, 15) + "..."
                        : snapshot.data.get("name") ?? "",
                    style: GoogleFonts.montserrat().copyWith(
                      color: Theme.of(context).accentColor,
                      fontSize: 32,
                      fontWeight: FontWeight.w700,
                    ));
              }
            } else {
              SpinKitRotatingCircle(
                color: Theme.of(context).accentColor,
                size: 50.0,
              );
            }
          });
    }
  }

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
                nickNameDisplayer()
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
                nickNameDisplayer()
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
                nickNameDisplayer()
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
              nickNameDisplayer()
            ],
          ),
        ));
  }
}

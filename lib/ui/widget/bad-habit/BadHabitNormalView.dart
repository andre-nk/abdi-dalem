part of "../widgets.dart";

class BadHabitNormalView extends StatefulWidget {
  @override
  _BadHabitNormalViewState createState() => _BadHabitNormalViewState();
}

class _BadHabitNormalViewState extends State<BadHabitNormalView> {
  DateTime now = DateTime.now();

  void failedPopUpCaller(int limit, int currentCount) {
    if (limit == currentCount) {
      showDialog(
        context: context,
        builder: (_) => BackdropFilter(
          filter: new ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
            child: new AlertDialog(
              backgroundColor: Theme.of(context).backgroundColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(30.0))),
                  content: Container(
                    alignment: Alignment.center,
                    height: MediaQuery.of(context).size.height * 0.325,
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
                            child: Image(
                                image: Theme.of(context).backgroundColor == HexColor("1A1B2F")
                                  ? AssetImage("assets/logo_dark.png")
                                  : AssetImage("assets/logo_light.png"))),
                          SizedBox(
                              height: MediaQuery.of(context).size.height * 0.015),
                          Center(
                            child: Text(
                              "Oh no!",
                              style: GoogleFonts.montserrat().copyWith(
                                  color: Theme.of(context).accentColor,
                                  fontSize: 24,
                                  fontWeight: FontWeight.w700),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          SizedBox(
                              height:
                                  MediaQuery.of(context).size.height * 0.03),
                           Center(
                            child: Text(
                              "You've done many bad habits today. Let's fix it tomorrow!",
                              style: GoogleFonts.karla().copyWith(
                                  color: Theme.of(context).accentColor,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ));
    } else {

    }
  }

  @override
  Widget build(BuildContext context) {
    List<BadHabitObject> badHabitList =
        Provider.of<List<BadHabitObject>>(context) ?? [];
    List<BadHabitObject> normalBadHabitList = [];

    badHabitList.forEach((object) {
      if (object.isProtected != true) {
        normalBadHabitList.add(object);
      }
    });

    DateTime nextCheckIn = DateTime(now.year, now.month, now.day + 1);
    Provider.of<SharedPref>(context, listen: false)
        .setNextCheckIn(nextCheckIn.toString());
    BadHabitServices().resetBadHabitCount(DateFormat("yyyy-MM-dd")
        .parse(Provider.of<SharedPref>(context, listen: false).nextCheckIn));

    return ListView(physics: BouncingScrollPhysics(), children: [
      Container(
          padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.05),
          height: MediaQuery.of(context).size.height * 0.85,
          child: ListView.builder(
            physics: BouncingScrollPhysics(),
            scrollDirection: Axis.vertical,
            itemExtent: MediaQuery.of(context).size.height * 0.425,
            itemCount: normalBadHabitList.length ?? 0,
            itemBuilder: (BuildContext context, index) {
              return GestureDetector(
                onLongPress: (){
                  showDialog(
                    context: context,
                    builder: (_) => BackdropFilter(
                      filter: new ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                      child: new AlertDialog(
                        backgroundColor: Theme.of(context).backgroundColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(30.0))),
                        content: Container(
                          alignment: Alignment.center,
                          height: MediaQuery.of(context).size.height * 0.35,
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
                                  child: Image(
                                      image: Theme.of(context).backgroundColor == HexColor("1A1B2F")
                                        ? AssetImage("assets/logo_dark.png")
                                        : AssetImage("assets/logo_light.png"))),
                                SizedBox(
                                    height: MediaQuery.of(context).size.height * 0.015),
                                Center(
                                  child: Text(
                                    "Are you sure you want to delete this habit?",
                                    style: GoogleFonts.montserrat().copyWith(
                                        color: Theme.of(context).accentColor,
                                        fontSize: 22,
                                        fontWeight: FontWeight.w700),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                SizedBox(
                                    height:
                                        MediaQuery.of(context).size.height * 0.03),
                                Center(
                                  child: Text(
                                    "This action is irreversible!",
                                    style: GoogleFonts.karla().copyWith(
                                      color: Theme.of(context).accentColor,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                SizedBox(
                                  height: MediaQuery.of(context).size.height * 0.03),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  children: [
                                    DefaultButton(
                                      color: HexColor("C4C4C4 ").withOpacity(0.3),
                                      title: "Cancel",
                                      method: (){
                                        Navigator.pop(context);
                                      }
                                    ),
                                    DefaultButton(
                                      color: Colors.red,
                                      title: "Delete",
                                      method: (){
                                        BadHabitServices().deleteBadHabitRecord(normalBadHabitList[index].uid);
                                        Navigator.pop(context);
                                      }
                                    )
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    )
                  );
                },
                child: Container(
                  padding: EdgeInsets.only(
                      bottom: MediaQuery.of(context).size.height * 0.03),
                  width: MediaQuery.of(context).size.width * 0.8,
                  margin: EdgeInsets.symmetric(
                      horizontal: MediaQuery.of(context).size.width * 0.035,
                      vertical: MediaQuery.of(context).size.width * 0.04),
                  decoration: BoxDecoration(
                    color: Theme.of(context).backgroundColor,
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    boxShadow: [
                      BoxShadow(
                        color: Theme.of(context).primaryColor.withOpacity(0.2),
                        blurRadius: 15,
                        spreadRadius: 1,
                      )
                    ],
                  ),
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.all(
                            MediaQuery.of(context).size.height * 0.035),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(normalBadHabitList[index].title, //habit name
                                    style: GoogleFonts.montserrat().copyWith(
                                        color: Theme.of(context).accentColor,
                                        fontSize: 18,
                                        letterSpacing: 1,
                                        fontWeight: FontWeight.w700)),
                                GestureDetector(
                                    onTap: () {
                                      showModalBottomSheet(
                                          backgroundColor: Colors.transparent,
                                          isScrollControlled: true,
                                          context: context,
                                          builder: (BuildContext context) {
                                            return Padding(
                                              padding: EdgeInsets.only(
                                                  bottom: MediaQuery.of(context)
                                                      .viewInsets
                                                      .bottom),
                                              child: BadHabitPreviewer(
                                                title: normalBadHabitList[index]
                                                    .title,
                                                subtitle:
                                                    normalBadHabitList[index]
                                                        .subtitle,
                                                limit: normalBadHabitList[index]
                                                    .limit,
                                                currentCount:
                                                    normalBadHabitList[index]
                                                        .currentCount,
                                                uid:
                                                    normalBadHabitList[index].uid,
                                              ),
                                            );
                                          }); //edit bottomsheet
                                    },
                                    child: Icon(FlutterIcons.mode_edit_mdi,
                                        size: 24))
                              ],
                            ), //TBA FB Tags Title
                            SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.01),
                            normalBadHabitList[index].subtitle != ""
                                ? Text(
                                    normalBadHabitList[index]
                                        .subtitle, //habit name
                                    style: GoogleFonts.karla().copyWith(
                                        color: Theme.of(context).accentColor,
                                        fontSize: 16,
                                        height: 1.5,
                                        fontWeight: FontWeight.w400))
                                : SizedBox(),
                            SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.035),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.525,
                                  child: LinearProgressIndicator(
                                    minHeight:
                                        MediaQuery.of(context).size.height * 0.01,
                                    value:
                                        (normalBadHabitList[index].currentCount /
                                                normalBadHabitList[index].limit) *
                                            100,
                                    backgroundColor: Theme.of(context)
                                        .accentColor
                                        .withOpacity(0.6),
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                        Theme.of(context).primaryColor),
                                  ),
                                ),
                                Text(
                                    "${normalBadHabitList[index].currentCount} / ${normalBadHabitList[index].limit}", //habit name
                                    style: GoogleFonts.montserrat().copyWith(
                                        color: Theme.of(context).accentColor,
                                        fontSize: 16,
                                        letterSpacing: 1,
                                        fontWeight: FontWeight.w500)),
                              ],
                            ),
                            SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.035),
                            Container(
                              width: MediaQuery.of(context).size.width * 0.8,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Container(
                                    width:
                                        MediaQuery.of(context).size.width * 0.3,
                                    height: MediaQuery.of(context).size.height *
                                        0.055,
                                    child: DefaultButton(
                                        color: Theme.of(context).primaryColor,
                                        title: "Check",
                                        method: () {
                                          BadHabitServices().updateBadHabitRecord(
                                            normalBadHabitList[index].uid,
                                            normalBadHabitList[index].isProtected,
                                            currentCount:
                                                normalBadHabitList[index]
                                                            .currentCount ==
                                                        normalBadHabitList[index]
                                                            .limit
                                                    ? normalBadHabitList[index]
                                                        .currentCount
                                                    : normalBadHabitList[index]
                                                            .currentCount +
                                                        1,
                                            title:
                                                normalBadHabitList[index].title,
                                            subtitle: normalBadHabitList[index]
                                                .subtitle,
                                            limit:
                                                normalBadHabitList[index].limit,
                                          );
                                          failedPopUpCaller(normalBadHabitList[index].limit, normalBadHabitList[index].currentCount);
                                        }),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ))
    ]);
  }
}

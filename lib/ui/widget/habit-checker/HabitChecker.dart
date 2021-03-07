part of "../widgets.dart";

class HabitChecker extends StatefulWidget {
  HabitChecker({Key key}) : super(key: key);

  @override
  _HabitCheckerState createState() => _HabitCheckerState();
}

class _HabitCheckerState extends State<HabitChecker> {
  bool sampleValue = false;

  @override
  Widget build(BuildContext context) {
    return ListView(physics: BouncingScrollPhysics(), children: [
      Container(
          padding: EdgeInsets.symmetric(
              vertical: MediaQuery.of(context).size.width * 0.05,
              horizontal: MediaQuery.of(context).size.width * 0.05),
          height: MediaQuery.of(context).size.height * 0.85,
          child: ListView.builder(
              physics: BouncingScrollPhysics(),
              scrollDirection: Axis.vertical,
              itemExtent: MediaQuery.of(context).size.height * 0.46,
              itemCount: 5,
              itemBuilder: (BuildContext context, index) {
                return Container(
                    padding: EdgeInsets.all(
                        MediaQuery.of(context).size.height * 0.035),
                    width: MediaQuery.of(context).size.width * 0.8,
                    margin: EdgeInsets.symmetric(
                        horizontal: MediaQuery.of(context).size.width * 0.035,
                        vertical: MediaQuery.of(context).size.width * 0.04),
                    decoration: BoxDecoration(
                      color: Theme.of(context).backgroundColor,
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      boxShadow: [
                        BoxShadow(
                          color:
                              Theme.of(context).primaryColor.withOpacity(0.2),
                          blurRadius: 15,
                          spreadRadius: 1,
                        )
                      ],
                    ),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text("abc", //habit name
                                  style: GoogleFonts.montserrat().copyWith(
                                      color: Theme.of(context).accentColor,
                                      fontSize: 24,
                                      letterSpacing: 1,
                                      fontWeight: FontWeight.w700)),
                              GestureDetector(
                                  onTap: () {
                                    // showModalBottomSheet(
                                    //     backgroundColor: Colors.transparent,
                                    //     isScrollControlled: true,
                                    //     context: context,
                                    //     builder: (BuildContext context) {
                                    //       return Padding(
                                    //         padding: EdgeInsets.only(
                                    //             bottom: MediaQuery.of(context)
                                    //                 .viewInsets
                                    //                 .bottom),
                                    //         child: BadHabitPreviewer(
                                    //           title: normalBadHabitList[index]
                                    //               .title,
                                    //           subtitle:
                                    //               normalBadHabitList[index]
                                    //                   .subtitle,
                                    //           limit: normalBadHabitList[index]
                                    //               .limit,
                                    //           currentCount:
                                    //               normalBadHabitList[index]
                                    //                   .currentCount,
                                    //           uid:
                                    //               normalBadHabitList[index].uid,
                                    //         ),
                                    //       );
                                    //     }); //edit bottomsheet
                                  },
                                  child: Icon(FlutterIcons.mode_edit_mdi,
                                      size: 24))
                            ],
                          ),
                          SizedBox(
                              height:
                                  MediaQuery.of(context).size.height * 0.02),
                          Text("abc", //habit name
                              style: GoogleFonts.karla().copyWith(
                                  color: Theme.of(context).accentColor,
                                  fontSize: 16,
                                  height: 1.5,
                                  fontWeight: FontWeight.w400)),
                          SizedBox(
                              height:
                                  MediaQuery.of(context).size.height * 0.05),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Reminder", //habit name
                                      style: GoogleFonts.montserrat().copyWith(
                                          color: Theme.of(context).accentColor,
                                          fontSize: 18,
                                          letterSpacing: 1,
                                          fontWeight: FontWeight.w700)),
                                  SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.005),
                                  Text("at 14:00", //habit name
                                      style: GoogleFonts.karla().copyWith(
                                          color: Theme.of(context).accentColor,
                                          fontSize: 16,
                                          height: 1.5,
                                          fontWeight: FontWeight.w400)),
                                ],
                              ),
                              Switch(
                                value: sampleValue, //demo
                                onChanged: (_) {
                                  setState(() {
                                    sampleValue = !sampleValue;
                                  });
                                },
                                activeColor: Theme.of(context).primaryColor,
                              )
                            ],
                          ),
                          SizedBox(
                              height:
                                  MediaQuery.of(context).size.height * 0.05),
                          DefaultButton(
                              title: "Check",
                              method: () {},
                              color: Theme.of(context).primaryColor)
                        ]));
              }))
    ]);
  }
}

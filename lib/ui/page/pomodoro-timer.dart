part of "pages.dart";

class PomodoroTimer extends StatefulWidget {
  @override
  _PomodoroTimerState createState() => _PomodoroTimerState();
}

class _PomodoroTimerState extends State<PomodoroTimer> {
  CountDownController _countDownController = CountDownController();
  CountDownController _countDownControllerBreak = CountDownController();
  TextEditingController sessionNameController = TextEditingController();
  DateFormat formatterHour = DateFormat('Hm');
  DateFormat formatterSeconds = DateFormat("s");
  String sessionName, status = "pending";
  List<String> timeStamps = [];
  List<String> timeStampsSecond = [];
  List<int> timeStampsCalculated = [];
  bool resultPage = false;
  bool breakTime = false;
  bool firebaseSubmitted = false;
 
  @override
  Widget build(BuildContext context) {
    Widget statusButton() {
      print(status);
      return status == "pending"
          ? DefaultButton(
              color: Theme.of(context).primaryColor,
              title: "Start",
              method: () {
                Provider.of<SharedPref>(context, listen: false)
                    .setTimestamp([]);
                Vibration.vibrate(duration: 100, amplitude: 200);
                timeStamps.add(formatterHour.format(DateTime.now()));
                timeStampsSecond.add(formatterSeconds.format(DateTime.now()));
                print(timeStamps);
                print(timeStampsSecond);
                _countDownController.start();
                setState(() {
                  sessionName = sessionNameController.text;
                  status = "started";
                });
              })
          : status == "started"
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width * 0.4,
                      child: DefaultButton(
                          color: Theme.of(context).primaryColor,
                          title: "Pause",
                          method: () {
                            Vibration.vibrate(duration: 100, amplitude: 200);
                            _countDownController.pause();
                            timeStamps
                                .add(formatterHour.format(DateTime.now()));
                            timeStampsSecond
                                .add(formatterSeconds.format(DateTime.now()));
                            print(timeStamps);
                            print(timeStampsSecond);
                            setState(() {
                              sessionName = "timer paused";
                              status = "paused";
                            });
                          }),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.4,
                      child: DefaultButton(
                          color: Theme.of(context).primaryColor,
                          title: "Stop",
                          method: () {
                            Vibration.vibrate(duration: 100, amplitude: 200);
                            _countDownController.pause();
                            timeStamps
                                .add(formatterHour.format(DateTime.now()));
                            timeStampsSecond
                                .add(formatterSeconds.format(DateTime.now()));
                            print(timeStamps);
                            print(timeStampsSecond);
                            setState(() {
                              sessionName = null;
                              status = "completed";
                            });
                          }),
                    ),
                  ],
                )
              : status == "completed"
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width * 0.4,
                          child: DefaultButton(
                              color: HexColor("1B1F28").withOpacity(0.8),
                              title: "Start",
                              method: () {
                                Vibration.vibrate(
                                    duration: 100, amplitude: 200);
                                Provider.of<SharedPref>(context, listen: false)
                                    .setTimestamp([]);
                                timeStamps
                                    .add(formatterHour.format(DateTime.now()));
                                timeStampsSecond.add(
                                    formatterSeconds.format(DateTime.now()));
                                _countDownController.start();
                                print(timeStamps);
                                print(timeStampsSecond);
                                setState(() {
                                  sessionName = sessionNameController.text;
                                  status = "started";
                                });
                              }),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.4,
                          child: DefaultButton(
                              color: HexColor("1B1F28").withOpacity(0.8),
                              title: "View report",
                              method: () {
                                print(timeStamps);
                                print(timeStampsSecond);
                                Provider.of<SharedPref>(context, listen: false)
                                    .setTimestamp(timeStamps);
                                Provider.of<SharedPref>(context, listen: false)
                                    .setTimestampSecond(timeStampsSecond);
                                // print(Provider.of<SharedPref>(context,listen: false).timeStamp);
                                setState(() {
                                  resultPage = true;
                                });
                              }),
                        ),
                      ],
                    )
              : status == "paused"
                  ? DefaultButton(
                      color: Theme.of(context).primaryColor,
                      title: "Continue",
                      method: () {
                        Vibration.vibrate(duration: 100, amplitude: 200);
                        timeStamps.add(formatterHour.format(DateTime.now()));
                        timeStampsSecond.add(formatterSeconds.format(DateTime.now()));
                        _countDownController.resume();
                        print(timeStamps);
                        print(timeStampsSecond);
                        setState(() {
                          print(status);
                          sessionName = sessionNameController.text;
                          status = "started";
                        });
                      })
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width * 0.4,
                            child: DefaultButton(
                              color: HexColor("1B1F28").withOpacity(0.8),
                              title: "Start Break",
                              method: () {
                                setState(() {
                                  sessionName = sessionNameController.text;
                                  status = "break started";
                                });
                                print(status);
                                _countDownControllerBreak.start();
                              }),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width * 0.4,
                            child: DefaultButton(
                              color: HexColor("1B1F28").withOpacity(0.8),
                              title: "Stop",
                              method: () {
                                Vibration.vibrate(duration: 100, amplitude: 200);
                                timeStamps.add(formatterHour.format(DateTime.now()));
                                timeStampsSecond.add(formatterSeconds.format(DateTime.now()));
                                print(status + formatterHour.format(DateTime.now()));
                                _countDownControllerBreak.pause();
                                setState(() {
                                  sessionName = null;
                                  status = "completed";
                                });
                              }),
                            ),
                          ],
                        );
    }

    String durationSubtractor(String type) {
      int result;
      bool isCompleted;
      List<int> oddList = [];
      List<int> evenList = [];

      for (var i = 0;
          i <
              Provider.of<SharedPref>(context, listen: false)
                  .timeStampSecond
                  .length;
          i++) {
        if (i == 0) {
          timeStampsCalculated = [];
        } else {
          int current = int.parse(
                  Provider.of<SharedPref>(context, listen: false)
                      .timeStampSecond[i]) -
              int.parse(Provider.of<SharedPref>(context, listen: false)
                  .timeStampSecond[i - 1]);
          timeStampsCalculated.add(current);
        }
      }

      for (final i in timeStampsCalculated) {
        if (i.isEven) {
          evenList.add(i);
        } else if (i.isOdd) {
          oddList.add(i);
        }
      }

      if (type == "work") {
        result = evenList.fold(0, (previous, current) => previous + current);
      } else {
        result = oddList.fold(0, (previous, current) => previous + current);
      }

      if (timeStampsCalculated[timeStampsCalculated.length - 1] -
              timeStampsCalculated[0] >
          1720) {
        isCompleted = true;
      } else {
        isCompleted = false;
      }

      firebaseSubmitted == true
          ? print("a")
          : PomodoroTimerServices().createPomodoroRecord(
              sessionNameController.text,
              isCompleted,
              evenList
                  .fold(0, (previous, current) => previous + current)
                  .toString(),
              oddList
                  .fold(0, (previous, current) => previous + current)
                  .toString());

      setState(() {
        firebaseSubmitted = true;
      });

      return result.toString();
    }

    print(breakTime.toString() + " test");

    return AssistantTopBar(
        photoURL: "assets/pomodoro-background.png",
        topBarControl: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            IconButton(
                padding: EdgeInsets.only(
                    left: MediaQuery.of(context).size.width * 0.05),
                icon: Icon(FlutterIcons.ios_arrow_back_ion,
                    color: HexColor("FAFAFA")),
                onPressed: () {
                  Get.back();
                }),
            Text("pomodoro timer",
                style: GoogleFonts.montserrat().copyWith(
                    color: buildDarkTheme('a').accentColor,
                    fontSize: 18,
                    fontWeight: FontWeight.w600)),
          ],
        ),
        content: resultPage == true
            ? Container(
                height: MediaQuery.of(context).size.height * 0.8,
                child: ListView(
                  physics: BouncingScrollPhysics(),
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal:
                              MediaQuery.of(context).size.height * 0.03),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                              height:
                                  MediaQuery.of(context).size.height * 0.075),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            crossAxisAlignment: CrossAxisAlignment.baseline,
                            children: [
                              Column(
                                children: [
                                  Text("start",
                                      style: GoogleFonts.montserrat().copyWith(
                                          color: Theme.of(context).accentColor,
                                          fontSize: 18,
                                          fontWeight: FontWeight.w300)),
                                  Text(
                                    Provider.of<SharedPref>(context,
                                                listen: false)
                                            .timeStamp[0] ??
                                        "",
                                    style: GoogleFonts.montserrat().copyWith(
                                        color: Theme.of(context).primaryColor,
                                        fontSize: 24,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ],
                              ),
                              Column(
                                children: [
                                  Text("end",
                                      style: GoogleFonts.montserrat().copyWith(
                                          color: Theme.of(context).accentColor,
                                          fontSize: 18,
                                          fontWeight: FontWeight.w300)),
                                  Text(
                                    Provider.of<SharedPref>(context,
                                                listen: false)
                                            .timeStamp[1] ??
                                        "",
                                    style: GoogleFonts.montserrat().copyWith(
                                        color: Theme.of(context).primaryColor,
                                        fontSize: 24,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ],
                              )
                            ],
                          ),
                          SizedBox(
                              height:
                                  MediaQuery.of(context).size.height * 0.075),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            crossAxisAlignment: CrossAxisAlignment.baseline,
                            children: [
                              Column(
                                children: [
                                  Text("work-time",
                                      style: GoogleFonts.montserrat().copyWith(
                                          color: Theme.of(context).accentColor,
                                          fontSize: 18,
                                          fontWeight: FontWeight.w300)),
                                  Text(
                                    durationSubtractor("work"),
                                    style: GoogleFonts.montserrat().copyWith(
                                        color: Theme.of(context).primaryColor,
                                        fontSize: 24,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ],
                              ),
                              Column(
                                children: [
                                  Text("break-time",
                                      style: GoogleFonts.montserrat().copyWith(
                                          color: Theme.of(context).accentColor,
                                          fontSize: 18,
                                          fontWeight: FontWeight.w300)),
                                  Text(
                                    durationSubtractor("break"),
                                    style: GoogleFonts.montserrat().copyWith(
                                        color: Theme.of(context).primaryColor,
                                        fontSize: 24,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ],
                              )
                            ],
                          ),
                          SizedBox(
                              height:
                                  MediaQuery.of(context).size.height * 0.075),
                        ],
                      ),
                    )
                  ],
                ),
              )
            : breakTime == false
                ? ListView(
                    physics: BouncingScrollPhysics(),
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal:
                                MediaQuery.of(context).size.height * 0.03),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Container(
                              height: MediaQuery.of(context).size.height * 0.08,
                              child: sessionName != null
                                  ? AutoSizeText(
                                      sessionName ?? "Untitled Session",
                                      maxLines: 1,
                                      textAlign: TextAlign.center,
                                      style: GoogleFonts.montserrat().copyWith(
                                          color: Theme.of(context).accentColor,
                                          fontSize: 24,
                                          fontWeight: FontWeight.w600))
                                  : TextField(
                                      controller: sessionNameController,
                                      autofocus: true,
                                      textAlign: TextAlign.center,
                                      decoration: new InputDecoration(
                                          border: new OutlineInputBorder(
                                              borderRadius:
                                                  const BorderRadius.all(
                                                const Radius.circular(10.0),
                                              ),
                                              borderSide: BorderSide.none),
                                          filled: true,
                                          hintStyle: GoogleFonts.karla(
                                              color:
                                                  Theme.of(context).accentColor,
                                              fontSize: 16),
                                          hintText:
                                              "Session name... (optional)",
                                          fillColor: HexColor("C4C4C4")
                                              .withOpacity(0.05)),
                                    ),
                            ),
                            SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.04),
                            Container(
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    boxShadow: [
                                      BoxShadow(
                                        color: Theme.of(context)
                                            .primaryColor
                                            .withOpacity(0.3),
                                        blurRadius: 10,
                                        spreadRadius: 10,
                                      )
                                    ]),
                                child: CircularCountDownTimer(
                                  onStart: () {},
                                  onComplete: () {
                                    Provider.of<SharedPref>(context,
                                            listen: false)
                                        .setTimestampSecond(timeStampsSecond);
                                    setState(() {
                                      status = "paused break";
                                      breakTime = true;
                                    });
                                  },
                                  strokeWidth: 10.0,
                                  controller: _countDownController,
                                  textFormat: CountdownTextFormat.MM_SS,
                                  autoStart: false,
                                  width: MediaQuery.of(context).size.height *
                                      0.375,
                                  height: MediaQuery.of(context).size.height *
                                      0.375,
                                  color: Theme.of(context).backgroundColor,
                                  fillColor: Theme.of(context).primaryColor,
                                  backgroundColor:
                                      Theme.of(context).backgroundColor,
                                  duration: 10,
                                  textStyle: GoogleFonts.montserrat().copyWith(
                                      color: Theme.of(context).accentColor,
                                      fontSize: 32,
                                      fontWeight: FontWeight.w600),
                                )),
                            SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.08),
                            statusButton()
                          ],
                        ),
                      )
                    ],
                  )
                : ListView(
                    physics: BouncingScrollPhysics(),
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal:
                                MediaQuery.of(context).size.height * 0.03),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Container(
                              height: MediaQuery.of(context).size.height * 0.08,
                              child: sessionName != null
                                  ? AutoSizeText(
                                      sessionName ?? "Untitled Session",
                                      maxLines: 1,
                                      textAlign: TextAlign.center,
                                      style: GoogleFonts.montserrat().copyWith(
                                          color: Theme.of(context).accentColor,
                                          fontSize: 24,
                                          fontWeight: FontWeight.w600))
                                  : TextField(
                                      controller: sessionNameController,
                                      autofocus: true,
                                      textAlign: TextAlign.center,
                                      decoration: new InputDecoration(
                                          border: new OutlineInputBorder(
                                              borderRadius:
                                                  const BorderRadius.all(
                                                const Radius.circular(10.0),
                                              ),
                                              borderSide: BorderSide.none),
                                          filled: true,
                                          hintStyle: GoogleFonts.karla(
                                              color:
                                                  Theme.of(context).accentColor,
                                              fontSize: 16),
                                          hintText:
                                              "Session name... (optional)",
                                          fillColor: HexColor("C4C4C4")
                                              .withOpacity(0.05)),
                                    ),
                            ),
                            SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.04),
                            Container(
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    boxShadow: [
                                      BoxShadow(
                                        color: Theme.of(context)
                                            .primaryColor
                                            .withOpacity(0.3),
                                        blurRadius: 10,
                                        spreadRadius: 10,
                                      )
                                    ]),
                                child: CircularCountDownTimer(
                                  //break
                                  onStart: () {},
                                  onComplete: () {
                                    Provider.of<SharedPref>(context,listen: false).setTimestampSecond(timeStampsSecond);
                                    setState(() {
                                      status = "completed";
                                    });
                                  },
                                  strokeWidth: 10.0,
                                  controller: _countDownControllerBreak,
                                  textFormat: CountdownTextFormat.MM_SS,
                                  autoStart: false,
                                  width: MediaQuery.of(context).size.height *
                                      0.375,
                                  height: MediaQuery.of(context).size.height *
                                      0.375,
                                  color: Theme.of(context).backgroundColor,
                                  fillColor: Theme.of(context).primaryColor,
                                  backgroundColor:
                                      Theme.of(context).backgroundColor,
                                  duration: 5,
                                  textStyle: GoogleFonts.montserrat().copyWith(
                                      color: Theme.of(context).accentColor,
                                      fontSize: 32,
                                      fontWeight: FontWeight.w600),
                                )),
                            SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.08),
                            statusButton()
                          ],
                        ),
                      )
                    ],
                  ));
  }
}

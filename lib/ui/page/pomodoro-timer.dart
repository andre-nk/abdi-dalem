part of "pages.dart";

class PomodoroTimer extends StatefulWidget {
  @override
  _PomodoroTimerState createState() => _PomodoroTimerState();
}

class _PomodoroTimerState extends State<PomodoroTimer> {
  CountDownController _countDownController = CountDownController();
  TextEditingController sessionNameController = TextEditingController();
  String sessionName, status = "pending";
  int _duration = 1800;

  Widget statusButton() {
    print(status);
    return status == "pending"
        ? DefaultButton(
            color: Theme.of(context).primaryColor,
            title: "Start",
            method: () {
              print(status);
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
                          print(status);
                          _countDownController.pause();
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
                          print(status);
                          _countDownController.pause();
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
                              print(status);
                              _countDownController.start();
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
                              print(status);
                            }),
                      ),
                    ],
                  )
                : status == "paused"
                    ? DefaultButton(
                        color: Theme.of(context).primaryColor,
                        title: "Continue",
                        method: () {
                          _countDownController.resume();
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
                                    status = "started";
                                  });
                                  print(status);
                                  _countDownController.resume();
                                }),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width * 0.4,
                            child: DefaultButton(
                                color: HexColor("1B1F28").withOpacity(0.8),
                                title: "Stop",
                                method: () {
                                  print(status);
                                  _countDownController.pause();
                                  setState(() {
                                    sessionName = null;
                                    status = "completed";
                                  });
                                }),
                          ),
                        ],
                      );
  }

  @override
  Widget build(BuildContext context) {
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
      content: ListView(
        physics: BouncingScrollPhysics(),
        children: [
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.height * 0.03),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  height: MediaQuery.of(context).size.height * 0.08,
                  child: sessionName != null
                      ? AutoSizeText(sessionName ?? "Untitled Session",
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
                                  borderRadius: const BorderRadius.all(
                                    const Radius.circular(10.0),
                                  ),
                                  borderSide: BorderSide.none),
                              filled: true,
                              hintStyle: GoogleFonts.karla(
                                  color: Theme.of(context).accentColor,
                                  fontSize: 16),
                              hintText: "Session name... (optional)",
                              fillColor: HexColor("C4C4C4").withOpacity(0.05)),
                        ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.04),
                Container(
                  decoration: BoxDecoration(shape: BoxShape.circle, boxShadow: [
                    BoxShadow(
                      color: Theme.of(context).primaryColor.withOpacity(0.3),
                      blurRadius: 10,
                      spreadRadius: 10,
                    )
                  ]),
                  child: CircularCountDownTimer(
                    onStart: () {
                      Future.delayed(Duration(seconds: 1500), (){
                        Get.snackbar("Break time!", "Please start the break time");
                        _countDownController.pause();
                        setState(() {
                          status = "paused break";
                        });
                      });
                    },
                    onComplete: () {
                      Get.snackbar("Congratulations", "You have finished one session");
                      setState(() {
                        status = "completed";
                        sessionName = null;
                      });
                    },
                    strokeWidth: 10.0,
                    controller: _countDownController,
                    textFormat: CountdownTextFormat.MM_SS,
                    autoStart: false,
                    width: MediaQuery.of(context).size.height * 0.375,
                    height: MediaQuery.of(context).size.height * 0.375,
                    color: Theme.of(context).backgroundColor,
                    fillColor: Theme.of(context).primaryColor,
                    backgroundColor: Theme.of(context).backgroundColor,
                    duration: _duration,
                    textStyle: GoogleFonts.montserrat().copyWith(
                        color: Theme.of(context).accentColor,
                        fontSize: 32,
                        fontWeight: FontWeight.w600),
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.08),
                AnimatedContainer(
                    duration: Duration(milliseconds: 500),
                    width: MediaQuery.of(context).size.width * 0.3,
                    child: statusButton())
              ],
            ),
          )
        ],
      ),
    );
  }
}

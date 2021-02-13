part of "pages.dart";

class IQLanding extends StatefulWidget {
  @override
  _IQLandingState createState() => _IQLandingState();
}

class _IQLandingState extends State<IQLanding> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: SafeArea(
            child: Material(
              type: MaterialType.transparency,
              color: Colors.transparent,
          child: Column(
            // overflow: Overflow.visible,
            children: [
              ToolDisplayer(
                heroTag: "iq",
                photoURL: "assets/IQ-tab.png",
                title: "Bunaken",
                subtitle: "your iq assistant,",
              ),
              Padding(
                padding:
                    EdgeInsets.all(MediaQuery.of(context).size.height * 0.04),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text("tools",
                        style: GoogleFonts.montserrat().copyWith(
                            letterSpacing: 2.0,
                            color: Theme.of(context).accentColor,
                            fontSize: 18,
                            fontWeight: FontWeight.w700)),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.03),
                    Container(
                      height: MediaQuery.of(context).size.height * 0.35,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        physics: BouncingScrollPhysics(),
                        itemExtent: MediaQuery.of(context).size.height * 0.25,
                        children: [
                          ToolLandingCard(
                            method: () {
                              Navigator.push(
                                  context,
                                  PageTransition(
                                      type: PageTransitionType.fade,
                                      alignment: Alignment.bottomCenter,
                                      child: PomodoroTimer()));
                            },
                            title: "pomodoro timer",
                            photoURL: "assets/pomodoro-illus.png",
                            icon: Icon(FlutterIcons.clock_faw5,
                                color: Theme.of(context).accentColor,
                                size: MediaQuery.of(context).size.height * 0.03,
                            ),
                          ),
                          ToolLandingCard(
                            method: () {
                              Navigator.push(
                                  context,
                                  PageTransition(
                                      type: PageTransitionType.fade,
                                      alignment: Alignment.bottomCenter,
                                      child: ToDoLandingPage()));
                            },
                            title: "to-do list",
                            photoURL: "assets/to-do-illus.png",
                            icon: Icon(FlutterIcons.tasklist_oct,
                                color: Theme.of(context).accentColor,
                                size: MediaQuery.of(context).size.height * 0.03,  
                              ),
                          ),
                          ToolLandingCard(
                            title: "timeflow timer",
                            photoURL: "assets/timeflow-illus.png",
                            icon: Icon(FlutterIcons.clock_faw5,
                                color: Theme.of(context).accentColor,
                                size: MediaQuery.of(context).size.height * 0.03,
                              ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        )));
  }
}

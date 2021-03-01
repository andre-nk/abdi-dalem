part of "pages.dart";

class BadHabitLanding extends StatefulWidget {
  @override
  _BadHabitLandingState createState() => _BadHabitLandingState();
}

class _BadHabitLandingState extends State<BadHabitLanding> {
  bool protectedViewEnabled = true;

  @override
  Widget build(BuildContext context) {
    return AssistantTopBar(
      fabActive: true,
      fabMethod: () {
        showModalBottomSheet(
            backgroundColor: Colors.transparent,
            isScrollControlled: true,
            context: context,
            builder: (BuildContext context) {
              return Padding(
                padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom),
                child: BadHabitAdderBottomSheet(),
              );
            }
        );
      },
      topBarControl: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          IconButton(
              padding: EdgeInsets.only(
                  left: MediaQuery.of(context).size.width * 0.05),
              icon: Icon(FlutterIcons.ios_arrow_back_ion,
                  color: HexColor("FAFAFA")),
              onPressed: () {
                Get.back();
              }),
          Row(
            children: [
              protectedViewEnabled
                  ? Text("normal-view",
                      style: GoogleFonts.montserrat().copyWith(
                          color: buildDarkTheme('a').accentColor,
                          fontSize: 18,
                          fontWeight: FontWeight.w600))
                  : Text("protected-view",
                      style: GoogleFonts.montserrat().copyWith(
                          color: buildDarkTheme('a').accentColor,
                          fontSize: 18,
                          fontWeight: FontWeight.w600)),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.04,
              ),
              Container(
                height: MediaQuery.of(context).size.width * 0.125,
                width: MediaQuery.of(context).size.width * 0.125,
                child: RaisedButton(
                    color: protectedViewEnabled
                        ? Theme.of(context).primaryColor
                        : Theme.of(context).backgroundColor,
                    disabledColor: Theme.of(context).backgroundColor,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Container(
                      child: Icon(
                        FlutterIcons.list_ent,
                        size: MediaQuery.of(context).size.height * 0.025,
                        color: Theme.of(context).accentColor,
                      ),
                    ),
                    onPressed: () {
                      setState(() {
                        protectedViewEnabled = true;
                      });
                    }),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.04,
              ),
              Container(
                height: MediaQuery.of(context).size.width * 0.125,
                width: MediaQuery.of(context).size.width * 0.125,
                child: RaisedButton(
                    color: protectedViewEnabled
                        ? Theme.of(context).backgroundColor
                        : Theme.of(context).primaryColor,
                    disabledColor: Theme.of(context).backgroundColor,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Icon(
                      FlutterIcons.lock1_ant,
                      size: MediaQuery.of(context).size.height * 0.025,
                      color: Theme.of(context).accentColor,
                    ),
                    onPressed: () {
                      setState(() {
                        protectedViewEnabled = false;
                        print("a");
                      });
                    } //TBA
                    ),
              ),
            ],
          ),
        ],
      ),
      content: protectedViewEnabled ? BadHabitNormalView() : SizedBox(),
      photoURL: "assets/eq-tools-tab.png",
    );
  }
}

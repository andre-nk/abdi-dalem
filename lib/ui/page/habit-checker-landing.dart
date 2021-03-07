part of "pages.dart";

class HabitCheckerLanding extends StatefulWidget {
  @override
  _HabitCheckerLandingState createState() => _HabitCheckerLandingState();
}

class _HabitCheckerLandingState extends State<HabitCheckerLanding> {
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
              return HabitCheckerBottomSheet();
            });
      },
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
          Text("habit-checker",
              style: GoogleFonts.montserrat().copyWith(
                  color: buildDarkTheme('a').accentColor,
                  fontSize: 18,
                  fontWeight: FontWeight.w600)),
        ],
      ),
      content: HabitChecker(),
      photoURL: "assets/eq-tools-tab.png",
    );
  }
}

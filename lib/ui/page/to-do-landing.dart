part of "pages.dart";

class ToDoLandingPage extends StatefulWidget {
  @override
  _ToDoLandingPageState createState() => _ToDoLandingPageState();
}

class _ToDoLandingPageState extends State<ToDoLandingPage> {
  bool listViewEnabled = true;

  @override
  Widget build(BuildContext context) {
    //FIREBASE SETUP
    final User currentUser = FirebaseAuth.instance.currentUser;
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    DocumentReference toDoDocument = firestore.collection("users").doc(currentUser.uid);
    Future firestoreNullGenerator() async {
      return await toDoDocument.get().then((val) {
        if (val.data()["tags_title"] == null) {
          toDoDocument.set({
            "name": val.data()["name"],
            "tags_title": ["Inbox", "School", "Daily"],
            "tags_colors": ["ef476f", "ffd166", "118ab2"]
          });
        }
      });
    }

    firestoreNullGenerator();
    print(listViewEnabled);

    //PAGE SETUP
    return StreamProvider<List<TaskObject>>.value(
      value: ToDoServices().taskObject,
      catchError: (_, __) => [],
      child: AssistantTopBar(
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
                listViewEnabled
                    ? Text("list-view",
                        style: GoogleFonts.montserrat().copyWith(
                            color: buildDarkTheme('a').accentColor,
                            fontSize: 18,
                            fontWeight: FontWeight.w600))
                    : Text("calendar-view",
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
                      color: listViewEnabled
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
                          listViewEnabled = true;
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
                      color: listViewEnabled
                          ? Theme.of(context).backgroundColor
                          : Theme.of(context).primaryColor,
                      disabledColor: Theme.of(context).backgroundColor,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Icon(
                        FlutterIcons.calendar_ant,
                        size: MediaQuery.of(context).size.height * 0.025,
                        color: Theme.of(context).accentColor,
                      ),
                      onPressed: () {
                        setState(() {
                          listViewEnabled = false;
                          print("a");
                        });
                      } //TBA
                      ),
                ),
              ],
            ),
          ],
        ),
        content: listViewEnabled
            ? StreamProvider<List<ToDoListCard>>.value(
                value: ToDoServices().taskList,
                catchError: (_, __) => [],
                child: ListViewToDoList(
                  currentUser: currentUser,
                ),
              )
            : CalendarViewToDoList(
                currentUser: currentUser
              ),
        photoURL: "assets/to-do-tab.png",
      ),
    );
  }
}

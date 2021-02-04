part of "pages.dart";

class ToDoLandingPage extends StatefulWidget {
  @override
  _ToDoLandingPageState createState() => _ToDoLandingPageState();
}

class _ToDoLandingPageState extends State<ToDoLandingPage> {
  bool showList = true;

  @override
  Widget build(BuildContext context) {
    final User currentUser = FirebaseAuth.instance.currentUser;

    FirebaseFirestore firestore = FirebaseFirestore.instance;
    DocumentReference toDoDocument = firestore
        .collection("users")
        .doc(currentUser.uid);

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

    return StreamProvider<List<TaskObject>>.value(
      value: DatabaseServices().taskObject,
      catchError: (_, __) => [],
      child: AssistantTopBar(
        content: ListView(
          physics: BouncingScrollPhysics(),
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 1,
                  width: MediaQuery.of(context).size.width * 0.35,
                  child: Container(
                    decoration:
                        BoxDecoration(color: Theme.of(context).primaryColor),
                  ),
                ),
                Container(
                  height: MediaQuery.of(context).size.width * 0.15,
                  width: MediaQuery.of(context).size.width * 0.15,
                  child: RaisedButton(
                    onPressed: () {
                      showModalBottomSheet(
                          backgroundColor: Colors.transparent,
                          isScrollControlled: true,
                          context: context,
                          builder: (BuildContext context) {
                            return Padding(
                              padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
                              child: ListAdderBottomSheet(
                                currentUser: currentUser,
                                firestore: firestore,
                                toDoCollection: toDoDocument,
                              ),
                            );
                          });
                    },
                    color: Theme.of(context).primaryColor,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Icon(
                      FlutterIcons.plus_ant,
                      color: Theme.of(context).backgroundColor,
                    ),
                  ),
                ),
                SizedBox(
                  height: 1,
                  width: MediaQuery.of(context).size.width * 0.35,
                  child: Container(
                    decoration:
                        BoxDecoration(color: Theme.of(context).primaryColor),
                  ),
                ),
              ],
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.04),
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.width * 0.05),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height * 0.075,
                    width: MediaQuery.of(context).size.width * 0.75,
                    child: Container(
                      decoration: BoxDecoration(
                          color: HexColor("C4C4C4").withOpacity(0.2),
                          borderRadius: BorderRadius.all(Radius.circular(15))),
                      child: TextField(
                        textAlign: TextAlign.left,
                        decoration: InputDecoration(
                            contentPadding: EdgeInsets.only(left: 20),
                            fillColor: HexColor("C4C4C4"),
                            border: InputBorder.none,
                            hintText: "Search your task...",
                            hintStyle: GoogleFonts.karla(
                                color: Theme.of(context).accentColor,
                                fontSize: 18)),
                        style: GoogleFonts.karla(
                            color: Theme.of(context).accentColor, fontSize: 16),
                        onChanged: (val) {},
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: Icon(FlutterIcons.search1_ant),
                  )
                ],
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.04),
            showList
                ? Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal:
                                MediaQuery.of(context).size.width * 0.055),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "task list / projects",
                              style: GoogleFonts.montserrat().copyWith(
                                  color: Theme.of(context).accentColor,
                                  fontSize: 18,
                                  letterSpacing: 1,
                                  fontWeight: FontWeight.w700),
                            ),
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  showList = false;
                                });
                              },
                              child: Text(
                                "view all",
                                style: GoogleFonts.karla().copyWith(
                                    color: Theme.of(context).accentColor,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w400),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.0275),
                      StreamBuilder(
                          stream: toDoDocument.snapshots(),
                          builder: (_, snapshot) {
                            if (snapshot.hasData) {
                              return Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal:
                                          MediaQuery.of(context).size.width *
                                              0.05),
                                  height:
                                      MediaQuery.of(context).size.height * 0.4,
                                  child: ListView.builder(
                                    physics: BouncingScrollPhysics(),
                                    scrollDirection: Axis.horizontal,
                                    itemExtent:
                                        MediaQuery.of(context).size.width * 0.8,
                                    itemCount:
                                        snapshot.data.data()["tags_title"] !=
                                                null
                                            ? snapshot.data
                                                .data()["tags_title"]
                                                .length
                                            : 0,
                                    itemBuilder: (BuildContext context, index) {
                                      return ToDoListCard(
                                        firestoreDB: firestore,
                                        currentUser: currentUser,
                                        listTitle: snapshot.data
                                            .data()["tags_title"][index]
                                            .toString(),
                                        tagColor: snapshot.data
                                            .data()["tags_colors"][index]
                                            .toString(),
                                      );
                                    },
                                  ));
                            } else {
                              return SpinKitRotatingCircle(
                                color: Theme.of(context).accentColor,
                                size: MediaQuery.of(context).size.height * 0.01,
                              );
                            }
                          })
                    ],
                  )
                : Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal:
                                MediaQuery.of(context).size.width * 0.055),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "task list / projects",
                                  style: GoogleFonts.montserrat().copyWith(
                                      color: Theme.of(context).accentColor,
                                      fontSize: 18,
                                      letterSpacing: 1,
                                      fontWeight: FontWeight.w700),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      showList = true;
                                    });
                                  },
                                  child: Text(
                                    "view list",
                                    style: GoogleFonts.karla().copyWith(
                                        color: Theme.of(context).accentColor,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w400),
                                  ),
                                )
                              ],
                            ),
                            SizedBox(
                                height: MediaQuery.of(context).size.height *
                                    0.0275),
                            ToDoObjectStream(
                              forNumeric: false,
                              isMinimized: false,
                            )
                          ],
                        ),
                      ),
                    ],
                  )
          ],
        ),
        photoURL: "assets/to-do-tab.png",
      ),
    );
  }
}

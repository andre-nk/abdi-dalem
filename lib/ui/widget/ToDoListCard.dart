part of "widgets.dart";

class ToDoListCard extends StatefulWidget {
  final Map toDoList;
  final String listTitle; //temporarily, for FB, will display: a.) title (cycle tags document) b.) all taskID with corresponding tags c.) tags color
  final String tagColor;
  final FirebaseFirestore firestoreDB;
  final User currentUser;

  ToDoListCard({this.toDoList, this.listTitle, this.tagColor, this.firestoreDB, this.currentUser});

  @override
  _ToDoListCardState createState() =>
      _ToDoListCardState();
}

class _ToDoListCardState extends State<ToDoListCard> {
  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: "tag" + widget.listTitle,
      child: Material(
        color: Colors.transparent,
        type: MaterialType.transparency,
        child: GestureDetector(
          onTap: () {
            Get.to(ToDoDetails(
              listTitle: widget.listTitle,
              tagColor: widget.tagColor,
              firestoreDB: widget.firestoreDB,
              currentUser: widget.currentUser
            ));
          },
          child: Container(
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
            child: Padding(
              padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).size.height * 0.03),
              child: Container(
                height: double.infinity * 0.6,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: double.infinity,
                      height: MediaQuery.of(context).size.height * 0.01,
                      decoration: BoxDecoration(
                          color: widget.tagColor != null
                              ? HexColor(widget.tagColor).withOpacity(1)
                              : Theme.of(context)
                                  .primaryColor, //TBA FB Tags Color
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(10),
                              topRight: Radius.circular(10))),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal:
                              MediaQuery.of(context).size.height * 0.03),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Padding(
                          //   padding: EdgeInsets.symmetric(
                          //       vertical:
                          //           MediaQuery.of(context).size.height * 0.02),
                          //   child: Column(
                          //     mainAxisAlignment: MainAxisAlignment.start,
                          //     children: [
                          //       ToDoObjectStream(
                          //         firestoreDB: widget.firestoreDB,
                          //         currentUser: widget.currentUser,
                          //         listTitle: widget.listTitle,
                          //         isMinimized: true,
                          //       )
                          //     ],
                          //   ),
                          // ),
                          Text("${widget.listTitle}" ?? "",
                              style: GoogleFonts.montserrat().copyWith(
                                  color: Theme.of(context).accentColor,
                                  fontSize: 18,
                                  letterSpacing: 1,
                                  fontWeight:
                                      FontWeight.w700)), //TBA FB Tags Title
                          SizedBox(
                              height:
                                  MediaQuery.of(context).size.height * 0.01),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                height:
                                    MediaQuery.of(context).size.height * 0.01,
                                width: MediaQuery.of(context).size.width * 0.45,
                                decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(50))),
                                child: LinearProgressIndicator(
                                  minHeight:
                                      MediaQuery.of(context).size.height * 0.01,
                                  value: 0.1,
                                  backgroundColor: Theme.of(context)
                                      .accentColor
                                      .withOpacity(0.6),
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                      Theme.of(context).primaryColor),
                                ),
                              ),
                              Text("100%",
                                  style: GoogleFonts.karla().copyWith(
                                      color: Theme.of(context).accentColor,
                                      fontSize: 18,
                                      letterSpacing: 1,
                                      fontWeight: FontWeight.w700)),
                            ],
                          ),                          
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

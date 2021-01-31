part of "pages.dart";

class ToDoDetails extends StatefulWidget {
  @override
  _ToDoDetailsState createState() => _ToDoDetailsState();

  final String listTitle;
  final String tagColor;
  final FirebaseFirestore firestoreDB;
  final User currentUser;


  ToDoDetails({this.listTitle, this.tagColor, this.firestoreDB, this.currentUser});
}

class _ToDoDetailsState extends State<ToDoDetails> with TickerProviderStateMixin {

  double percentComplete;
  AnimationController animationBar;
  double barPercent = 0.0;
  Tween<double> animT;
  AnimationController scaleAnimation;
  final List<String> filterOptions = ["all", "today", "yesterday", "this week"];
  int selectedIndex = 0;
  Stream slides;

  @override
  void initState() {
    scaleAnimation = AnimationController(
        vsync: this,
        duration: Duration(milliseconds: 1000),
        lowerBound: 0.0,
        upperBound: 1.0);

    // percentComplete = widget.todoObject.percentComplete();
    barPercent = percentComplete;
    animationBar =
        AnimationController(vsync: this, duration: Duration(milliseconds: 100))
          ..addListener(() {
            setState(() {
              barPercent = animT.transform(animationBar.value);
            });
          });
    animT = Tween<double>(begin: percentComplete, end: percentComplete);
    scaleAnimation.forward();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    animationBar.dispose();
    scaleAnimation.dispose();
  }

  // void updateBarPercent() async {
  //   double newPercentComplete = widget.todoObject.percentComplete();
  //   if (animationBar.status == AnimationStatus.forward || animationBar.status == AnimationStatus.completed) {
  //     animT.begin = newPercentComplete;
  //     await animationBar.reverse();
  //   } else {
  //     animT.end = newPercentComplete;
  //     await animationBar.forward();
  //   }
  //   percentComplete = newPercentComplete;
  // }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Hero(
          tag: "tag" + widget.listTitle,
          child: Container(
            decoration: BoxDecoration(
              color: Theme.of(context).backgroundColor,
              borderRadius: BorderRadius.circular(0.0),
            ),
          ),
        ),
        SafeArea(
          child: Scaffold(
              resizeToAvoidBottomInset: false,
              floatingActionButtonLocation:
                  FloatingActionButtonLocation.endFloat,
              floatingActionButton: FloatingActionButton(
                elevation: 0,
                backgroundColor: Theme.of(context).primaryColor,
                foregroundColor: Theme.of(context).backgroundColor,
                mini: false,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                onPressed: () {
                  Get.bottomSheet(ToDoAdderBottomSheet(widget.listTitle));
                },
                child: Container(
                  child: Icon(
                    FlutterIcons.plus_ant,
                    color: Theme.of(context).backgroundColor,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.all(
                      Radius.circular(100),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Theme.of(context).primaryColor.withOpacity(0.3),
                        spreadRadius: 7,
                        blurRadius: 7,
                        offset: Offset(3, 5),
                      ),
                    ],
                  ),
                ),
              ),
              backgroundColor: Colors.transparent,
              // appBar: AppBar(
              //   toolbarHeight: MediaQuery.of(context).size.height * 0.09,
              //   backgroundColor: Colors.transparent,
              //   elevation: 0.0,
              //   leading: Material(
              //     color: Colors.transparent,
              //     type: MaterialType.transparency,
              //     child: IconButton(
              //         icon: Icon(FlutterIcons.ios_arrow_back_ion,
              //             color: Theme.of(context).accentColor),
              //         onPressed: () {
              //           Get.back();
              //         }),
              //   ),
              // ),
              body: CustomScrollView(
                slivers: [
                  SliverAppBar(
                      backgroundColor: Colors.transparent,
                      elevation: 0.0,
                      expandedHeight: MediaQuery.of(context).size.height * 0.09,
                      leading: Material(
                        color: Colors.transparent,
                        type: MaterialType.transparency,
                        child: IconButton(
                            icon: Icon(FlutterIcons.ios_arrow_back_ion,
                                color: Theme.of(context).accentColor),
                            onPressed: () {
                              Get.back();
                            }),
                      )),
                  SliverToBoxAdapter(
                      child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                          width: double.infinity,
                          height: MediaQuery.of(context).size.height * 0.005,
                          decoration: BoxDecoration(
                              color: widget.tagColor != null
                                  ? HexColor(widget.tagColor)
                                  : Theme.of(context).primaryColor)),
                      Padding(
                        padding: EdgeInsets.all(
                            MediaQuery.of(context).size.height * 0.03),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ToDoObjectStream(
                              forNumeric: true,
                              firestoreDB: widget.firestoreDB,
                              currentUser: widget.currentUser,
                            ),
                            SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.015),
                            Text(
                              "${widget.listTitle}",
                              style: GoogleFonts.montserrat(
                                  color: Theme.of(context).accentColor,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 32),
                            ),
                            SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.015),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  height:
                                      MediaQuery.of(context).size.height * 0.01,
                                  width:
                                      MediaQuery.of(context).size.width * 0.7,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(50))),
                                  child: LinearProgressIndicator(
                                    minHeight:
                                        MediaQuery.of(context).size.height *
                                            0.01,
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
                            SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.025),
                            SelectionButtons(
                              titles: filterOptions,
                              selectedIndex: selectedIndex,
                              onTap: (index) {
                                setState(() {
                                  selectedIndex = index;
                                });
                              },
                            ),
                            SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.025),
                            ToDoObjectStream(
                              firestoreDB: widget.firestoreDB,
                              currentUser: widget.currentUser,
                              listTitle: widget.listTitle,
                              isMinimized: false,
                            )
                          ],
                        ),
                      ),
                    ],
                  ))
                ],
              )),
        )
      ],
    );
  }
}

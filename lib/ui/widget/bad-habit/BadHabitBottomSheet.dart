part of "../widgets.dart";

class BadHabitAdderBottomSheet extends StatefulWidget {
  @override
  _BadHabitAdderBottomSheetState createState() =>
      _BadHabitAdderBottomSheetState();
}

class _BadHabitAdderBottomSheetState extends State<BadHabitAdderBottomSheet> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  int limitCount = 1;

  @override
  Widget build(BuildContext context) {
    return BottomSheet(
        onClosing: () {},
        backgroundColor: Theme.of(context).backgroundColor,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(40), topRight: Radius.circular(40))),
        builder: (ctx) {
          return Container(
              height: MediaQuery.of(context).size.height * 0.575,
              child: SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  child: Padding(
                      padding: EdgeInsets.all(
                          MediaQuery.of(context).size.height * 0.04),
                      child: Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TextField(
                              autofocus: true,
                              controller: titleController,
                              decoration: InputDecoration(
                                  contentPadding: EdgeInsets.only(
                                      left: MediaQuery.of(context).size.width *
                                          0.01),
                                  fillColor: HexColor("C4C4C4"),
                                  border: InputBorder.none,
                                  hintText: "Type the bad habit name...",
                                  hintStyle: GoogleFonts.montserrat(
                                      color: Theme.of(context).accentColor,
                                      fontSize: 22,
                                      fontWeight: FontWeight.w500)),
                              style: GoogleFonts.montserrat(
                                  color: Theme.of(context).accentColor,
                                  fontSize: 22,
                                  fontWeight: FontWeight.w500),
                              onChanged: (val) {},
                            ),
                            SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.02),
                            TextField(
                              maxLines: 5,
                              minLines: 5,
                              autofocus: true,
                              controller: descriptionController,
                              decoration: InputDecoration(
                                  border: new OutlineInputBorder(
                                    borderSide: BorderSide(
                                      width: 0,
                                      style: BorderStyle.none,
                                    ),
                                    borderRadius: const BorderRadius.all(
                                      const Radius.circular(15.0),
                                    ),
                                  ),
                                  filled: true,
                                  fillColor:
                                      HexColor("C4C4C4").withOpacity(0.2),
                                  hintText: "Bad habit description...",
                                  hintStyle: GoogleFonts.karla(
                                      color: Theme.of(context).accentColor,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w400)),
                              style: GoogleFonts.karla(
                                  color: Theme.of(context).accentColor,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w400),
                              onChanged: (val) {},
                            ),
                            SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.025),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              crossAxisAlignment: CrossAxisAlignment.baseline,
                              children: [
                                ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      primary: Theme.of(context)
                                          .primaryColor
                                          .withOpacity(0.1),
                                      elevation: 0,
                                    ),
                                    child: Icon(FlutterIcons.minus_ant),
                                    onPressed: () {
                                      setState(() {
                                        if (limitCount == 1) {
                                          limitCount = 1;
                                        } else {
                                          limitCount--;
                                        }
                                      });
                                    }),
                                Text("${limitCount ?? 0}",
                                    style: GoogleFonts.montserrat(
                                        color: Theme.of(context).accentColor,
                                        fontSize: 24,
                                        fontWeight: FontWeight.w400)),
                                ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      primary: Theme.of(context)
                                          .primaryColor
                                          .withOpacity(0.1),
                                      elevation: 0,
                                    ),
                                    child: Icon(FlutterIcons.plus_ant),
                                    onPressed: () {
                                      setState(() {
                                        limitCount++;
                                      });
                                    }),
                              ],
                            ),
                            SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.025),
                            DefaultButton(
                              method: () async {
                                Get.back();
                                BadHabitServices().createBadHabitRecord(
                                    titleController.text, limitCount, false,
                                    subtitle: descriptionController.text ??
                                        ""); //start-time (for calendar);
                              },
                              title: "Confirm",
                            )
                          ]))));
        });
  }
}

class BadHabitPreviewer extends StatefulWidget {
  final String title;
  final String subtitle;
  final String uid;
  final int limit;
  final int currentCount;
  final bool isProtected;

  BadHabitPreviewer(
      {this.title,
      this.subtitle,
      this.uid,
      this.limit,
      this.currentCount,
      this.isProtected});

  @override
  _BadHabitPreviewerState createState() => _BadHabitPreviewerState();
}

class _BadHabitPreviewerState extends State<BadHabitPreviewer> {
  int limitCount = 1;

  @override
  Widget build(BuildContext context) {
    TextEditingController titleController =
        TextEditingController(text: widget.title);
    TextEditingController descriptionController =
        TextEditingController(text: widget.subtitle);

    return BottomSheet(
        onClosing: () {},
        backgroundColor: Theme.of(context).backgroundColor,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(40), topRight: Radius.circular(40))),
        builder: (ctx) {
          return Container(
              height: MediaQuery.of(context).size.height * 0.625,
              child: SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  child: Padding(
                      padding: EdgeInsets.all(
                          MediaQuery.of(context).size.height * 0.04),
                      child: Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TextField(
                              autofocus: true,
                              controller: titleController,
                              decoration: InputDecoration(
                                  contentPadding: EdgeInsets.only(
                                      left: MediaQuery.of(context).size.width *
                                          0.01),
                                  fillColor: HexColor("C4C4C4"),
                                  border: InputBorder.none,
                                  hintText: "${widget.title}",
                                  hintStyle: GoogleFonts.montserrat(
                                      color: Theme.of(context).accentColor,
                                      fontSize: 22,
                                      fontWeight: FontWeight.w500)),
                              style: GoogleFonts.montserrat(
                                  color: Theme.of(context).accentColor,
                                  fontSize: 22,
                                  fontWeight: FontWeight.w500),
                              onChanged: (val) {},
                            ),
                            SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.02),
                            TextField(
                              maxLines: 5,
                              minLines: 5,
                              autofocus: true,
                              controller: descriptionController,
                              decoration: InputDecoration(
                                  border: new OutlineInputBorder(
                                    borderSide: BorderSide(
                                      width: 0,
                                      style: BorderStyle.none,
                                    ),
                                    borderRadius: const BorderRadius.all(
                                      const Radius.circular(15.0),
                                    ),
                                  ),
                                  filled: true,
                                  fillColor:
                                      HexColor("C4C4C4").withOpacity(0.2),
                                  hintText: "${widget.subtitle}",
                                  hintStyle: GoogleFonts.karla(
                                      color: Theme.of(context).accentColor,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w400)),
                              style: GoogleFonts.karla(
                                  color: Theme.of(context).accentColor,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w400),
                              onChanged: (val) {},
                            ),
                            SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.025),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              crossAxisAlignment: CrossAxisAlignment.baseline,
                              children: [
                                ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      primary: Theme.of(context)
                                          .primaryColor
                                          .withOpacity(0.1),
                                      elevation: 0,
                                    ),
                                    child: Icon(FlutterIcons.minus_ant),
                                    onPressed: () {
                                      setState(() {
                                        if (limitCount == 1) {
                                          limitCount = 1;
                                        } else {
                                          limitCount--;
                                        }
                                      });
                                    }),
                                Text("$limitCount",
                                    style: GoogleFonts.montserrat(
                                        color: Theme.of(context).accentColor,
                                        fontSize: 24,
                                        fontWeight: FontWeight.w400)),
                                ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      primary: Theme.of(context)
                                          .primaryColor
                                          .withOpacity(0.1),
                                      elevation: 0,
                                    ),
                                    child: Icon(FlutterIcons.plus_ant),
                                    onPressed: () {
                                      setState(() {
                                        limitCount++;
                                      });
                                    }),
                              ],
                            ),
                            SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.025),
                            Container(
                              width: MediaQuery.of(context).size.width * 1,
                              child: Text(
                                "current: ${widget.limit}",
                                style: GoogleFonts.karla(
                                    color: Theme.of(context).accentColor,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.025),
                            DefaultButton(
                              method: () async {
                                Get.back();
                                BadHabitServices().updateBadHabitRecord(
                                    widget.uid, widget.isProtected,
                                    title: titleController.text != ""
                                        ? titleController.text
                                        : widget.title,
                                    subtitle: descriptionController.text != ""
                                        ? descriptionController.text
                                        : widget.subtitle,
                                    limit: limitCount ?? widget.limit,
                                    currentCount: widget
                                        .currentCount); //start-time (for calendar);
                              },
                              title: "Confirm",
                            )
                          ]))));
        });
  }
}

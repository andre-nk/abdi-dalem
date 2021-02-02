part of "models.dart";

class ToDoObjectStream extends StatefulWidget {
  final FirebaseFirestore firestoreDB;
  final User currentUser;
  final String listTitle;
  final bool isMinimized;
  final bool forNumeric;

  ToDoObjectStream(
      {this.firestoreDB,
      this.currentUser,
      this.listTitle,
      this.isMinimized,
      this.forNumeric});

  @override
  _ToDoObjectStreamState createState() => _ToDoObjectStreamState();
}

class _ToDoObjectStreamState extends State<ToDoObjectStream> {
  @override
  Widget build(BuildContext context) {
    bool _isCompletedSample = false;

    return widget.forNumeric == true
        ? StreamBuilder(
            stream: widget.firestoreDB
                .collection("users")
                .doc(widget.currentUser.uid)
                .collection("to-do-collection")
                .where("tags", arrayContains: widget.listTitle)
                .snapshots(),
            initialData: [],
            builder: (context, snapshot) {
              List items = snapshot.data.docs;
              return Text(
                "${items.length ?? "0"}" + " task(s)",
                style: GoogleFonts.karla(
                    color: Theme.of(context).accentColor, fontSize: 16),
              );
            },
          )
        : widget.listTitle == null
            ? StreamBuilder(
                stream: widget.firestoreDB
                    .collection("users")
                    .doc(widget.currentUser.uid)
                    .collection("to-do-collection")
                    .snapshots(),
                initialData: [],
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    List items = snapshot.data.docs;
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          alignment: Alignment.topCenter,
                          height: MediaQuery.of(context).size.height * 0.3,
                          child: ListView.builder(
                            physics: BouncingScrollPhysics(),
                            scrollDirection: Axis.vertical,
                            itemCount: items.length - 1,
                            itemBuilder: (context, index) {
                              return CustomCheckboxListTile(
                                  activeColor: Theme.of(context)
                                      .primaryColor, //change to tag color
                                  value:
                                      _isCompletedSample, //*task.isCompleted(),
                                  onChanged: (value) {
                                    setState(() {
                                      _isCompletedSample == false
                                          ? _isCompletedSample = true
                                          : _isCompletedSample = false;
                                    });
                                  },
                                  title: Text(
                                      "${items[index]["taskName"] ?? ""}",
                                      style: GoogleFonts.karla().copyWith(
                                          color: Theme.of(context).accentColor,
                                          fontSize: 18,
                                          fontWeight: FontWeight.w500)));
                            },
                          ),
                        ),
                      ],
                    );
                  } else {
                    return SpinKitRotatingCircle(
                      color: Theme.of(context).accentColor,
                      size: MediaQuery.of(context).size.height * 0.01,
                    );
                  }
                },
              )
            : widget.isMinimized == true
                ? StreamBuilder(
                    stream: widget.firestoreDB
                        .collection("users")
                        .doc(widget.currentUser.uid)
                        .collection("to-do-collection")
                        .where("tags", arrayContains: widget.listTitle)
                        .snapshots(),
                    initialData: [],
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        List items = snapshot.data.docs;
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              height: MediaQuery.of(context).size.height * 0.2,
                              child: ListView.builder(
                                physics: BouncingScrollPhysics(),
                                scrollDirection: Axis.vertical,
                                itemCount: items.length,
                                itemBuilder: (context, index) {
                                  return CustomCheckboxListTile(
                                      activeColor: Theme.of(context)
                                          .primaryColor, //change to tag color
                                      value:
                                          _isCompletedSample, //*task.isCompleted(),
                                      onChanged: (value) {
                                        setState(() {
                                          _isCompletedSample == false
                                              ? _isCompletedSample = true
                                              : _isCompletedSample = false;
                                        });
                                      },
                                      title: Text(
                                          "${items[index]["taskName"] ?? ""}",
                                          style: GoogleFonts.karla().copyWith(
                                              color:
                                                  Theme.of(context).accentColor,
                                              fontSize: 18,
                                              fontWeight: FontWeight.w500)));
                                },
                              ),
                            ),
                          ],
                        );
                      } else {
                        return SpinKitRotatingCircle(
                          color: Theme.of(context).accentColor,
                          size: MediaQuery.of(context).size.height * 0.01,
                        );
                      }
                    },
                  )
                : StreamBuilder(
                    stream: widget.firestoreDB
                        .collection("users")
                        .doc(widget.currentUser.uid)
                        .collection("to-do-collection")
                        .where("tags", arrayContains: widget.listTitle)
                        .snapshots(),
                    initialData: [],
                    builder: (context, snapshot) {
                      List items = snapshot.data.docs;
                      // print("a");
                      // // print(items);
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            height: MediaQuery.of(context).size.height * 0.3,
                            child: ListView.builder(
                              physics: BouncingScrollPhysics(),
                              scrollDirection: Axis.vertical,
                              itemCount: items.length,
                              itemBuilder: (context, index) {
                                return CustomCheckboxListTile(
                                    activeColor: Theme.of(context)
                                        .primaryColor, //change to tag color
                                    value:
                                        _isCompletedSample, //*task.isCompleted(),
                                    onChanged: (value) {
                                      setState(() {
                                        _isCompletedSample == false
                                            ? _isCompletedSample = true
                                            : _isCompletedSample = false;
                                      });
                                    },
                                    title: Text("${items[index]["taskName"]}",
                                        style: GoogleFonts.karla().copyWith(
                                            color:
                                                Theme.of(context).accentColor,
                                            fontSize: 18,
                                            fontWeight: FontWeight.w500)));
                              },
                            ),
                          ),
                        ],
                      );
                    },
                  );
  }
}

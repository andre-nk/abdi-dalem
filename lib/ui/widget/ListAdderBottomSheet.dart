part of 'widgets.dart';

class ListAdderBottomSheet extends StatefulWidget {
  final ColorSelection colorSelectionLocal = new ColorSelection();
  final User currentUser;
  final FirebaseFirestore firestore;
  final DocumentReference toDoCollection;

  ListAdderBottomSheet({this.currentUser, this.firestore, this.toDoCollection});

  @override
  _ListAdderBottomSheetState createState() => _ListAdderBottomSheetState();
}

class _ListAdderBottomSheetState extends State<ListAdderBottomSheet> {
  @override
  Widget build(BuildContext context) {
    List<dynamic> data = [];
    List<dynamic> data2 = [];
    TextEditingController listNameController = new TextEditingController();
    String selectedColor;
    Widget errorText;

    return SingleChildScrollView(
      child: BottomSheet(
        backgroundColor: Theme.of(context).backgroundColor,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(40), topRight: Radius.circular(40))),
        builder: (ctx) {
          return Container(
            height: MediaQuery.of(context).size.height * 0.4,
            child: Padding(
              padding:
                  EdgeInsets.all(MediaQuery.of(context).size.height * 0.04),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextField(
                    autofocus: true,
                    controller: listNameController,
                    decoration: InputDecoration(
                        fillColor: HexColor("C4C4C4"),
                        border: InputBorder.none,
                        hintText: "Type task list name...",
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
                  SizedBox(height: MediaQuery.of(context).size.height * 0.005),
                  Text("Choose your list color",
                      style: GoogleFonts.montserrat(
                          color: Theme.of(context).accentColor,
                          fontSize: 16,
                          fontWeight: FontWeight.w400)),
                  Container(
                      height: MediaQuery.of(context).size.height * 0.1,
                      child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount:
                              widget.colorSelectionLocal.colorSelection.length,
                          itemBuilder: (context, index) {
                            return IconButton(
                              padding: EdgeInsets.all(0),
                              color: HexColor(widget
                                  .colorSelectionLocal.colorSelection[index]),
                              icon: Icon(Icons.circle,
                                  size: MediaQuery.of(context).size.height *
                                      0.04),
                              onPressed: () {
                                selectedColor = widget
                                    .colorSelectionLocal.colorSelection[index];
                              },
                            );
                          })),
                  errorText ?? Text(''),
                  DefaultButton(
                    method: () async {
                      return await widget.toDoCollection.get().then((val) {
                        print(selectedColor);
                        if (val.data()["tags_title"] == null &&
                            val.data()["tags_title"] == null) {
                          widget.toDoCollection.set({
                            "tags_title": ["Inbox", "School", "Daily"],
                            "tags_colors": ["ef476f", "ffd166", "118ab2"]
                          });
                          //TITLE
                          Future.delayed(Duration(milliseconds: 200), () {
                            widget.toDoCollection.get().then((val) {
                              bool _locker = false;
                              data = val.data()["tags_title"];
                              data.forEach((element) {
                                if (listNameController.text == element) {
                                  setState(() {
                                    _locker = true;
                                  });
                                  print("true");
                                }
                              });
                              if (listNameController.text != "" &&
                                  _locker == false) {
                                data.add(listNameController.text);
                                widget.toDoCollection.get().then((val) {
                                  data2 = val.data()["tags_colors"] ?? [];
                                  if (selectedColor != "" &&
                                      selectedColor != null) {
                                    data2.add(selectedColor);
                                    widget.toDoCollection.set({
                                      "tags_colors": data2,
                                      "tags_title": data
                                    });
                                    Navigator.pop(context);
                                    Get.snackbar("List created", "",
                                        isDismissible: true);
                                  } else {
                                    Get.snackbar(
                                      "List color tag is invalid",
                                      "$selectedColor",
                                    );
                                    Future.delayed(Duration(milliseconds: 2000),
                                        () {
                                      Navigator.pop(context);
                                      Future.delayed(
                                          Duration(milliseconds: 500), () {
                                        Navigator.pop(context);
                                      });
                                    });
                                  }
                                });
                              } else {
                                Get.snackbar(
                                  "List name invalid",
                                  "The name is already exist or empty",
                                );
                                Future.delayed(Duration(milliseconds: 2000),
                                    () {
                                  Navigator.pop(context);
                                  Future.delayed(Duration(milliseconds: 500),
                                      () {
                                    Navigator.pop(context);
                                  });
                                });
                              }
                            });
                          });
                        } else {
                          widget.toDoCollection.get().then((val) {
                            bool _locker = false;
                            data = val.data()["tags_title"];
                            data.forEach((element) {
                              if (listNameController.text == element) {
                                setState(() {
                                  _locker = true;
                                });
                                print("true");
                              }
                            });
                            if (listNameController.text != "" &&
                                _locker == false) {
                              data.add(listNameController.text);
                              widget.toDoCollection.get().then((val) {
                                data2 = val.data()["tags_colors"] ?? [];
                                if (selectedColor != "" &&
                                    selectedColor != null) {
                                  data2.add(selectedColor);
                                  widget.toDoCollection.set({
                                    "tags_colors": data2,
                                    "tags_title": data
                                  });
                                  Navigator.pop(context);
                                  Get.snackbar("List created", "",
                                      isDismissible: true);
                                } else {
                                  Get.snackbar(
                                    "List color tag is invalid",
                                    "$selectedColor",
                                  );
                                  Future.delayed(Duration(milliseconds: 2000),
                                      () {
                                    Navigator.pop(context);
                                    Future.delayed(Duration(milliseconds: 500),
                                        () {
                                      Navigator.pop(context);
                                    });
                                  });
                                }
                              });
                            } else {
                              Get.snackbar(
                                "List name invalid",
                                "The name is already exist or empty",
                              );
                              Future.delayed(Duration(milliseconds: 2000), () {
                                Navigator.pop(context);
                                Future.delayed(Duration(milliseconds: 500), () {
                                  Navigator.pop(context);
                                });
                              });
                            }
                          });
                        }
                      });
                    },
                    title: "Confirm",
                  )
                ],
              ),
            ),
          );
        },
        onClosing: () {},
      ),
    );
  }
}

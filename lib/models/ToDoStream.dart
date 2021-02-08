part of "models.dart";

class ToDoObjectStream extends StatefulWidget {
  final String listTitle;
  final bool isMinimized;
  final bool forNumeric;
  final String selectedTags;

  ToDoObjectStream(
      {this.listTitle, this.isMinimized, this.forNumeric, this.selectedTags});

  @override
  _ToDoObjectStreamState createState() => _ToDoObjectStreamState();
}

class _ToDoObjectStreamState extends State<ToDoObjectStream> {
  List<TaskObject> toDoListFiltered = [];
  int outsideIndex = 0;
  bool localCompletedValue;

  @override
  Widget build(BuildContext context) {
    List<TaskObject> toDoList = Provider.of<List<TaskObject>>(context) ?? [];
    Widget toDoListLength = Text(
      "${0}" + " task(s)",
      style:
          GoogleFonts.karla(color: Theme.of(context).accentColor, fontSize: 16),
    );

    final List<String> filterOptions = [
      "all",
      "completed",
      "no deadline",
      "today",
      "yesterday",
      "this week"
    ];

    void listGenerator(int selectedIndex) {
      toDoListFiltered = [];
      if (widget.listTitle != null) {
        toDoList.forEach((element) {
          if (element.tags.contains(widget.listTitle) && element.task != "") {
            setState(() {
              toDoListFiltered.add(element);
              toDoListLength = Text(
                "${toDoListFiltered.length}" + " task(s)",
                style: GoogleFonts.karla(
                    color: Theme.of(context).accentColor, fontSize: 16),
              );
            });
          }
        });
      } else if (filterOptions[selectedIndex] != null) {
        switch (filterOptions[selectedIndex]) {
          case "completed":
            print(filterOptions[selectedIndex]);
            toDoList.forEach((element) {
              if (element.completed == true && element.task != "") {
                setState(() {
                  toDoListFiltered.add(element);
                  toDoListLength = Text(
                    "${toDoListFiltered.length}" + " task(s)",
                    style: GoogleFonts.karla(
                        color: Theme.of(context).accentColor, fontSize: 16),
                  );
                });
              }
            });
            break;
          case "no deadline":
            toDoList.forEach((element) {
              if (element.date == "No deadline" && element.task != "") {
                setState(() {
                  toDoListFiltered.add(element);
                  toDoListLength = Text(
                    "${toDoListFiltered.length}" + " task(s)",
                    style: GoogleFonts.karla(
                        color: Theme.of(context).accentColor, fontSize: 16),
                  );
                });
              }
            });
            break;
          case "today":
            toDoList.forEach((element) {
              DateTime date = new DateFormat("dd-MM-yyyy")
                  .parse(element.date.replaceAll("-", ""));
              print(date);
              if (element.task != "") {
                setState(() {
                  toDoListFiltered.add(element);
                  toDoListLength = Text(
                    "${toDoListFiltered.length}" + " task(s)",
                    style: GoogleFonts.karla(
                        color: Theme.of(context).accentColor, fontSize: 16),
                  );
                });
              }
            });
            break;
          case "all":
            toDoList.forEach((element) {
              if (element.tags.contains(widget.listTitle) &&
                  element.task != "") {
                setState(() {
                  toDoListFiltered.add(element);
                  toDoListLength = Text(
                    "${toDoListFiltered.length}" + " task(s)",
                    style: GoogleFonts.karla(
                        color: Theme.of(context).accentColor, fontSize: 16),
                  );
                });
              }
            });
            break;
        }
      } else {
        toDoList.forEach((element) {
          if (element.task != "") {
            setState(() {
              toDoListFiltered.add(element);
            });
          }
        });
      }
    }

    return widget.forNumeric == true
        ? toDoListLength
        : widget.listTitle == null
            ? Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    alignment: Alignment.topCenter,
                    height: MediaQuery.of(context).size.height * 0.45,
                    child: ListView.builder(
                      physics: BouncingScrollPhysics(),
                      scrollDirection: Axis.vertical,
                      itemCount: toDoListFiltered.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onLongPress: () {
                            showModalBottomSheet(
                                backgroundColor: Colors.transparent,
                                isScrollControlled: true,
                                context: context,
                                builder: (BuildContext context) {
                                  return Padding(
                                    padding: EdgeInsets.only(
                                        bottom: MediaQuery.of(context)
                                            .viewInsets
                                            .bottom),
                                    child: ToDoPreviewerBottomSheet(
                                        widget.listTitle,
                                        toDoListFiltered[index].task,
                                        toDoListFiltered[index].description,
                                        toDoListFiltered[index].date,
                                        toDoListFiltered[index].uid),
                                  );
                                });
                          },
                          child: Dismissible(
                            onDismissed: (direction) {
                              toDoListFiltered[index].uid != null
                                  ? DatabaseServices().deleteToDoTask(
                                      toDoListFiltered[index].uid)
                                  : Get.snackbar(
                                      "Error", "This task is unlisted");
                              setState(() {});
                            },
                            key: UniqueKey(),
                            child: CustomCheckboxListTile(
                                activeColor: Theme.of(context)
                                    .primaryColor, //change to tag color
                                value: toDoListFiltered[index]
                                    .completed, //*task.isCompleted(),
                                onChanged: (value) {
                                  print(toDoListFiltered[index].completed);
                                  if (toDoListFiltered[index].completed ==
                                      false) {
                                    DatabaseServices().updateToDoTask(
                                        context: context,
                                        completedValue: true,
                                        indexUID: toDoListFiltered[index].uid);
                                    setState(() {});
                                  } else {
                                    DatabaseServices().updateToDoTask(
                                        context: context,
                                        completedValue: false,
                                        indexUID: toDoListFiltered[index].uid);
                                    setState(() {});
                                  }
                                },
                                title: Text(
                                    "${toDoListFiltered[index].task ?? ""}",
                                    style: GoogleFonts.karla().copyWith(
                                        color: Theme.of(context).accentColor,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w500))),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              )
            : Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SelectionButtons(
                    titles: filterOptions,
                    selectedIndex: outsideIndex,
                    onTap: (index) {
                      setState(() {
                        listGenerator(index);
                        outsideIndex = index;
                      });
                    },
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.025),
                  Container(
                    height: MediaQuery.of(context).size.height * 0.55,
                    child: ListView.builder(
                      physics: BouncingScrollPhysics(),
                      scrollDirection: Axis.vertical,
                      itemCount: toDoListFiltered.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onLongPress: () {
                            showModalBottomSheet(
                                backgroundColor: Colors.transparent,
                                isScrollControlled: true,
                                context: context,
                                builder: (BuildContext context) {
                                  return Padding(
                                    padding: EdgeInsets.only(
                                        bottom: MediaQuery.of(context)
                                            .viewInsets
                                            .bottom),
                                    child: ToDoPreviewerBottomSheet(
                                        widget.listTitle,
                                        toDoListFiltered[index].task,
                                        toDoListFiltered[index].description,
                                        toDoListFiltered[index].date,
                                        toDoListFiltered[index].uid),
                                  );
                                });
                          },
                          child: Dismissible(
                            onDismissed: (direction) {
                              toDoListFiltered[index].uid != null
                                  ? DatabaseServices().deleteToDoTask(
                                      toDoListFiltered[index].uid)
                                  : Get.snackbar(
                                      "Error", "This task is unlisted");
                              setState(() {});
                            },
                            key: UniqueKey(),
                            child: CustomCheckboxListTile(
                                activeColor: Theme.of(context)
                                    .primaryColor, //change to tag color
                                value: toDoListFiltered[index]
                                    .completed, //*task.isCompleted(),
                                onChanged: (value) {
                                  setState(() {
                                    toDoListFiltered[index].completed == false
                                        ? DatabaseServices().updateToDoTask(
                                            context: context,
                                            completedValue: true,
                                            indexUID:
                                                toDoListFiltered[index].uid)
                                        : DatabaseServices().updateToDoTask(
                                            context: context,
                                            completedValue: false,
                                            indexUID:
                                                toDoListFiltered[index].uid);
                                  });
                                },
                                title: Text("${toDoListFiltered[index].task}",
                                    style: GoogleFonts.karla().copyWith(
                                        color: Theme.of(context).accentColor,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w500))),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              );
  }
}

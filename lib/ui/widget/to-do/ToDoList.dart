part of '../widgets.dart';

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
  List<TaskObject> toDoTasksFiltered = [];
  int outsideIndex = 0;
  bool localCompletedValue;

  @override
  Widget build(BuildContext context) {
    List<TaskObject> toDoTasks = Provider.of<List<TaskObject>>(context);

    Widget toDoTasksLength = Text(
      "${toDoTasks.length}" + " task(s)",
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
      toDoTasksFiltered = [];
      if (widget.listTitle != null) {
        toDoTasks.forEach((element) {
          if (element.tags.contains(widget.listTitle) && element.task != "") {
            setState(() {
              toDoTasksFiltered.add(element);
              toDoTasksLength = Text(
                "${toDoTasksFiltered.length}" + " task(s)",
                style: GoogleFonts.karla(
                    color: Theme.of(context).accentColor, fontSize: 16),
              );
            });
          }
        });
      } else if (outsideIndex != null) {
        print("a");
        print(outsideIndex);
        switch (outsideIndex) {
          case 1:
            print("compl");
            toDoTasks.forEach((element) {
              if (element.completed == true && element.task != "") {
                toDoTasksFiltered.add(element);
                toDoTasksLength = Text(
                  "${toDoTasksFiltered.length}" + " task(s)",
                  style: GoogleFonts.karla(
                      color: Theme.of(context).accentColor, fontSize: 16),
                );
              }
            });
            break;
          case 2:
            print("no dl");
            toDoTasks.forEach((element) {
              if (element.date == "No deadline" && element.task != "") {
                setState(() {
                  toDoTasksFiltered.add(element);
                  toDoTasksLength = Text(
                    "${toDoTasksFiltered.length}" + " task(s)",
                    style: GoogleFonts.karla(
                        color: Theme.of(context).accentColor, fontSize: 16),
                  );
                });
              }
            });
            break;
          case 3:
            print("today");
            toDoTasks.forEach((element) {
              // DateTime date = new DateFormat("dd-MM-yyyy")
              //     .parse(element.date.replaceAll("-", ""));
              if (element.task != "") {
                setState(() {
                  toDoTasksFiltered.add(element);
                  toDoTasksLength = Text(
                    "${toDoTasksFiltered.length}" + " task(s)",
                    style: GoogleFonts.karla(
                        color: Theme.of(context).accentColor, fontSize: 16),
                  );
                });
              }
            });
            break;
          case 0:
            print("all");
            toDoTasks.forEach((element) {
              if (element.tags.contains(widget.listTitle) &&
                  element.task != "") {
                setState(() {
                  toDoTasksFiltered.add(element);
                  toDoTasksLength = Text(
                    "${toDoTasksFiltered.length}" + " task(s)",
                    style: GoogleFonts.karla(
                        color: Theme.of(context).accentColor, fontSize: 16),
                  );
                });
              }
            });
            break;
        }
      } else {
        toDoTasks.forEach((element) {
          if (element.task != "") {
            setState(() {
              toDoTasksFiltered.add(element);
            });
          }
        });
      }
    }

    return widget.forNumeric == true
        ? toDoTasksLength
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
                      itemCount: toDoTasksFiltered.length,
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
                                        toDoTasksFiltered[index].task,
                                        toDoTasksFiltered[index].description,
                                        toDoTasksFiltered[index].date,
                                        toDoTasksFiltered[index].uid),
                                  );
                                });
                          },
                          child: Dismissible(
                            onDismissed: (direction) {
                              toDoTasksFiltered[index].uid != null
                                  ? ToDoServices().deleteToDoTask(
                                      toDoTasksFiltered[index].uid)
                                  : Get.snackbar(
                                      "Error", "This task is unlisted");
                              setState(() {});
                            },
                            key: UniqueKey(),
                            child: CustomCheckboxListTile(
                                activeColor: Theme.of(context)
                                    .primaryColor, //change to tag color
                                value: toDoTasksFiltered[index]
                                    .completed, //*task.isCompleted(),
                                onChanged: (value) {
                                  print(toDoTasksFiltered[index].completed);
                                  if (toDoTasksFiltered[index].completed ==
                                      false) {
                                    ToDoServices().updateToDoTask(
                                        context: context,
                                        completedValue: true,
                                        indexUID: toDoTasksFiltered[index].uid);
                                    setState(() {});
                                  } else {
                                    ToDoServices().updateToDoTask(
                                        context: context,
                                        completedValue: false,
                                        indexUID: toDoTasksFiltered[index].uid);
                                    setState(() {});
                                  }
                                },
                                title: Text(
                                    "${toDoTasksFiltered[index].task ?? ""}",
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
                        print(outsideIndex);
                      });
                    },
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.025),
                  Container(
                    height: MediaQuery.of(context).size.height * 0.55,
                    child: ListView.builder(
                      physics: BouncingScrollPhysics(),
                      scrollDirection: Axis.vertical,
                      itemCount: toDoTasksFiltered.length,
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
                                        toDoTasksFiltered[index].task,
                                        toDoTasksFiltered[index].description,
                                        toDoTasksFiltered[index].date,
                                        toDoTasksFiltered[index].uid),
                                  );
                                });
                          },
                          child: Dismissible(
                            onDismissed: (direction) {
                              toDoTasksFiltered[index].uid != null
                                  ? ToDoServices().deleteToDoTask(
                                      toDoTasksFiltered[index].uid)
                                  : Get.snackbar(
                                      "Error", "This task is unlisted");
                              setState(() {});
                            },
                            key: UniqueKey(),
                            child: CustomCheckboxListTile(
                                activeColor: Theme.of(context)
                                    .primaryColor, //change to tag color
                                value: toDoTasksFiltered[index]
                                    .completed, //*task.isCompleted(),
                                onChanged: (value) {
                                  setState(() {
                                    toDoTasksFiltered[index].completed == false
                                        ? ToDoServices().updateToDoTask(
                                            context: context,
                                            completedValue: true,
                                            indexUID:
                                                toDoTasksFiltered[index].uid)
                                        : ToDoServices().updateToDoTask(
                                            context: context,
                                            completedValue: false,
                                            indexUID:
                                                toDoTasksFiltered[index].uid);
                                  });
                                },
                                title: Text("${toDoTasksFiltered[index].task}",
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

part of "models.dart";

class ToDoObjectStream extends StatefulWidget {
  final String listTitle;
  final bool isMinimized;
  final bool forNumeric;
  final String index;

  ToDoObjectStream(
      {this.listTitle, this.isMinimized, this.forNumeric, this.index});

  @override
  _ToDoObjectStreamState createState() => _ToDoObjectStreamState();
}

class _ToDoObjectStreamState extends State<ToDoObjectStream> {

  List<TaskObject> toDoListFiltered = [];

  @override
  Widget build(BuildContext context) {

    List<TaskObject> toDoList = Provider.of<List<TaskObject>>(context) ?? [];
    bool _isCompletedSample = false;

    if (widget.listTitle != null) {
      toDoList.forEach((element) {
        if (element.tags.contains(widget.listTitle) && element.task != "") {
          setState(() {
            toDoListFiltered.add(element);
          });
        }
      });
    }

    return widget.forNumeric == true
        ? Text(
            "${toDoListFiltered.length ?? "0"}" + " task(s)",
            style: GoogleFonts.karla(
                color: Theme.of(context).accentColor, fontSize: 16),
          )
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
                      itemCount: toDoList.length,
                      itemBuilder: (context, index) {
                        return CustomCheckboxListTile(
                            activeColor: Theme.of(context)
                                .primaryColor, //change to tag color
                            value: _isCompletedSample, //*task.isCompleted(),
                            onChanged: (value) {
                              setState(() {
                                _isCompletedSample == false
                                    ? _isCompletedSample = true
                                    : _isCompletedSample = false;
                              });
                            },
                            title: Text("${toDoList[index].task ?? ""}",
                                style: GoogleFonts.karla().copyWith(
                                    color: Theme.of(context).accentColor,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500)));
                      },
                    ),
                  ),
                ],
              )
            : widget.isMinimized == true
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        height: MediaQuery.of(context).size.height * 0.2,
                        child: ListView.builder(
                          physics: BouncingScrollPhysics(),
                          scrollDirection: Axis.vertical,
                          itemCount: toDoList.length,
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
                                title: Text("${toDoList[index].task ?? ""}",
                                    style: GoogleFonts.karla().copyWith(
                                        color: Theme.of(context).accentColor,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w500)));
                          },
                        ),
                      ),
                    ],
                  )
                : Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        height: MediaQuery.of(context).size.height * 0.55,
                        child: ListView.builder(
                          physics: BouncingScrollPhysics(),
                          scrollDirection: Axis.vertical,
                          itemCount: toDoListFiltered.length,
                          itemBuilder: (context, index) {
                            return CustomCheckboxListTile(
                                activeColor: Theme.of(context)
                                    .primaryColor, //change to tag color
                                value: toDoListFiltered[index]
                                    .completed, //*task.isCompleted(),
                                onChanged: (value) {
                                  setState(() {
                                    toDoListFiltered[index].completed == false
                                        ? toDoListFiltered[index].completed =
                                            true
                                        : toDoListFiltered[index].completed =
                                            false;
                                  });
                                },
                                title: Text("${toDoListFiltered[index].task}",
                                    style: GoogleFonts.karla().copyWith(
                                        color: Theme.of(context).accentColor,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w500)));
                          },
                        ),
                      ),
                    ],
                  );
  }
}

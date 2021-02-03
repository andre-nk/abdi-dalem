part of '../../models/models.dart';

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
    List<TaskObject> toDoList = Provider.of<List<TaskObject>>(context) ?? [];
    bool _isCompletedSample = false;

    return widget.forNumeric == true
        ? Text(
            "${toDoList.length ?? "0"}" + " task(s)",
            style: GoogleFonts.karla(
                color: Theme.of(context).accentColor, fontSize: 16),
          )
        : widget.listTitle == null
            ? Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    alignment: Alignment.topCenter,
                    height: MediaQuery.of(context).size.height * 0.3,
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
                        height: MediaQuery.of(context).size.height * 0.3,
                        child: ListView.builder(
                          physics: BouncingScrollPhysics(),
                          scrollDirection: Axis.vertical,
                          itemCount: toDoList.length,
                          itemBuilder: (context, index) {
                            print(toDoList[index]);
                            return CustomCheckboxListTile(
                                activeColor: Theme.of(context)
                                    .primaryColor, //change to tag color
                                value: toDoList[index].completed, //*task.isCompleted(),
                                onChanged: (value) {
                                  setState(() {
                                    toDoList[index].completed == false
                                        ? toDoList[index].completed = true
                                        : toDoList[index].completed = false;
                                  });
                                },
                                title: Text("${toDoList[index].task}",
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

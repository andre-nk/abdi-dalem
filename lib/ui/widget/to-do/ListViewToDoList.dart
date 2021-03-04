part of "../widgets.dart";

class ListViewToDoList extends StatefulWidget {
  @override
  _ListViewToDoListState createState() => _ListViewToDoListState();
}

class _ListViewToDoListState extends State<ListViewToDoList> {
  bool showList = true;

  @override
  Widget build(BuildContext context) {
    List<ToDoListCard> toDoList = Provider.of<List<ToDoListCard>>(context);

    return ListView(
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
              height: MediaQuery.of(context).size.width * 0.12,
              width: MediaQuery.of(context).size.width * 0.12,
              child: ElevatedButton(
                onPressed: () {
                  showModalBottomSheet(
                      backgroundColor: Colors.transparent,
                      isScrollControlled: true,
                      context: context,
                      builder: (BuildContext context) {
                        return Padding(
                          padding: EdgeInsets.only(
                              bottom: MediaQuery.of(context).viewInsets.bottom),
                          child: ListAdderBottomSheet(),
                        );
                      });
                },
                style: ElevatedButton.styleFrom(
                  primary: Theme.of(context).primaryColor,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0)),
                ),
                child: Icon(
                  FlutterIcons.plus_ant,
                  size: MediaQuery.of(context).size.height * 0.025,
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
                decoration: BoxDecoration(
                    color: HexColor("C4C4C4").withOpacity(0.2),
                    borderRadius: BorderRadius.all(Radius.circular(15))),
                child: TextField(
                  autofocus: false,
                  textAlign: TextAlign.left,
                  decoration: new InputDecoration(
                      border: new OutlineInputBorder(
                          borderRadius: const BorderRadius.all(
                            const Radius.circular(10.0),
                          ),
                          borderSide: BorderSide.none),
                      filled: true,
                      hintStyle: GoogleFonts.karla(
                          color: Theme.of(context).accentColor, fontSize: 16),
                      hintText: "Search task...",
                      fillColor: HexColor("C4C4C4").withOpacity(0.05)),
                  onChanged: (_) {},
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
                        horizontal: MediaQuery.of(context).size.width * 0.055),
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
                  SizedBox(height: MediaQuery.of(context).size.height * 0.0275),
                  Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: MediaQuery.of(context).size.width * 0.05),
                      height: MediaQuery.of(context).size.height * 0.4,
                      child: ListView.builder(
                        physics: BouncingScrollPhysics(),
                        scrollDirection: Axis.horizontal,
                        itemExtent: MediaQuery.of(context).size.width * 0.8,
                        itemCount: toDoList != null ? toDoList.length : 0,
                        itemBuilder: (BuildContext context, index) {
                          return toDoList[index];
                        },
                      ))
                ],
              )
            : Column(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: MediaQuery.of(context).size.width * 0.055),
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
                            height:
                                MediaQuery.of(context).size.height * 0.0275),
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
    );
  }
}

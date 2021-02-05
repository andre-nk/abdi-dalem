part of 'widgets.dart';

class ToDoAdderBottomSheet extends StatefulWidget {
  final String title;

  ToDoAdderBottomSheet(this.title);

  @override
  _ToDoAdderBottomSheetState createState() => _ToDoAdderBottomSheetState();
}

class _ToDoAdderBottomSheetState extends State<ToDoAdderBottomSheet> {
  DateTime pickedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    final User currentUser = FirebaseAuth.instance.currentUser;

    FirebaseFirestore firestore = FirebaseFirestore.instance;
    CollectionReference toDoDocument = firestore
        .collection("users")
        .doc(currentUser.uid)
        .collection("to-do-collection");

    DateFormat formatter = DateFormat('dd-MM-yyyy');

    TextEditingController nameController = new TextEditingController();
    TextEditingController descriptionController = new TextEditingController();

    print(pickedDate);

    return BottomSheet(
      backgroundColor: Theme.of(context).backgroundColor,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(40), topRight: Radius.circular(40))),
      builder: (ctx) {
        return Container(
          height: MediaQuery.of(context).size.height * 0.55,
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Padding(
              padding:
                  EdgeInsets.all(MediaQuery.of(context).size.height * 0.04),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextField(
                    autofocus: true,
                    controller: nameController,
                    decoration: InputDecoration(
                        contentPadding: EdgeInsets.only(
                            left: MediaQuery.of(context).size.width * 0.01),
                        fillColor: HexColor("C4C4C4"),
                        border: InputBorder.none,
                        hintText: "Type task name...",
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
                  SizedBox(height: MediaQuery.of(context).size.height * 0.02),
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
                        fillColor: HexColor("C4C4C4").withOpacity(0.2),
                        hintText: "Task description...",
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
                  SizedBox(height: MediaQuery.of(context).size.height * 0.025),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text("${formatter.format(this.pickedDate)}",
                          textAlign: TextAlign.center,
                          style: GoogleFonts.karla().copyWith(
                              color: Theme.of(context).accentColor,
                              fontSize: 18,
                              fontWeight: FontWeight.w500)),
                      GestureDetector(
                          onTap: () async {
                            final selectedDate = await showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                initialDatePickerMode: DatePickerMode.day,
                                firstDate: DateTime(1800),
                                lastDate: DateTime(2500));

                            if (selectedDate == null) return;
                            print(selectedDate);

                            // setState(() {
                            //   nameController.text = nameController.text;
                            //   descriptionController.text = descriptionController.text;
                            this.pickedDate = selectedDate;
                            // });
                          },
                          child: Icon(FlutterIcons.ios_calendar_ion))
                    ],
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.025),
                  DefaultButton(
                    method: () async {
                      if (nameController.text != null || widget.title != null) {
                        toDoDocument.add({
                          "taskName": nameController.text,
                          "taskDescription": descriptionController.text,
                          "date": this.pickedDate,
                          "isCompleted": false,
                          "tags": [widget.title]
                        });
                        Navigator.pop(context);
                      } else {
                        Get.snackbar("You haven't entered the title",
                            "Please enter the task title firstly");
                        nameController.text = '';
                        descriptionController.text = '';
                      }
                    },
                    title: "Confirm",
                  )
                ],
              ),
            ),
          ),
        );
      },
      onClosing: () {},
    );
  }
}

class ToDoPreviewerBottomSheet extends StatefulWidget {
  final String title;
  final String listTitle;
  final String description;
  final String pickedDate;
  final String indexUID;

  ToDoPreviewerBottomSheet(this.listTitle, this.title, this.description, this.pickedDate, this.indexUID);

  @override
  _ToDoPreviewerBottomSheetState createState() =>
      _ToDoPreviewerBottomSheetState();
}

class _ToDoPreviewerBottomSheetState extends State<ToDoPreviewerBottomSheet> {
  @override
  Widget build(BuildContext context) {
    final User currentUser = FirebaseAuth.instance.currentUser;

    FirebaseFirestore firestore = FirebaseFirestore.instance;
    CollectionReference toDoDocument = firestore
        .collection("users")
        .doc(currentUser.uid)
        .collection("to-do-collection");

    DateFormat formatter = DateFormat('dd-MM-yyyy');

    TextEditingController nameController = new TextEditingController();
    TextEditingController descriptionController = new TextEditingController();
    String pickedDate;
    if(widget.pickedDate.length <= 18){
      pickedDate = widget.pickedDate;
    }else{
      pickedDate = "No deadline";
    }

    return BottomSheet(
      backgroundColor: Theme.of(context).backgroundColor,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(40), topRight: Radius.circular(40))),
      builder: (ctx) {
        return Container(
          height: MediaQuery.of(context).size.height * 0.55,
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Padding(
              padding:
                  EdgeInsets.all(MediaQuery.of(context).size.height * 0.04),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextField(
                    autofocus: true,
                    controller: nameController,
                    decoration: InputDecoration(
                        contentPadding: EdgeInsets.only(
                            left: MediaQuery.of(context).size.width * 0.01),
                        fillColor: HexColor("C4C4C4"),
                        border: InputBorder.none,
                        hintText: widget.title ?? "",
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
                  SizedBox(height: MediaQuery.of(context).size.height * 0.02),
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
                        fillColor: HexColor("C4C4C4").withOpacity(0.2),
                        hintText: widget.description ?? "", 
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
                  SizedBox(height: MediaQuery.of(context).size.height * 0.025),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text("${pickedDate ?? widget.pickedDate}",
                          textAlign: TextAlign.center,
                          style: GoogleFonts.karla().copyWith(
                              color: Theme.of(context).accentColor,
                              fontSize: 18,
                              fontWeight: FontWeight.w500)),
                      GestureDetector(
                          onTap: () async {
                            final selectedDate = await showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                initialDatePickerMode: DatePickerMode.day,
                                firstDate: DateTime(1800),
                                lastDate: DateTime(2500));

                            if (selectedDate == null) return;
                            print(selectedDate);

                            // setState(() {
                            //   nameController.text = nameController.text;
                            //   descriptionController.text = descriptionController.text;
                            pickedDate = formatter.format(selectedDate);
                            // });
                          },
                          child: Icon(FlutterIcons.ios_calendar_ion))
                    ],
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.025),
                  DefaultButton(
                    method: () async {
                      if (nameController.text != null || widget.title != null) {
                        toDoDocument.doc(widget.indexUID).update({
                          "taskName": nameController.text,
                          "taskDescription": descriptionController.text,
                          "date": pickedDate,
                          "isCompleted": false,
                          "tags": [widget.listTitle],
                        });
                        Navigator.pop(context);
                      } else {
                        Get.snackbar("You haven't entered the title",
                            "Please enter the task title firstly");
                        nameController.text = '';
                        descriptionController.text = '';
                      }
                    },
                    title: "Confirm",
                  )
                ],
              ),
            ),
          ),
        );
      },
      onClosing: () {},
    );
  }
}

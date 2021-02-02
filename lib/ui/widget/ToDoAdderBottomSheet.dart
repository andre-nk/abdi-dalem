part of 'widgets.dart';

class ToDoAdderBottomSheet extends StatefulWidget {
  final String title;

  ToDoAdderBottomSheet(this.title);

  @override
  _ToDoAdderBottomSheetState createState() => _ToDoAdderBottomSheetState();
}

class _ToDoAdderBottomSheetState extends State<ToDoAdderBottomSheet> {
  @override
  Widget build(BuildContext context) {
    final User currentUser = FirebaseAuth.instance.currentUser;

    FirebaseFirestore firestore = FirebaseFirestore.instance;
    CollectionReference toDoDocument = firestore
        .collection("users")
        .doc(currentUser.uid)
        .collection("to-do-collection");

    String pickedDate;
    DateFormat formatter = DateFormat('dd-MM-yyyy');

    TextEditingController nameController = new TextEditingController();
    TextEditingController descriptionController = new TextEditingController();

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
              padding: EdgeInsets.all(MediaQuery.of(context).size.height * 0.04),
              child: Column(
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
                  GestureDetector(
                    onTap: () async {
                      pickedDate = formatter
                          .format(await DatePicker.showSimpleDatePicker(
                        context,
                        backgroundColor: Theme.of(context).backgroundColor,
                        textColor: Theme.of(context).accentColor,
                        confirmText: "Next",
                        initialDate: DateTime.now(),
                        firstDate: DateTime(1900),
                        lastDate: DateTime(3000),
                        dateFormat: "dd-MMMM-yyyy",
                        locale: DateTimePickerLocale.en_us,
                        looping: true,
                      ));
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text("${pickedDate ?? "Set deadline"}",
                            textAlign: TextAlign.center,
                            style: GoogleFonts.karla().copyWith(
                                color: Theme.of(context).accentColor,
                                fontSize: 18,
                                fontWeight: FontWeight.w500)),
                        Icon(FlutterIcons.ios_calendar_ion)
                      ],
                    ),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.025),
                  DefaultButton(
                    method: () async {
                      if (nameController.text != null || widget.title != null) {
                        toDoDocument.add({
                          "taskName": nameController.text,
                          "taskDescription": descriptionController.text,
                          "date": pickedDate,
                          "isCompleted": false,
                          "tags": [widget.title]
                        });
                        Navigator.pop(context);
                      } else {
                        Get.snackbar("You haven't entered the title", "Please enter the task title firstly"); 
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

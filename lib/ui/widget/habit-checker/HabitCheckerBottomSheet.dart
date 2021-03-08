part of "../widgets.dart";

class HabitCheckerBottomSheet extends StatefulWidget {
  HabitCheckerBottomSheet({Key key}) : super(key: key);

  @override
  _HabitCheckerBottomSheetState createState() =>
      _HabitCheckerBottomSheetState();
}

class _HabitCheckerBottomSheetState extends State<HabitCheckerBottomSheet> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  bool isDaily = true;
  List<HabitReminder> pickedDate = [];
  List<String> daysPicked = []; //forWeeklyType

  @override
  Widget build(BuildContext context) {
    return BottomSheet(
      onClosing: () {},
      backgroundColor: Theme.of(context).backgroundColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(40),
          topRight: Radius.circular(40)
        )
      ),
      builder: (ctx) {
        return SingleChildScrollView(
          child: Container(height: MediaQuery.of(context).size.height * 0.55,
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
                              left:
                                  MediaQuery.of(context).size.width *
                                      0.01),
                          fillColor: HexColor("C4C4C4"),
                          border: InputBorder.none,
                          hintText: "The habit name...",
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
                        height: MediaQuery.of(context).size.height *
                            0.02),
                    TextField(
                      maxLines: 2,
                      minLines: 2,
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
                          hintText: "Motivational punchline...",
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
                      height: MediaQuery.of(context).size.height * 0.05),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text("${isDaily ? "Daily" : "Weekly"}",
                          textAlign: TextAlign.center,
                            style: GoogleFonts.karla().copyWith(
                                color: Theme.of(context).accentColor,
                                fontSize: 18,
                                fontWeight: FontWeight.w500)
                        ),
                        SizedBox(height: MediaQuery.of(context).size.height * 0.05),
                        Switch(
                          value: isDaily,
                          onChanged: (_){
                            setState((){
                              isDaily = !isDaily;
                            });
                          },
                          activeColor: Theme.of(context).primaryColor,                       
                        )
                      ],
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.025),
                    isDaily
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text("Reminders (optional)",
                              textAlign: TextAlign.center,
                              style: GoogleFonts.karla().copyWith(
                                  color: Theme.of(context).accentColor,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500)),
                          GestureDetector(
                              onTap: () async {
                                final selectedTime = await showTimePicker(
                                    context: context,
                                    initialTime: TimeOfDay.now()
                                );

                                pickedDate.add(HabitReminder(
                                  dayName: "Daily",
                                  dayTime: selectedTime.toString()
                                ));

                                setState((){});
                              },
                              child: Padding(
                                padding: const EdgeInsets.only(right: 10),
                                child: Icon(FlutterIcons.clock_faw5, size: 22),
                              ))
                        ],
                      )
                    : Column(
                      children: [
                        Wrap(
                          spacing: 10.0, // gap between adjacent chips
                          runSpacing: 10.0, // gap between lines
                          children: <Widget>[
                            GestureDetector(
                              onTap: (){
                                daysPicked.contains("Monday")
                                ? daysPicked.remove("Monday")
                                : daysPicked.add("Monday");
                                setState((){});
                              },
                              child: Chip(
                                labelPadding: EdgeInsets.symmetric(
                                  horizontal: 20,
                                  vertical: 5,
                                ),
                                backgroundColor: daysPicked.contains("Monday")
                                  ? Theme.of(context).primaryColor
                                  : HexColor("C4C4C4").withOpacity(0.2),
                                elevation: 0,                                  
                                label: Text('Monday',
                                  textAlign: TextAlign.center,
                                    style: GoogleFonts.karla().copyWith(
                                        color: Theme.of(context).accentColor,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w500)
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: (){
                                daysPicked.contains("Tuesday")
                                ? daysPicked.remove("Tuesday")
                                : daysPicked.add("Tuesday");
                                setState((){});
                              },
                              child: Chip(
                                labelPadding: EdgeInsets.symmetric(
                                  horizontal: 20,
                                  vertical: 5,
                                ),
                                backgroundColor: daysPicked.contains("Tuesday")
                                  ? Theme.of(context).primaryColor
                                  : HexColor("C4C4C4").withOpacity(0.2),
                                elevation: 0,                                  
                                label: Text('Tuesday',
                                  textAlign: TextAlign.center,
                                    style: GoogleFonts.karla().copyWith(
                                        color: Theme.of(context).accentColor,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w500)
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: (){
                                daysPicked.contains("Wednesday")
                                ? daysPicked.remove("Wednesday")
                                : daysPicked.add("Wednesday");
                                setState((){});
                              },
                              child: Chip(
                                labelPadding: EdgeInsets.symmetric(
                                  horizontal: 20,
                                  vertical: 5,
                                ),
                                backgroundColor: daysPicked.contains("Wednesday")
                                  ? Theme.of(context).primaryColor
                                  : HexColor("C4C4C4").withOpacity(0.2),
                                elevation: 0,                                  
                                label: Text('Wednesday',
                                  textAlign: TextAlign.center,
                                    style: GoogleFonts.karla().copyWith(
                                        color: Theme.of(context).accentColor,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w500)
                                ),
                              )
                            ),
                            GestureDetector(
                              onTap: (){
                                daysPicked.contains("Thursday")
                                ? daysPicked.remove("Thursday")
                                : daysPicked.add("Thursday");
                                setState((){});
                              },
                              child: Chip(
                                labelPadding: EdgeInsets.symmetric(
                                  horizontal: 20,
                                  vertical: 5,
                                ),
                                backgroundColor: daysPicked.contains("Thursday")
                                  ? Theme.of(context).primaryColor
                                  : HexColor("C4C4C4").withOpacity(0.2),
                                elevation: 0,                                  
                                label: Text('Thursday',
                                  textAlign: TextAlign.center,
                                    style: GoogleFonts.karla().copyWith(
                                        color: Theme.of(context).accentColor,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w500)
                                ),
                              )
                            ),
                            GestureDetector(
                              onTap: (){
                                daysPicked.contains("Friday")
                                ? daysPicked.remove("Friday")
                                : daysPicked.add("Friday");
                                setState((){});
                              },
                              child: Chip(
                                labelPadding: EdgeInsets.symmetric(
                                  horizontal: 20,
                                  vertical: 5,
                                ),
                                backgroundColor: daysPicked.contains("Friday")
                                  ? Theme.of(context).primaryColor
                                  : HexColor("C4C4C4").withOpacity(0.2),
                                elevation: 0,                                  
                                label: Text('Friday',
                                  textAlign: TextAlign.center,
                                    style: GoogleFonts.karla().copyWith(
                                        color: Theme.of(context).accentColor,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w500)
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: (){
                                daysPicked.contains("Saturday")
                                ? daysPicked.remove("Saturday")
                                : daysPicked.add("Saturday");
                                setState((){});
                              },
                              child: Chip(
                                labelPadding: EdgeInsets.symmetric(
                                  horizontal: 20,
                                  vertical: 5,
                                ),
                                backgroundColor: daysPicked.contains("Saturday")
                                  ? Theme.of(context).primaryColor
                                  : HexColor("C4C4C4").withOpacity(0.2),
                                elevation: 0,                                  
                                label: Text('Saturday',
                                  textAlign: TextAlign.center,
                                    style: GoogleFonts.karla().copyWith(
                                        color: Theme.of(context).accentColor,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w500)
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: (){
                                daysPicked.contains("Sunday")
                                ? daysPicked.remove("Sunday")
                                : daysPicked.add("Sunday");
                                setState((){});
                              },
                              child: Chip(
                                labelPadding: EdgeInsets.symmetric(
                                  horizontal: 20,
                                  vertical: 5,
                                ),
                                backgroundColor: daysPicked.contains("Sunday")
                                  ? Theme.of(context).primaryColor
                                  : HexColor("C4C4C4").withOpacity(0.2),
                                elevation: 0,                                  
                                label: Text('Sunday',
                                  textAlign: TextAlign.center,
                                    style: GoogleFonts.karla().copyWith(
                                        color: Theme.of(context).accentColor,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w500)
                                ),
                              ),
                            ),                        
                          ],
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.05),
                        Container(
                          height: MediaQuery.of(context).size.height * 0.4,
                          child: ListView.builder(
                            itemCount: daysPicked.length,
                            itemBuilder: (BuildContext context, index){
                              return Padding(
                                padding: EdgeInsets.only(bottom: MediaQuery.of(context).size.height * 0.04),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text("Reminder for ${daysPicked[index]} (optional)",
                                      textAlign: TextAlign.center,
                                      style: GoogleFonts.karla().copyWith(
                                          color: Theme.of(context).accentColor,
                                          fontSize: 18,
                                          fontWeight: FontWeight.w500)),
                                    GestureDetector(
                                      onTap: () async {
                                        final selectedTime = await showTimePicker(
                                            context: context,
                                            initialTime: TimeOfDay.now()
                                        );
                                        pickedDate.add(HabitReminder(
                                          dayName: daysPicked[index],
                                          dayTime: selectedTime.toString()
                                        ));
                                        
                                        setState((){});
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.only(right: 10),
                                        child: Icon(FlutterIcons.clock_faw5, size: 22),
                                      )
                                    )
                                  ],
                                ),
                              );
                            },
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height *  0.05),
                    DefaultButton(
                      title: "Create habit",
                      color: Theme.of(context).primaryColor,
                      method: (){
                        print(pickedDate);
                        print(pickedDate is List<HabitReminder>);
                        if(titleController.text != ""){
                          HabitServices().createHabitRecord(
                            titleController.text,
                            descriptionController.text,
                            HabitReminder.encode(pickedDate)
                          );
                        } else {
                          Get.snackbar("Please fill the habit's name", "Please fill the habit's name before creating one");
                        }
                        Navigator.pop(context);                 
                      }
                    )
                  ]
                )
              )
            )
          ),
        );
      }
    );
  }
}

class HabitPreviewerBottomSheet extends StatefulWidget {
  final Habit habitObject;

  HabitPreviewerBottomSheet({this.habitObject});

  @override
  _HabitPreviewerBottomSheetState createState() => _HabitPreviewerBottomSheetState();
}

class _HabitPreviewerBottomSheetState extends State<HabitPreviewerBottomSheet> {
  
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  bool isDaily = false;
  List<HabitReminder> pickedDate = [];
  List<String> daysPicked = []; 

  @override
  Widget build(BuildContext context) {
    return  BottomSheet(
      onClosing: () {},
      backgroundColor: Theme.of(context).backgroundColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(40),
          topRight: Radius.circular(40)
        )
      ),
      builder: (ctx) {
        return SingleChildScrollView(
          child: Container(height: MediaQuery.of(context).size.height * 0.55,
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
                              left:
                                  MediaQuery.of(context).size.width *
                                      0.01),
                          fillColor: HexColor("C4C4C4"),
                          border: InputBorder.none,
                          hintText: widget.habitObject.title,
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
                        height: MediaQuery.of(context).size.height *
                            0.02),
                    TextField(
                      maxLines: 2,
                      minLines: 2,
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
                          hintText: widget.habitObject.description ?? "No motivational punchline set",
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
                      height: MediaQuery.of(context).size.height * 0.05),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text("${widget.habitObject.reminder[0].dayName == "Daily" ? "Daily" : "Weekly"}",
                          textAlign: TextAlign.center,
                            style: GoogleFonts.karla().copyWith(
                                color: Theme.of(context).accentColor,
                                fontSize: 18,
                                fontWeight: FontWeight.w500)
                        ),
                        SizedBox(height: MediaQuery.of(context).size.height * 0.05),
                        Switch(
                          value: isDaily,
                          onChanged: (_){
                            setState((){
                              isDaily = !isDaily;
                            });
                          },
                          activeColor: Theme.of(context).primaryColor,                       
                        )
                      ],
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.025),
                    isDaily
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text("Reminders (optional)",
                              textAlign: TextAlign.center,
                              style: GoogleFonts.karla().copyWith(
                                  color: Theme.of(context).accentColor,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500)),
                          GestureDetector(
                              onTap: () async {
                                final selectedTime = await showTimePicker(
                                    context: context,
                                    initialTime: TimeOfDay.now()
                                );

                                pickedDate.add(HabitReminder(
                                  dayName: "Daily",
                                  dayTime: selectedTime.toString()
                                ));

                                setState((){});
                              },
                              child: Padding(
                                padding: const EdgeInsets.only(right: 10),
                                child: Icon(FlutterIcons.clock_faw5, size: 22),
                              ))
                        ],
                      )
                    : Column(
                      children: [
                        Wrap(
                          spacing: 10.0, // gap between adjacent chips
                          runSpacing: 10.0, // gap between lines
                          children: <Widget>[
                            GestureDetector(
                              onTap: (){
                                daysPicked.contains("Monday")
                                ? daysPicked.remove("Monday")
                                : daysPicked.add("Monday");
                                setState((){});
                              },
                              child: Chip(
                                labelPadding: EdgeInsets.symmetric(
                                  horizontal: 20,
                                  vertical: 5,
                                ),
                                backgroundColor: daysPicked.contains("Monday")
                                  ? Theme.of(context).primaryColor
                                  : HexColor("C4C4C4").withOpacity(0.2),
                                elevation: 0,                                  
                                label: Text('Monday',
                                  textAlign: TextAlign.center,
                                    style: GoogleFonts.karla().copyWith(
                                        color: Theme.of(context).accentColor,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w500)
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: (){
                                daysPicked.contains("Tuesday")
                                ? daysPicked.remove("Tuesday")
                                : daysPicked.add("Tuesday");
                                setState((){});
                              },
                              child: Chip(
                                labelPadding: EdgeInsets.symmetric(
                                  horizontal: 20,
                                  vertical: 5,
                                ),
                                backgroundColor: daysPicked.contains("Tuesday")
                                  ? Theme.of(context).primaryColor
                                  : HexColor("C4C4C4").withOpacity(0.2),
                                elevation: 0,                                  
                                label: Text('Tuesday',
                                  textAlign: TextAlign.center,
                                    style: GoogleFonts.karla().copyWith(
                                        color: Theme.of(context).accentColor,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w500)
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: (){
                                daysPicked.contains("Wednesday")
                                ? daysPicked.remove("Wednesday")
                                : daysPicked.add("Wednesday");
                                setState((){});
                              },
                              child: Chip(
                                labelPadding: EdgeInsets.symmetric(
                                  horizontal: 20,
                                  vertical: 5,
                                ),
                                backgroundColor: daysPicked.contains("Wednesday")
                                  ? Theme.of(context).primaryColor
                                  : HexColor("C4C4C4").withOpacity(0.2),
                                elevation: 0,                                  
                                label: Text('Wednesday',
                                  textAlign: TextAlign.center,
                                    style: GoogleFonts.karla().copyWith(
                                        color: Theme.of(context).accentColor,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w500)
                                ),
                              )
                            ),
                            GestureDetector(
                              onTap: (){
                                daysPicked.contains("Thursday")
                                ? daysPicked.remove("Thursday")
                                : daysPicked.add("Thursday");
                                setState((){});
                              },
                              child: Chip(
                                labelPadding: EdgeInsets.symmetric(
                                  horizontal: 20,
                                  vertical: 5,
                                ),
                                backgroundColor: daysPicked.contains("Thursday")
                                  ? Theme.of(context).primaryColor
                                  : HexColor("C4C4C4").withOpacity(0.2),
                                elevation: 0,                                  
                                label: Text('Thursday',
                                  textAlign: TextAlign.center,
                                    style: GoogleFonts.karla().copyWith(
                                        color: Theme.of(context).accentColor,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w500)
                                ),
                              )
                            ),
                            GestureDetector(
                              onTap: (){
                                daysPicked.contains("Friday")
                                ? daysPicked.remove("Friday")
                                : daysPicked.add("Friday");
                                setState((){});
                              },
                              child: Chip(
                                labelPadding: EdgeInsets.symmetric(
                                  horizontal: 20,
                                  vertical: 5,
                                ),
                                backgroundColor: daysPicked.contains("Friday")
                                  ? Theme.of(context).primaryColor
                                  : HexColor("C4C4C4").withOpacity(0.2),
                                elevation: 0,                                  
                                label: Text('Friday',
                                  textAlign: TextAlign.center,
                                    style: GoogleFonts.karla().copyWith(
                                        color: Theme.of(context).accentColor,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w500)
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: (){
                                daysPicked.contains("Saturday")
                                ? daysPicked.remove("Saturday")
                                : daysPicked.add("Saturday");
                                setState((){});
                              },
                              child: Chip(
                                labelPadding: EdgeInsets.symmetric(
                                  horizontal: 20,
                                  vertical: 5,
                                ),
                                backgroundColor: daysPicked.contains("Saturday")
                                  ? Theme.of(context).primaryColor
                                  : HexColor("C4C4C4").withOpacity(0.2),
                                elevation: 0,                                  
                                label: Text('Saturday',
                                  textAlign: TextAlign.center,
                                    style: GoogleFonts.karla().copyWith(
                                        color: Theme.of(context).accentColor,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w500)
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: (){
                                daysPicked.contains("Sunday")
                                ? daysPicked.remove("Sunday")
                                : daysPicked.add("Sunday");
                                setState((){});
                              },
                              child: Chip(
                                labelPadding: EdgeInsets.symmetric(
                                  horizontal: 20,
                                  vertical: 5,
                                ),
                                backgroundColor: daysPicked.contains("Sunday")
                                  ? Theme.of(context).primaryColor
                                  : HexColor("C4C4C4").withOpacity(0.2),
                                elevation: 0,                                  
                                label: Text('Sunday',
                                  textAlign: TextAlign.center,
                                    style: GoogleFonts.karla().copyWith(
                                        color: Theme.of(context).accentColor,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w500)
                                ),
                              ),
                            ),                        
                          ],
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.05),
                        Container(
                          height: MediaQuery.of(context).size.height * 0.4,
                          child: ListView.builder(
                            itemCount: daysPicked.length,
                            itemBuilder: (BuildContext context, index){
                              return Padding(
                                padding: EdgeInsets.only(bottom: MediaQuery.of(context).size.height * 0.04),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text("Reminder for ${daysPicked[index]} (optional)",
                                      textAlign: TextAlign.center,
                                      style: GoogleFonts.karla().copyWith(
                                          color: Theme.of(context).accentColor,
                                          fontSize: 18,
                                          fontWeight: FontWeight.w500)),
                                    GestureDetector(
                                      onTap: () async {
                                        final selectedTime = await showTimePicker(
                                            context: context,
                                            initialTime: TimeOfDay.now()
                                        );
                                        pickedDate.add(HabitReminder(
                                          dayName: daysPicked[index],
                                          dayTime: selectedTime.toString()
                                        ));
                                        
                                        setState((){});
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.only(right: 10),
                                        child: Icon(FlutterIcons.clock_faw5, size: 22),
                                      )
                                    )
                                  ],
                                ),
                              );
                            },
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height *  0.05),
                    DefaultButton(
                      title: "Update habit",
                      color: Theme.of(context).primaryColor,
                      method: (){
                        print(pickedDate);
                        print(pickedDate is List<HabitReminder>);
                        if(titleController.text != ""){
                          HabitServices().updateHabitRecord(
                            uid: widget.habitObject.uid,
                            title: titleController.text != "" ? titleController.text : widget.habitObject.title,
                            description: descriptionController.text != "" ? descriptionController.text  : widget.habitObject.description,
                            reminder: pickedDate.length != 0 ? HabitReminder.encode(pickedDate) :HabitReminder.encode(widget.habitObject.reminder),
                            isReminderActive: widget.habitObject.isReminderActive,
                            currentStreak: widget.habitObject.currentStreak,
                            longestStreak: widget.habitObject.longestStreak
                          );
                        } else {
                          Get.snackbar("Please fill the habit's name", "Please fill the habit's name before creating one");
                        }
                        Navigator.pop(context);                 
                      }
                    )
                  ]
                )
              )
            )
          ),
        );
      }
    );
  }
}
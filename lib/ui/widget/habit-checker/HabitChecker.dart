part of "../widgets.dart";

class HabitChecker extends StatefulWidget {
  HabitChecker({Key key}) : super(key: key);

  @override
  _HabitCheckerState createState() => _HabitCheckerState();
}

class _HabitCheckerState extends State<HabitChecker> {
  bool sampleValue = false;
  DateTime timeStamp = DateTime.now();

  @override
  Widget build(BuildContext context) {

    List<Habit> habitList = Provider.of<List<Habit>>(context) ?? [];

    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
      'alarm_notif',
      'alarm_notif',
      'Channel for Alarm notification',
      icon: 'splash',
      largeIcon: DrawableResourceAndroidBitmap('splash'),
    );

    var iOSPlatformChannelSpecifics = IOSNotificationDetails(
        presentAlert: true,
        presentBadge: true,
        presentSound: true);

    var platformChannelSpecifics = NotificationDetails(
        android: androidPlatformChannelSpecifics,
        iOS: iOSPlatformChannelSpecifics);
    
    habitList.forEach((habit){
      if(habit.isReminderActive){
        habit.reminder.forEach((reminder) async {
          if(reminder.dayName == DateFormat('EEEE').format(DateTime.now())){
            // ignore: deprecated_member_use
            await flutterLocalNotificationsPlugin.schedule(
              1,
              "Time for your ${habit.title}",
              "${habit.description != "" ? habit.description : "Persistence brings your success!"}",
              DateTime(
                timeStamp.year,
                timeStamp.month,
                timeStamp.day,
                int.tryParse(reminder.dayTime.substring(9,12)) ?? timeStamp.hour,
                int.tryParse(reminder.dayTime.substring(12,15)) ?? timeStamp.minute
              ),
              platformChannelSpecifics
            );
          } else if (reminder.dayName == "Daily"){

            // print("a");
            // print(int.tryParse(reminder.dayTime.substring(9,12)));

            // ignore: deprecated_member_use
            await flutterLocalNotificationsPlugin.schedule(
              1,
              "Time for your ${habit.title}",
              "${habit.description != "" ? habit.description : "Persistence brings your success!"}",
              DateTime(
                timeStamp.year,
                timeStamp.month,
                timeStamp.day,
                int.tryParse(reminder.dayTime.substring(9,12)) ?? timeStamp.hour,
                int.tryParse(reminder.dayTime.substring(12,15)) ?? timeStamp.minute
              ),
              platformChannelSpecifics
            );
          }
        });
      }
    });

    return ListView(
      physics: BouncingScrollPhysics(),
      children: [
        Container(
          padding: EdgeInsets.symmetric(
            vertical: MediaQuery.of(context).size.width * 0.05,
            horizontal: MediaQuery.of(context).size.width * 0.05),
          height: MediaQuery.of(context).size.height * 0.85,
          child: ListView.builder(
            physics: BouncingScrollPhysics(),
            scrollDirection: Axis.vertical,
            itemExtent: MediaQuery.of(context).size.height * 0.46,
            itemCount: habitList.length ?? 0,
            itemBuilder: (BuildContext context, index) {
              return GestureDetector(
                onLongPress: (){
                  showDialog(
                    context: context,
                    builder: (_) => BackdropFilter(
                      filter: new ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                      child: new AlertDialog(
                        backgroundColor: Theme.of(context).backgroundColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(30.0))),
                        content: Container(
                          alignment: Alignment.center,
                          height: MediaQuery.of(context).size.height * 0.35,
                          width: MediaQuery.of(context).size.width * 1,
                          child: Padding(
                            padding: EdgeInsets.all(
                                MediaQuery.of(context).size.height * 0.001),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  height: MediaQuery.of(context).size.height * 0.1,
                                  child: Image(
                                      image: Theme.of(context).backgroundColor == HexColor("1A1B2F")
                                        ? AssetImage("assets/logo_dark.png")
                                        : AssetImage("assets/logo_light.png"))),
                                SizedBox(
                                    height: MediaQuery.of(context).size.height * 0.015),
                                Center(
                                  child: Text(
                                    "Are you sure you want to delete this habit?",
                                    style: GoogleFonts.montserrat().copyWith(
                                        color: Theme.of(context).accentColor,
                                        fontSize: 22,
                                        fontWeight: FontWeight.w700),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                SizedBox(
                                    height:
                                        MediaQuery.of(context).size.height * 0.03),
                                Center(
                                  child: Text(
                                    "This action is irreversible!",
                                    style: GoogleFonts.karla().copyWith(
                                      color: Theme.of(context).accentColor,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                SizedBox(
                                  height: MediaQuery.of(context).size.height * 0.03),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  children: [
                                    DefaultButton(
                                      color: HexColor("C4C4C4 ").withOpacity(0.3),
                                      title: "Cancel",
                                      method: (){
                                        Navigator.pop(context);
                                      }
                                    ),
                                    DefaultButton(
                                      color: Colors.red,
                                      title: "Delete",
                                      method: (){
                                        HabitServices().deleteHabitRecord(habitList[index].uid);
                                        Navigator.pop(context);
                                      }
                                    )
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    )
                  );
                },
                child: Container(
                  padding: EdgeInsets.all(
                    MediaQuery.of(context).size.height * 0.035),
                  width: MediaQuery.of(context).size.width * 0.8,
                  margin: EdgeInsets.symmetric(
                    horizontal: MediaQuery.of(context).size.width * 0.035,
                    vertical: MediaQuery.of(context).size.width * 0.04),
                  decoration: BoxDecoration(
                    color: Theme.of(context).backgroundColor,
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    boxShadow: [
                      BoxShadow(
                        color:
                            Theme.of(context).primaryColor.withOpacity(0.2),
                        blurRadius: 15,
                        spreadRadius: 1,
                      )
                    ],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(habitList[index].title, //habit name
                            style: GoogleFonts.montserrat().copyWith(
                              color: Theme.of(context).accentColor,
                              fontSize: 24,
                              letterSpacing: 1,
                              fontWeight: FontWeight.w700)),
                          GestureDetector(
                            onTap: () {
                              showModalBottomSheet(
                                backgroundColor: Colors.transparent,
                                isScrollControlled: true,
                                context: context,
                                builder: (BuildContext context) {
                                  return HabitPreviewerBottomSheet(
                                      habitObject: habitList[index],
                                  );
                                }
                              ); 
                            },
                            child: Icon(FlutterIcons.mode_edit_mdi,
                                size: 24))
                        ],
                      ),
                      SizedBox(
                          height:
                              MediaQuery.of(context).size.height * 0.02),
                      Text(habitList[index].description != ""
                      ? habitList[index].description
                      : "No motivational punchline set", //habit name
                          style: GoogleFonts.karla().copyWith(
                              color: Theme.of(context).accentColor,
                              fontSize: 16,
                              height: 1.5,
                              fontWeight: FontWeight.w400)),
                      SizedBox(
                        height:
                            MediaQuery.of(context).size.height * 0.05),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Reminder", //habit name
                                  style: GoogleFonts.montserrat().copyWith(
                                      color: Theme.of(context).accentColor,
                                      fontSize: 18,
                                      letterSpacing: 1,
                                      fontWeight: FontWeight.w700)),
                              SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height *
                                          0.005),
                              Text(
                                habitList[index].reminder.length != 0
                                ? "at " + habitList[index].reminder[0].dayTime.substring(10,15)
                                : "Reminder has not been set", //habit name
                                  style: GoogleFonts.karla().copyWith(
                                      color: Theme.of(context).accentColor,
                                      fontSize: 16,
                                      height: 1.5,
                                      fontWeight: FontWeight.w400)),
                            ],
                          ),
                          Switch(
                            value: habitList[index].isReminderActive, //demo
                            onChanged: (_) {
                              setState(() {
                                habitList[index].isReminderActive =  !habitList[index].isReminderActive;
                                HabitServices().updateHabitRecord(
                                  uid: habitList[index].uid,
                                  title: habitList[index].title,
                                  description: habitList[index].description,
                                  reminder: HabitReminder.encode(habitList[index].reminder),
                                  isReminderActive: !habitList[index].isReminderActive,
                                  currentStreak: habitList[index].currentStreak,
                                  longestStreak: habitList[index].longestStreak
                                );
                              });
                            },
                            activeColor: Theme.of(context).primaryColor,
                          )
                        ],
                      ),
                      SizedBox(
                        height:
                            MediaQuery.of(context).size.height * 0.05),
                      DefaultButton(
                        title: "Check",
                        method: (){
                          HabitServices().updateHabitRecord(
                            uid: habitList[index].uid,
                            title: habitList[index].title,
                            description: habitList[index].description,
                            reminder: HabitReminder.encode(habitList[index].reminder),
                            isReminderActive: habitList[index].isReminderActive,
                            currentStreak: habitList[index].currentStreak++,
                            longestStreak: habitList[index].currentStreak + 1 > habitList[index].longestStreak
                              ?  habitList[index].currentStreak + 1
                              :  habitList[index].longestStreak
                          );
                          showDialog(
                            context: context,
                            builder: (_) => BackdropFilter(
                              filter: new ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                              child: new AlertDialog(
                                backgroundColor: Theme.of(context).backgroundColor,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(30.0))),
                                content: Container(
                                  alignment: Alignment.center,
                                  height: MediaQuery.of(context).size.height * 0.325,
                                  width: MediaQuery.of(context).size.width * 1,
                                  child: Padding(
                                    padding: EdgeInsets.all(
                                        MediaQuery.of(context).size.height * 0.001),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Container(
                                          height: MediaQuery.of(context).size.height * 0.1,
                                          child: Image(
                                              image: Theme.of(context).backgroundColor == HexColor("1A1B2F")
                                                ? AssetImage("assets/logo_dark.png")
                                                : AssetImage("assets/logo_light.png"))),
                                        SizedBox(
                                            height: MediaQuery.of(context).size.height * 0.015),
                                        Center(
                                          child: Text(
                                            "Congratulations!",
                                            style: GoogleFonts.montserrat().copyWith(
                                                color: Theme.of(context).accentColor,
                                                fontSize: 24,
                                                fontWeight: FontWeight.w700),
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                        SizedBox(
                                            height:
                                                MediaQuery.of(context).size.height * 0.03),
                                        Center(
                                          child: Text(
                                            "You are getting 1% better than yesterday!",
                                            style: GoogleFonts.karla().copyWith(
                                              color: Theme.of(context).accentColor,
                                              fontSize: 18,
                                              fontWeight: FontWeight.w500),
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            )
                          );
                        },
                      color: Theme.of(context).primaryColor
                    )
                  ]
                )
            ),
              );
          }
        )
      )
    ]);
  }
}

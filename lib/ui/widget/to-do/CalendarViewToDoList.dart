part of "../widgets.dart";

class CalendarViewToDoList extends StatefulWidget {
  final User currentUser;
  final FirebaseFirestore firestore;
  final DocumentReference toDoDocument;

  CalendarViewToDoList({this.currentUser, this.firestore, this.toDoDocument});

  @override
  _CalendarViewToDoListState createState() => _CalendarViewToDoListState();
}

class _CalendarViewToDoListState extends State<CalendarViewToDoList> {
  List<Meeting> meetings;

  @override
  Widget build(BuildContext context) {
    List<Meeting> _getDataSource() {
      meetings = <Meeting>[];
      final DateTime today = DateTime.now();
      final DateTime startTime =
          DateTime(today.year, today.month, today.day, 9, 0, 0);
      final DateTime endTime = startTime.add(const Duration(hours: 2));
      meetings.add(Meeting('Conference', startTime, endTime, const Color(0xFF0F8644), false));
      return meetings;
    }

    return Scaffold( body: 
      Padding(
        padding: EdgeInsets.only(
          top: 0,
          left: MediaQuery.of(context).size.width * 0.05,
          right: MediaQuery.of(context).size.width * 0.05,
          bottom: MediaQuery.of(context).size.width * 0.05
        ),
        child: SfCalendar(
          showNavigationArrow: true,
          cellBorderColor: Theme.of(context).accentColor.withOpacity(0.1),
          todayHighlightColor: Theme.of(context).primaryColor,
          selectionDecoration: BoxDecoration(
            color: Colors.transparent,
            border: Border.all(color: Theme.of(context).primaryColor, width: 2),
            borderRadius: const BorderRadius.all(Radius.circular(5)),
            shape: BoxShape.rectangle,
          ),
          headerStyle: CalendarHeaderStyle(
            textAlign: TextAlign.center,
            textStyle: GoogleFonts.montserrat().copyWith(
                        color: Theme.of(context).accentColor,
                        fontSize: 18,
                        fontWeight: FontWeight.w600)
          ),
          viewHeaderHeight: MediaQuery.of(context).size.height * 0.1,
          timeSlotViewSettings: TimeSlotViewSettings(
            timeIntervalWidth: MediaQuery.of(context).size.height * 0.1,
            timeInterval: Duration(minutes: 30),
            timeFormat: 'h:mm',
            timeTextStyle: GoogleFonts.karla().copyWith(
                        color: Theme.of(context).accentColor,
                        fontSize: 12,
                        fontWeight: FontWeight.w600)
          ),
          view: CalendarView.week,
          dataSource: MeetingDataSource(_getDataSource()),
          monthViewSettings: MonthViewSettings(appointmentDisplayMode: MonthAppointmentDisplayMode.appointment),
        ),
      )
    );
  }
}

class MeetingDataSource extends CalendarDataSource {
  /// Creates a meeting data source, which used to set the appointment
  /// collection to the calendar
  MeetingDataSource(List<Meeting> source) {
    appointments = source;
  }

  @override
  DateTime getStartTime(int index) {
    return appointments[index].from;
  }

  @override
  DateTime getEndTime(int index) {
    return appointments[index].to;
  }

  @override
  String getSubject(int index) {
    return appointments[index].eventName;
  }

  @override
  Color getColor(int index) {
    return appointments[index].background;
  }

  @override
  bool isAllDay(int index) {
    return appointments[index].isAllDay;
  }
}

/// Custom business object class which contains properties to hold the detailed
/// information about the event data which will be rendered in calendar.
class Meeting {
  /// Creates a meeting class with required details.
  Meeting(this.eventName, this.from, this.to, this.background, this.isAllDay);

  /// Event name which is equivalent to subject property of [Appointment].
  String eventName;

  /// From which is equivalent to start time property of [Appointment].
  DateTime from;

  /// To which is equivalent to end time property of [Appointment].
  DateTime to;

  /// Background which is equivalent to color property of [Appointment].
  Color background;

  /// IsAllDay which is equivalent to isAllDay property of [Appointment].
  bool isAllDay;
}

part of "../widgets.dart";

class CalendarViewToDoList extends StatefulWidget {
  final User currentUser;

  CalendarViewToDoList({this.currentUser});

  @override
  _CalendarViewToDoListState createState() => _CalendarViewToDoListState();
}

class _CalendarViewToDoListState extends State<CalendarViewToDoList> {
  List<Event> meetings;
  DateFormat formatter = DateFormat("yyyy-MM-dd");
  ColorSelection colors = new ColorSelection();

  @override
  Widget build(BuildContext context){
    
    List<TaskObject> toDoList = Provider.of<List<TaskObject>>(context) ?? [];

    List<Event> _getDataSource() {
      meetings = <Event>[];
      for(var i = 0 ; i < toDoList.length ; i++){
        print(formatter.parse(toDoList[i].startDate));
        final DateTime startTime = formatter.parse(toDoList[i].startDate.replaceAll("-", ""));
        final DateTime endTime =formatter.parse(toDoList[i].date.replaceAll("-", ""));
        meetings.add(Event('${toDoList[i].task}', startTime, endTime, HexColor(colors.colorSelection[i]), false));
      }

      print(meetings);
      print(toDoList);

      return meetings;
    }

    return Scaffold( 
      body: Padding(
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


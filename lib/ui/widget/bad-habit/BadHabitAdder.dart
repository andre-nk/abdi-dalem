part of "../widgets.dart";

class BadHabitAdderBottomSheet extends StatefulWidget {
  @override
  _BadHabitAdderBottomSheetState createState() => _BadHabitAdderBottomSheetState();
}

class _BadHabitAdderBottomSheetState extends State<BadHabitAdderBottomSheet> {
  @override
  Widget build(BuildContext context) {
    return BottomSheet(
      onClosing: (){},
      backgroundColor: Theme.of(context).backgroundColor,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(40), topRight: Radius.circular(40))),
      builder: (ctx) {
        return Container(
          height: MediaQuery.of(context).size.height * 0.6,
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Padding(
              padding: EdgeInsets.all(MediaQuery.of(context).size.height * 0.04),
              child: SizedBox()
            )
          )
        );
      }
    );
  }
}
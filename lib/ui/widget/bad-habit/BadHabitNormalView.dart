part of "../widgets.dart";

class BadHabitNormalView extends StatefulWidget {
  @override
  _BadHabitNormalViewState createState() => _BadHabitNormalViewState();
}

class _BadHabitNormalViewState extends State<BadHabitNormalView> {

  bool sampleValue = false;

  @override
  Widget build(BuildContext context) {
    return ListView(physics: BouncingScrollPhysics(), children: [
      Container(
          padding: EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).size.width * 0.05),
          height: MediaQuery.of(context).size.height * 0.85,
          child: ListView.builder(
            physics: BouncingScrollPhysics(),
            scrollDirection: Axis.vertical,
            itemExtent: MediaQuery.of(context).size.width * 0.8,
            itemCount: 10,
            itemBuilder: (BuildContext context, index) {
              return Container(
                padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).size.height * 0.03),
                height: 100,
                width: MediaQuery.of(context).size.width * 0.8,
                margin: EdgeInsets.symmetric(
                    horizontal: MediaQuery.of(context).size.width * 0.035,
                    vertical: MediaQuery.of(context).size.width * 0.04),
                decoration: BoxDecoration(
                  color: Theme.of(context).backgroundColor,
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  boxShadow: [
                    BoxShadow(
                      color: Theme.of(context).primaryColor.withOpacity(0.2),
                      blurRadius: 15,
                      spreadRadius: 1,
                    )
                  ],
                ),
                child: Container(
                  height: double.infinity * 0.6,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: EdgeInsets.all(
                            MediaQuery.of(context).size.height * 0.035),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text("Angry", //habit name
                                    style: GoogleFonts.montserrat().copyWith(
                                        color: Theme.of(context).accentColor,
                                        fontSize: 18,
                                        letterSpacing: 1,
                                        fontWeight:
                                            FontWeight.w700)),
                                GestureDetector(
                                  onTap: (){
                                    print("tapped"); //edit bottomsheet
                                  },
                                  child: Icon(FlutterIcons.mode_edit_mdi, size: 24)
                                )
                              ],
                            ), //TBA FB Tags Title
                            SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                            Wrap(
                              direction: Axis.horizontal,
                              children: [
                                CustomCheckboxListTile(
                                  activeColor: Theme.of(context).primaryColor, //change to tag color
                                  value: sampleValue, //*task.isCompleted(),
                                  onChanged: (value) {
                                    if (sampleValue == false) {
                                      print("true");
                                      setState(() {
                                        sampleValue = true;
                                      });
                                    } else {
                                      print("false");
                                      setState(() {
                                        sampleValue = false;
                                      });
                                    }
                                  },
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ))
    ]);
  }
}

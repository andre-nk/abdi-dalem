part of "../widgets.dart";

class BadHabitNormalView extends StatefulWidget {
  @override
  _BadHabitNormalViewState createState() => _BadHabitNormalViewState();
}

class _BadHabitNormalViewState extends State<BadHabitNormalView> {
  bool sampleValue = false;

  @override
  Widget build(BuildContext context) {
    List<BadHabitObject> badHabitList = Provider.of<List<BadHabitObject>>(context) ?? [];
    List<BadHabitObject> normalBadHabitList = [];

    badHabitList.forEach((object){
      if(object.isProtected != true){
        normalBadHabitList.add(object);
      }
    });

    return ListView(physics: BouncingScrollPhysics(), children: [
      Container(
          padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.05),
          height: MediaQuery.of(context).size.height * 0.85,
          child: ListView.builder(
            physics: BouncingScrollPhysics(),
            scrollDirection: Axis.vertical,
            itemExtent: MediaQuery.of(context).size.height * 0.425,
            itemCount: normalBadHabitList.length ?? 0,
            itemBuilder: (BuildContext context, index) {
              return Container(
                padding: EdgeInsets.only(bottom: MediaQuery.of(context).size.height * 0.03),
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
                child: Column(
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
                              Text(normalBadHabitList[index].title, //habit name
                                  style: GoogleFonts.montserrat().copyWith(
                                      color: Theme.of(context).accentColor,
                                      fontSize: 18,
                                      letterSpacing: 1,
                                      fontWeight: FontWeight.w700)),
                              GestureDetector(
                                onTap: () {
                                  showModalBottomSheet(
                                    backgroundColor: Colors.transparent,
                                    isScrollControlled: true,
                                    context: context,
                                    builder: (BuildContext context) {
                                      return Padding(
                                        padding: EdgeInsets.only(
                                          bottom: MediaQuery.of(context).viewInsets.bottom),
                                        child: BadHabitPreviewer(
                                          title: normalBadHabitList[index].title,
                                          subtitle:  normalBadHabitList[index].subtitle,
                                          limit: normalBadHabitList[index].limit,
                                          currentCount: normalBadHabitList[index].currentCount,
                                          uid: normalBadHabitList[index].uid,        
                                        ),
                                      );
                                    }
                                  ); //edit bottomsheet
                                },
                                child: Icon(FlutterIcons.mode_edit_mdi, size: 24))
                            ],
                          ), //TBA FB Tags Title
                          SizedBox(
                              height:
                                  MediaQuery.of(context).size.height * 0.01),
                          normalBadHabitList[index].subtitle != ""
                              ? Text(normalBadHabitList[index].subtitle, //habit name
                                  style: GoogleFonts.karla().copyWith(
                                      color: Theme.of(context).accentColor,
                                      fontSize: 16,
                                      height: 1.5,
                                      fontWeight: FontWeight.w400))
                              : SizedBox(),
                          SizedBox(
                              height:
                                  MediaQuery.of(context).size.height * 0.035),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                               Container(
                                width: MediaQuery.of(context).size.width * 0.525,
                                child: LinearProgressIndicator(
                                  minHeight:
                                      MediaQuery.of(context).size.height * 0.01,
                                  value: (normalBadHabitList[index].currentCount / normalBadHabitList[index].limit) * 100,
                                  backgroundColor: Theme.of(context)
                                      .accentColor
                                      .withOpacity(0.6),
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                      Theme.of(context).primaryColor),
                                ),
                              ),
                              Text("${normalBadHabitList[index].currentCount} / ${normalBadHabitList[index].limit}", //habit name
                                  style: GoogleFonts.montserrat().copyWith(
                                      color: Theme.of(context).accentColor,
                                      fontSize: 16,
                                      letterSpacing: 1,
                                      fontWeight: FontWeight.w500)),                           
                            ],
                          ),
                          SizedBox(
                              height:
                                  MediaQuery.of(context).size.height * 0.035),
                          Container(
                            width: MediaQuery.of(context).size.width * 0.8,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Container(
                                  width: MediaQuery.of(context).size.width * 0.3,
                                  height: MediaQuery.of(context).size.height * 0.055,
                                  child: DefaultButton(
                                    color: Theme.of(context).primaryColor,
                                    title: "Check",
                                    method: (){
                                      BadHabitServices().updateBadHabitRecord(
                                        normalBadHabitList[index].uid,
                                        normalBadHabitList[index].isProtected,
                                        currentCount: normalBadHabitList[index].currentCount == normalBadHabitList[index].limit ? normalBadHabitList[index].currentCount : normalBadHabitList[index].currentCount + 1,
                                        title: normalBadHabitList[index].title,
                                        subtitle: normalBadHabitList[index].subtitle,
                                        limit: normalBadHabitList[index].limit,
                                      );
                                    }
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          ))
    ]);
  }
}

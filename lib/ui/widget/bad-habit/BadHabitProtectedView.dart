part of "../widgets.dart";

class BadHabitProtectedView extends StatefulWidget {
  @override
  _BadHabitProtectedViewState createState() => _BadHabitProtectedViewState();
}

class _BadHabitProtectedViewState extends State<BadHabitProtectedView> {
  bool sampleValue = false;
  bool isPINCorrect = false;
  
  String currentText = "";
  final formKey = GlobalKey<FormState>();
  TextEditingController textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {

    String badHabitPin = Provider.of<SharedPref>(context, listen: false).badHabitPin;
    print(Provider.of<SharedPref>(context, listen: false).badHabitPin);


    List<BadHabitObject> badHabitList = Provider.of<List<BadHabitObject>>(context) ?? [];
    List<BadHabitObject> protectedBadHabitList = [];
    
    badHabitList.forEach((object){
      if(object.isProtected == true){
        protectedBadHabitList.add(object);
      }
    });

    return isPINCorrect
      ? ListView(
        physics: BouncingScrollPhysics(), children: [
        Container(
            padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.05),
            height: MediaQuery.of(context).size.height * 0.85,
            child: ListView.builder(
              physics: BouncingScrollPhysics(),
              scrollDirection: Axis.vertical,
              itemExtent: MediaQuery.of(context).size.height * 0.425,
              itemCount: protectedBadHabitList.length ?? 0,
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
                                Text(protectedBadHabitList[index].title, //habit name
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
                                            title: protectedBadHabitList[index].title,
                                            subtitle:  protectedBadHabitList[index].subtitle,
                                            limit: protectedBadHabitList[index].limit,
                                            currentCount: protectedBadHabitList[index].currentCount,
                                            uid: protectedBadHabitList[index].uid,        
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
                            protectedBadHabitList[index].subtitle != ""
                                ? Text(protectedBadHabitList[index].subtitle, //habit name
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
                                    value: (protectedBadHabitList[index].currentCount / protectedBadHabitList[index].limit) * 100,
                                    backgroundColor: Theme.of(context)
                                        .accentColor
                                        .withOpacity(0.6),
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                        Theme.of(context).primaryColor),
                                  ),
                                ),
                                Text("${protectedBadHabitList[index].currentCount} / ${protectedBadHabitList[index].limit}", //habit name
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
                                          protectedBadHabitList[index].uid,
                                          protectedBadHabitList[index].isProtected,
                                          currentCount: protectedBadHabitList[index].currentCount == protectedBadHabitList[index].limit ? protectedBadHabitList[index].currentCount : protectedBadHabitList[index].currentCount + 1,
                                          title: protectedBadHabitList[index].title,
                                          subtitle: protectedBadHabitList[index].subtitle,
                                          limit: protectedBadHabitList[index].limit,
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
            )
          )
        ]
      )
      : ListView(physics: BouncingScrollPhysics(), children: [
        Container(
          height: MediaQuery.of(context).size.height * 0.7,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              badHabitPin == ""
              ? Text("Please make a security PIN first",
                  style: GoogleFonts.montserrat().copyWith(
                    color: buildDarkTheme('a').accentColor,
                    fontSize: 22,
                    fontWeight: FontWeight.w600),
                  textAlign: TextAlign.center
                )
              : Text("Please enter your security PIN",
                  style: GoogleFonts.montserrat().copyWith(
                    color: buildDarkTheme('a').accentColor,
                    fontSize: 22,
                    fontWeight: FontWeight.w600),
                  textAlign: TextAlign.center
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.04),
              badHabitPin == "" ? 
                Form(
                  key: formKey,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 30),
                    child: PinCodeTextField(
                      textStyle: GoogleFonts.montserrat().copyWith(
                                    color: buildDarkTheme('a').accentColor,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600),
                      appContext: context,
                      length: 6,
                      obscureText: true,
                      obscuringCharacter: '*',
                      blinkWhenObscuring: true,
                      animationType: AnimationType.fade,
                      pinTheme: PinTheme(
                        shape: PinCodeFieldShape.box,
                        borderRadius: BorderRadius.circular(5),
                        fieldHeight: 50,
                        fieldWidth: 40,
                        selectedColor: Theme.of(context).primaryColor,
                        activeColor: Theme.of(context).primaryColor,
                        inactiveColor: Theme.of(context).backgroundColor.withOpacity(0.3),
                        selectedFillColor: Theme.of(context).primaryColor,
                        activeFillColor: Theme.of(context).primaryColor,
                        inactiveFillColor: Theme.of(context).backgroundColor.withOpacity(0.3),
                      ),
                      cursorColor: Colors.black,
                      animationDuration: Duration(milliseconds: 300),
                      backgroundColor: Colors.transparent,
                      enableActiveFill: true,
                      controller: textEditingController,
                      keyboardType: TextInputType.number,
                      boxShadows: [
                        BoxShadow(
                          offset: Offset(0, 1),
                          color: Theme.of(context).primaryColor.withOpacity(0.2),
                          blurRadius: 10,
                        )
                      ],
                      onCompleted: (v) {
                        Provider.of<SharedPref>(context, listen: false).setBadHabitPin(currentText);
                      },
                      onChanged: (value) {
                        setState(() {
                          currentText = value;
                        });
                      },
                    )
                  ),
                )
              :
                Form(
                  key: formKey,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 30),
                    child: PinCodeTextField(
                      textStyle: GoogleFonts.montserrat().copyWith(
                                    color: buildDarkTheme('a').accentColor,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600),
                      appContext: context,
                      length: 6,
                      obscureText: true,
                      obscuringCharacter: '*',
                      blinkWhenObscuring: true,
                      animationType: AnimationType.fade,
                      pinTheme: PinTheme(
                        shape: PinCodeFieldShape.box,
                        borderRadius: BorderRadius.circular(5),
                        fieldHeight: 50,
                        fieldWidth: 40,
                        selectedColor: Theme.of(context).primaryColor,
                        activeColor: Theme.of(context).primaryColor,
                        inactiveColor: Theme.of(context).backgroundColor.withOpacity(0.3),
                        selectedFillColor: Theme.of(context).primaryColor,
                        activeFillColor: Theme.of(context).primaryColor,
                        inactiveFillColor: Theme.of(context).backgroundColor.withOpacity(0.3),
                      ),
                      cursorColor: Colors.black,
                      animationDuration: Duration(milliseconds: 300),
                      backgroundColor: Colors.transparent,
                      enableActiveFill: true,
                      controller: textEditingController,
                      keyboardType: TextInputType.number,
                      boxShadows: [
                        BoxShadow(
                          offset: Offset(0, 1),
                          color: Theme.of(context).primaryColor.withOpacity(0.2),
                          blurRadius: 10,
                        )
                      ],
                      onCompleted: (v) {
                        if(currentText == Provider.of<SharedPref>(context, listen: false).badHabitPin){
                          setState((){isPINCorrect = true;});
                        }else{
                          Get.snackbar("PIN incorrect", "The PIN you've inputted is incorrect. Try again");
                          setState((){textEditingController.text = "";});                    
                        }
                      },
                      onChanged: (value) {
                        setState(() {
                          currentText = value;
                        });
                      },
                    )
                  ),
                ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.02),
              Text("Forgot your PIN?",
                style: GoogleFonts.karla().copyWith(
                  color: buildDarkTheme('a').accentColor,
                  fontSize: 18,
                  fontWeight: FontWeight.w400),
                textAlign: TextAlign.center
              )
            ],
          ),
        ),
      ]
    );
  }
}

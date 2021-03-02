part of "../widgets.dart";

class BadHabitPin extends StatefulWidget {
  BadHabitPin({Key key}) : super(key: key);

  @override
  _BadHabitPinState createState() => _BadHabitPinState();
}

class _BadHabitPinState extends State<BadHabitPin> {

  String currentText = "";
  final formKey = GlobalKey<FormState>();
  TextEditingController textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    
    String badHabitPin = Provider.of<SharedPref>(context, listen: false).badHabitPin;
    print(Provider.of<SharedPref>(context, listen: false).badHabitPin);

    return ListView(physics: BouncingScrollPhysics(), children: [
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
                        Navigator.popAndPushNamed(context, "/protectedBadHabit");
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
    ]);
  }
}

part of 'shared.dart';

class SharedPref extends ChangeNotifier {
  final SharedPreferences sharedPreferences;

  SharedPref(this.sharedPreferences);

  bool get isDarkMode => sharedPreferences?.getBool("isDarkMode") ?? false;
  String get primaryColor => sharedPreferences?.getString("primaryColor") ?? "08A4BD";
  List<String> get timeStamp => sharedPreferences?.getStringList("timeStamp") ?? [];
  List<String> get timeStampSecond => sharedPreferences?.getStringList("timeStampSecond") ?? [];
  bool get timerBreak => sharedPreferences?.getBool("timerBreak") ?? false;

  void setDarkMode(bool val) {
    sharedPreferences?.setBool("isDarkMode", val);
    notifyListeners();
    // Future.delayed(const Duration(milliseconds: 500), () {
    //   notifyListeners();
    // });
  }

  void setPrimaryColor(String val) {
    sharedPreferences?.setString("primaryColor", val);
    notifyListeners();
    // Future.delayed(const Duration(milliseconds: 500), () {
    //   notifyListeners();
    // });
  }

  void setTimestamp(List<String> timeStamps){
    sharedPreferences?.setStringList("timeStamp", timeStamps);
    notifyListeners();
  }

  void setTimestampSecond(List<String> timeStamps){
    sharedPreferences?.setStringList("timeStampSecond", timeStamps);
    notifyListeners();
  }

    void setTimerBreak(bool timerBreak){
    sharedPreferences?.setBool("timerBreak", timerBreak);
    notifyListeners();
  }

}

part of 'shared.dart';

class SharedPref extends ChangeNotifier {
  final SharedPreferences sharedPreferences;

  SharedPref(this.sharedPreferences);
  
  bool get timerBreak => sharedPreferences?.getBool("timerBreak") ?? false;
  bool get isDarkMode => sharedPreferences?.getBool("isDarkMode") ?? false;
  String get nextCheckIn => sharedPreferences?.getString("nextCheckIn") ?? DateTime.now().toString();
  String get primaryColor => sharedPreferences?.getString("primaryColor") ?? "08A4BD";
  String get badHabitPin => sharedPreferences?.getString("badHabitPin") ?? "";
  List<String> get timeStamp => sharedPreferences?.getStringList("timeStamp") ?? [];
  List<String> get timeStampSecond => sharedPreferences?.getStringList("timeStampSecond") ?? [];

  void setNextCheckIn(String nextCheckIn){
    sharedPreferences?.setString("nextCheckIn", nextCheckIn);
    notifyListeners();
  }

  void setBadHabitPin(String pin){
    sharedPreferences?.setString("badHabitPin", pin);
    notifyListeners();
  }

  void setDarkMode(bool val) {
    sharedPreferences?.setBool("isDarkMode", val);
    notifyListeners();
  }

  void setPrimaryColor(String val) {
    sharedPreferences?.setString("primaryColor", val);
    notifyListeners();
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

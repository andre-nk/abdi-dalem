part of 'shared.dart';

class SharedPref extends ChangeNotifier {
  final SharedPreferences sharedPreferences;

  SharedPref(this.sharedPreferences);

  bool get isDarkMode => sharedPreferences?.getBool("isDarkMode") ?? false;
  String get primaryColor => sharedPreferences?.getString("primaryColor") ?? "08A4BD";

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

}

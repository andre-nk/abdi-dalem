part of "models.dart";

class BadHabitObject{
  String uid;
  String title;
  String subtitle;
  int limit;
  int currentCount;
  bool isProtected;

  BadHabitObject({String uid, String title, String subtitle, int limit, int currentCount, bool isProtected}){
    this.uid = uid ?? "";
    this.title = title ?? "";
    this.subtitle = subtitle ?? "";
    this.limit = limit ?? 0;
    this.currentCount = currentCount ?? 0;
    this.isProtected = isProtected ?? false;
  }

  void setChecked(bool value) {
    currentCount += 1;
  }

  void setUnchecked(bool value){
    currentCount -= 1;
  }
}
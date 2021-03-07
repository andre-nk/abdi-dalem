part of "models.dart";

class Habit{
  String uid;
  String title;
  String description;
  int currentStreak;
  int longestStreak;
  List<HabitReminder> reminder;
  bool isReminderActive;

  Habit({this.uid, this.title, this.description, this.currentStreak, this.longestStreak, this.reminder, this.isReminderActive});
}

class HabitReminder{
  String dayName;
  TimeOfDay dayTime;

  HabitReminder({this.dayName, this.dayTime});
}
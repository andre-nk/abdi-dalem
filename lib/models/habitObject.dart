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
  String dayTime;

  HabitReminder({this.dayName, this.dayTime});

  factory HabitReminder.fromJson(Map<String, dynamic> jsonData) {
    return HabitReminder(
      dayName: jsonData["dayName"],
      dayTime: jsonData["dayTime"],
    );
  }

  static Map<String, dynamic> toMap(HabitReminder habitReminder) => {
    'dayName': habitReminder.dayName,
    'dayTime': habitReminder.dayTime,
  };

  static String encode(List<HabitReminder> habitReminder) => json.encode(
    habitReminder
      .map<Map<String, dynamic>>((habitReminder) => HabitReminder.toMap(habitReminder))
      .toList(),
  );

  static List<HabitReminder> decode(String habitReminder) =>
      (json.decode(habitReminder) as List<dynamic>)
          .map<HabitReminder>((item) => HabitReminder.fromJson(item))
          .toList();
}
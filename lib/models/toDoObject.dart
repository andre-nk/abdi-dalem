part of "models.dart";

enum TodoListSettings { edit_color, delete }
class TaskObject {
  DateTime date;
  String task;
  String description;
  bool _completed;
  List<String> tags;

  TaskObject(String task, DateTime date, List tags) {
    this.task = task;
    this.date = date;
    this._completed = false;
    this.tags = tags;
  }

  void setComplete(bool value) {
    _completed = value;
  }

  isCompleted() => _completed;
}

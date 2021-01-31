part of "models.dart";

enum TodoListSettings { edit_color, delete }

class ToDoList {
  //explicit container for the retrieved datas from Firestore (taskID + corresponding tag)
  String title;
  String color;
  LinearGradient gradient;
  IconData icon;
  List<TaskObject> tasks;

  ToDoList.contain(String title,  /**Yakin?*/List<TaskObject> tasks, {String color}) {
    this.title = title;
    this.color = color;
    this.tasks = tasks;
  }

  int taskAmount() {
    int amount = 0;
    amount = tasks.length;
    return amount;
  }

  double percentComplete() {
    if (tasks.isEmpty) {
      return 1.0;
    }
    int completed = 0;
    int amount = 0;
    tasks.forEach((list) {
      amount = tasks.length;
      tasks.forEach((task) {
        if (task.isCompleted()) {
          completed++;
        }
      });
    });
    return completed / amount;
  }
}

class TaskObject {
  DateTime date;
  String task;
  bool _completed;
  List<String> tags;

  TaskObject(String task, DateTime date) {
    this.task = task;
    this.date = date;
    this._completed = false;
    this.tags = [];
  }

  TaskObject.import(String task, DateTime date, bool completed) {
    this.task = task;
    this.date = date;
    this._completed = completed;
    this.tags = [];
  }

  void setComplete(bool value) {
    _completed = value;
  }

  isCompleted() => _completed;
}

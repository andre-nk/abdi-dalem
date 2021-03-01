part of 'services.dart';

class DatabaseServices {
  //global reference
  final CollectionReference users =
      FirebaseFirestore.instance.collection('users');
  User currentUser = FirebaseAuth.instance.currentUser;
  bool isGuest = FirebaseAuth.instance.currentUser.isAnonymous;

  //custom userName
  UserData _userDataFromSnapshot(DocumentSnapshot data) {
    return UserData(
        uid: currentUser.uid, name: data["name"] ?? currentUser.displayName);
  }

  Future<void> updateUserData(String userName) async {
    return await users.doc(currentUser.uid).update({"name": userName ?? ""});
  }

  //to do object
  Stream<UserData> get userData {
    Stream<UserData> output;

    if (isGuest == false) {
      output =
          users.doc(currentUser.uid).snapshots().map(_userDataFromSnapshot);
    } else {
      users.doc(currentUser.uid).set({"name": "Guest " +  currentUser.uid.toString()});
      output =
          users.doc(currentUser.uid).snapshots().map(_userDataFromSnapshot);
    }

    return output;
  }
}

class ToDoServices extends DatabaseServices {
  List<TaskObject> _taskObjectFromSnapshot(QuerySnapshot data) {
    return data.docs.map((element) {
      return TaskObject(
          uid: element.id,
          task: element["taskName"] ?? "",
          date: element["date"].toString() ?? "",
          startDate: element["startDate"].toString() ?? "",
          tags: element["tags"] ?? [],
          description: element["taskDescription"] ?? "",
          completed: element["isCompleted"] ?? false);
    }).toList();
  }

  List<ToDoListCard> _taskListFromSnapshot(DocumentSnapshot data) {
    final List<ToDoListCard> toDoList = [];

    data["tags_title"].forEach((listTitle) {
      final tagColor = data["tags_colors"][data["tags_title"].indexOf(listTitle)];
      toDoList.add(ToDoListCard(
        listTitle: listTitle.toString(),
        tagColor: tagColor,
      ));
    });

    return toDoList;
  }

  Future<void> deleteToDoTask(String indexID) async {
    return await users
        .doc(currentUser.uid)
        .collection("to-do-collection")
        .doc(indexID)
        .delete();
  }

  Future<void> createToDoList(
      BuildContext context, String listName, String selectedColor) async {
    List<dynamic> data = [];
    List<dynamic> data2 = [];
    return await users.doc(currentUser.uid).get().then((val) {
      if (val.data()["tags_title"] == null &&
          val.data()["tags_title"] == null) {
        users.doc(currentUser.uid).update({
          "tags_title": ["Inbox", "School", "Daily"],
          "tags_colors": ["ef476f", "ffd166", "118ab2"]
        });
        //TITLE
        Future.delayed(Duration(milliseconds: 200), () {
          users.doc(currentUser.uid).get().then((val) {
            bool _locker = false;
            data = val.data()["tags_title"];
            data.forEach((element) {
              if (listName == element) {
                _locker = true;
                // print("true");
              }
            });
            if (listName != "" && _locker == false) {
              data.add(listName);
              users.doc(currentUser.uid).get().then((val) {
                data2 = val.data()["tags_colors"] ?? [];
                if (selectedColor != "" && selectedColor != null) {
                  data2.add(selectedColor);
                  users
                      .doc(currentUser.uid)
                      .update({"tags_colors": data2, "tags_title": data});
                  Navigator.pop(context);
                  Get.snackbar("List created", "", isDismissible: true);
                } else {
                  Get.snackbar(
                    "List color tag is invalid",
                    "$selectedColor",
                  );
                  Future.delayed(Duration(milliseconds: 2000), () {
                    Navigator.pop(context);
                    Future.delayed(Duration(milliseconds: 500), () {
                      Navigator.pop(context);
                    });
                  });
                }
              });
            } else {
              Get.snackbar(
                "List name invalid",
                "The name is already exist or empty",
              );
              Future.delayed(Duration(milliseconds: 2000), () {
                Navigator.pop(context);
                Future.delayed(Duration(milliseconds: 500), () {
                  Navigator.pop(context);
                });
              });
            }
          });
        });
      } else {
        users.doc(currentUser.uid).get().then((val) {
          bool _locker = false;
          data = val.data()["tags_title"];
          data.forEach((element) {
            if (listName == element) {
              _locker = true;
              print("true");
            }
          });
          if (listName != "" && _locker == false) {
            data.add(listName);
            users.doc(currentUser.uid).get().then((val) {
              data2 = val.data()["tags_colors"] ?? [];
              if (selectedColor != "" && selectedColor != null) {
                data2.add(selectedColor);
                users
                    .doc(currentUser.uid)
                    .update({"tags_colors": data2, "tags_title": data});
                Navigator.pop(context);
                Get.snackbar("List created", "", isDismissible: true);
              } else {
                Get.snackbar(
                  "List color tag is invalid",
                  "$selectedColor",
                );
                Future.delayed(Duration(milliseconds: 2000), () {
                  Navigator.pop(context);
                  Future.delayed(Duration(milliseconds: 500), () {
                    Navigator.pop(context);
                  });
                });
              }
            });
          } else {
            Get.snackbar(
              "List name invalid",
              "The name is already exist or empty",
            );
            Future.delayed(Duration(milliseconds: 2000), () {
              Navigator.pop(context);
              Future.delayed(Duration(milliseconds: 500), () {
                Navigator.pop(context);
              });
            });
          }
        });
      }
    });
  }

  Future<void> createToDoTask(
      BuildContext context,
      String taskName,
      String taskDescription,
      List<String> tags,
      String pickedDate,
      String startDate) async {
    if (taskName != null) {
      users.doc(currentUser.uid).collection("to-do-collection").add({
        "taskName": taskName,
        "taskDescription": taskDescription,
        "date": pickedDate,
        "startDate": startDate,
        "isCompleted": false,
        "tags": tags
      });
      Navigator.pop(context);
    } else {
      Get.snackbar("You haven't entered the title",
          "Please enter the task title firstly");
      taskName = '';
      taskDescription = '';
    }
  }

  Future<void> updateToDoTask(
      {BuildContext context,
      String taskName,
      String taskDescription,
      List<String> tags,
      String indexUID,
      bool completedValue,
      String pickedDate,
      String startDate}) async {
    if (taskName != null) {
      users
          .doc(currentUser.uid)
          .collection("to-do-collection")
          .doc(indexUID)
          .update({
        "taskName": taskName,
        "taskDescription": taskDescription,
        "date": pickedDate,
        "startDate": startDate,
        "isCompleted": false,
        "tags": tags,
      });
      Navigator.pop(context);
    } else if (completedValue != null) {
      print('a');
      users
          .doc(currentUser.uid)
          .collection("to-do-collection")
          .doc(indexUID)
          .update({
        "isCompleted": completedValue,
      });
    } else {
      Get.snackbar("You haven't entered the title",
          "Please enter the task title firstly");
      taskName = '';
      taskDescription = '';
    }
  }

  //stream index
  Stream<List<TaskObject>> get taskObject {
    return users
      .doc(currentUser.uid)
      .collection("to-do-collection")
      .snapshots()
      .map(_taskObjectFromSnapshot);
  }

  Stream<List<ToDoListCard>> get taskList {
    return users.doc(currentUser.uid).snapshots().map(_taskListFromSnapshot);
  }
}

class PomodoroTimerServices extends DatabaseServices {
  Future<void> createPomodoroRecord(String sessionName, bool isCompleted,
      String workTime, String breakTime) async {
    return await users
        .doc(currentUser.uid)
        .collection("pomodoro-collection")
        .doc()
        .set({
      "sessionName": sessionName,
      "isCompleted": isCompleted,
      "workTime": workTime,
      "breakTime": breakTime
    });
  }
}

class BadHabitServices extends DatabaseServices{
  Future<void> createBadHabitRecord(String title, int limit, {String subtitle}) async {
    return await users
      .doc(currentUser.uid)
      .collection("bad-habit-collection")
      .doc()
      .set({
        "badHabitTitle": title,
        "badHabitSubtitle": subtitle ?? "",
        "limit": limit,
        "currentCount": 0
      }
    );
  }

  Future<void> updateBadHabitRecord(String uid, {String title, int limit, int currentCount, String subtitle}) async {
    if (title != null) {
      return await users
        .doc(currentUser.uid)
        .collection("bad-habit-collection")
        .doc(uid)
        .update({
          "badHabitTitle": title ?? "" ,
          "badHabitSubtitle": subtitle ?? "",
        }
      );
    } else {
      return await users
        .doc(currentUser.uid)
        .collection("bad-habit-collection")
        .doc(uid)
        .update({
          "limit": limit,
          "currentCount": currentCount
        }
      );
    }
  }
}
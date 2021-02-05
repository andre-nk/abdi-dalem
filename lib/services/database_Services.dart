part of 'services.dart';

class DatabaseServices{

  //global reference
  final CollectionReference users = FirebaseFirestore.instance.collection('users');
  User currentUser = FirebaseAuth.instance.currentUser;
  bool isGuest = FirebaseAuth.instance.currentUser.isAnonymous;

  //custom userName
  UserData _userDataFromSnapshot(DocumentSnapshot data) {
    return UserData(
      uid: currentUser.uid,
      name: data["name"] ?? currentUser.displayName
    );
  }
  Future<void> updateUserData(String userName) async {
    return await users.doc(currentUser.uid).update({
      "name" : userName ?? ""
    });
  }

  //to do object
  List<TaskObject> _taskObjectFromSnapshot(QuerySnapshot data){
    return data.docs.map((element) {
      return TaskObject(
        uid: element.id,
        task: element["taskName"] ?? "",
        date: element["date"].toString() ?? "",
        tags: element["tags"] ?? [],
        description: element["taskDescription"] ?? "",
        completed: element["isCompleted"] ?? false
      );
    }).toList();
  }
  Future<void> deleteToDoTask(String indexID) async {
    return await users.doc(currentUser.uid).collection("to-do-collection").doc(indexID).delete();
  }

  //stream index
  Stream<List<TaskObject>> get taskObject{
    return isGuest == false ?
      users.doc(currentUser.uid).collection("to-do-collection").snapshots().map(_taskObjectFromSnapshot)
    :
      UserData(name: currentUser.displayName ?? "");
  }

  Stream<UserData> get userData{
    return isGuest == false ?
      users.doc(currentUser.uid).snapshots().map(_userDataFromSnapshot)
    :
      UserData(name: currentUser.displayName ?? "");
  }
}
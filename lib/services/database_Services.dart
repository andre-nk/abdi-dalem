part of 'services.dart';

class DatabaseServices{

  //global reference
  final CollectionReference users = FirebaseFirestore.instance.collection('users');
  User currentUser = FirebaseAuth.instance.currentUser;
  bool isGuest = FirebaseAuth.instance.currentUser.isAnonymous;


  //get custom userName
  UserData _userDataFromSnapshot(DocumentSnapshot data) {
    return UserData(
      uid: currentUser.uid,
      name: data["name"],
    );
  }

  Future<void> updateUserData(String userName) async {
    return await users.doc(currentUser.uid).update({
      "name" : userName ?? ""
    });
  }


  Stream<UserData> get userData{
    return isGuest == false ?
      users.doc(currentUser.uid).snapshots().map(_userDataFromSnapshot)
    :
      UserData(name: currentUser.displayName ?? "");
  }

}
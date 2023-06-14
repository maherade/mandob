import 'package:cloud_firestore/cloud_firestore.dart';
import '../../data/modles/user_model.dart';

class DataBaseUtils {
  // User Reference

  static CollectionReference<MyUser> getUsersCollection() {
    return FirebaseFirestore.instance
        .collection(MyUser.collectionName)
        .withConverter(
          fromFirestore: (snapshot, options) =>
              MyUser.fromJson(snapshot.data()!),
          toFirestore: (value, options) => value.toJson(),
        );
  }

  static Future<void> addUserToFireStore(MyUser myUser) {
    return getUsersCollection().doc(myUser.uId).set(myUser);
  }

  static Future<MyUser?> readUserFromFireStore(String id) async {
    DocumentSnapshot<MyUser> user = await getUsersCollection().doc(id).get();
    var myUser = user.data();
    return myUser;
  }
}

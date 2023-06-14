import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mandob/data/modles/product_model.dart';

import '../../data/modles/user_model.dart';

// User Reference

CollectionReference<MyUser> getUsersCollection() {
  return FirebaseFirestore.instance
      .collection(MyUser.collectionName)
      .withConverter(
        fromFirestore: (snapshot, options) => MyUser.fromJson(snapshot.data()!),
        toFirestore: (value, options) => value.toJson(),
      );
}

Future<void> addUserToFireStore(MyUser myUser) {
  return getUsersCollection().doc(myUser.uId).set(myUser);
}

Future<MyUser?> readUserFromFireStore(String id) async {
  DocumentSnapshot<MyUser> user = await getUsersCollection().doc(id).get();
  var myUser = user.data();
  return myUser;
}

// Products Reference
CollectionReference<ProductModel> getProductsCollection() {
  return FirebaseFirestore.instance
      .collection(
        'Products',
      )
      .withConverter<ProductModel>(
          fromFirestore: (snapshot, options) =>
              ProductModel.fromJson(snapshot.data()!),
          toFirestore: (product, options) => product.toJson());
}

Stream<QuerySnapshot<ProductModel>> getProductsFromFireStore() {
  return getProductsCollection().where('Products').snapshots();
}

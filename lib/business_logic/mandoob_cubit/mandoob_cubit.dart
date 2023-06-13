import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mandob/business_logic/mandoob_cubit/mandoob_states.dart';
import 'package:mandob/data/modles/product_model.dart';
import 'package:mandob/data/modles/user_model.dart';
import 'package:mandob/styles/color_manager.dart';
import 'package:mandob/uitiles/local/cash_helper.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../constants/firebase_errors.dart';
import '../../uitiles/database_utils/datebase_utils.dart';
import '../../widgets/toast.dart';

class MandoobCubit extends Cubit<MandoobStates> {
  MandoobCubit() : super(InitialState());

  static MandoobCubit get(context) => BlocProvider.of(context);

  bool isCheckBoxTrue = false;

  void changeCheckBox({required bool value}) {
    isCheckBoxTrue = value;
    emit(ChangeCheckBoxState());
  }

  Future<void> toPrivacy() async {
    String url =
        "https://www.freeprivacypolicy.com/live/b9836dca-bb1f-451d-9d36-9b9549719cde";
    await launch(url, forceSafariVC: false);
    emit(LaunchState());
  }

  void createAccountWithFirebaseAuth(
      String email, String password, String name, String phone) async {
    try {
      emit(SignUpLoadingState());
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      MyUser myUser = MyUser(
          uId: credential.user?.uid ?? "",
          name: name,
          email: email,
          phone: phone,
          pic: "assets/images/user.png",
          isCustomer: CashHelper.getData(key: 'isCustomer'));
      await DataBaseUtils.addUserToFireStore(myUser).then((value) {
        emit(SignUpSuccessState());
        customToast(
          title: 'Account Created Successfully',
          color: ColorManager.blue,
        );
        print("--------------Account Created");
      });
    } on FirebaseAuthException catch (e) {
      if (e.code == FirebaseErrors.weakPassword) {
      } else if (e.code == FirebaseErrors.emailInUse) {
        emit(SignUpErrorState(e.toString()));
        customToast(
          title: 'This account already exists',
          color: ColorManager.red,
        );
        print("--------------Failed To Create Account");
      }
    }
  }

  void loginWithFirebaseAuth(String email, String password) async {
    try {
      emit(LoginLoadingState());
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      MyUser? myUser =
          await DataBaseUtils.readUserFromFireStore(credential.user?.uid ?? "");
      if (myUser != null) {
        emit(LoginSuccessState());
        print("-----------Login Successfully");
        return;
      }
    } on FirebaseAuthException catch (e) {
      emit(LoginErrorState(e.toString()));
      print("-----------Login Failed");

      customToast(title: 'Invalid email or password', color: ColorManager.red);
    } catch (e) {
      customToast(title: 'Something went wrong $e', color: ColorManager.red);
    }
  }

// Future<void> saveUser({
//   required String name,
//   required String email,
//   required String phone,
//   required String id,
// })async{
//
//   emit(SaveUserLoadingState());
//
//   MyUser myUser=MyUser(
//       name: name,
//       phone: phone,
//       email: email,
//       uId: id,
//   );
//
//   FirebaseFirestore.instance.
//   collection('Drivers').
//   doc(id).
//   set(myUser.toJson()).then((value) {
//
//     debugPrint('Save User Success');
//
//     emit(SaveUserSuccessState());
//   }).catchError((error){
//
//     debugPrint('Error in userRegister is ${error.toString()}');
//     emit(SaveUserErrorState());
//
//   });
//
// }



  List<String> governmentName=[
    'محافظة الداخلية',
    'محافظة الظاهرة',
    'محافظة شمال الباطنة',
    'محافظة جنوب الباطنة',
    'محافظة البريمي',
    'محافظة الوسطى',
    'محافظة شمال الشرقية',
    'محافظة جنوب الشرقية',
    'محافظة ظفار',
    'محافظة مسقط',
    'محافظة مسندم'
  ];


  // upload product image

  File? productImage;

  ImageProvider product = const AssetImage('assets/images/location.jpg');

  var picker = ImagePicker();

  Future<void> getProductImage() async {
    final pickedFile = await picker.pickImage(
      source: ImageSource.gallery,
    );

    if (pickedFile != null) {
      productImage = File(pickedFile.path);
      product = FileImage(productImage!);
      debugPrint('Path is ${pickedFile.path}');
      emit(PickProductImageSuccessState());
    } else {
      debugPrint('No Image selected.');
      emit(PickProductImageErrorState());
    }

  }


  String ?productPath;

  Future uploadProductImage({
    required String productAddress,
    required String productPrice,
    required String productWeight,
    required String productNotes,
    required String productFrom,
    required String productTo,
    required String productGovernment,
  }){

    emit(UploadProductImageLoadingState());
    return firebase_storage.FirebaseStorage.instance.ref()
        .child('productImages/${Uri.file(productImage!.path).pathSegments.last}')
        .putFile(productImage!).then((value) {

      value.ref.getDownloadURL().then((value) {

        debugPrint('Upload Success');
        productPath = value;

        uploadProduct(
            productAddress: productAddress,
            productFrom: productFrom,
            productNotes: productNotes,
            productTo: productTo,
            productWeight: productWeight,
            productPrice: productPrice,
            productGovernment: productGovernment,
            productImage: productPath!
        );

        emit(UploadProductImageSuccessState());

      }).catchError((error){

        debugPrint('Error in Upload profileImage ${error.toString()}');
        emit(UploadProductImageErrorState());

      });

    }).catchError((error){

      debugPrint('Error in Upload profileImage ${error.toString()}');
      emit(UploadProductImageErrorState());
    });
  }

  void uploadProduct({

    required String productAddress,
    required String productPrice,
    required String productWeight,
    required String productNotes,
    required String productFrom,
    required String productTo,
    required String productImage,
    required String productGovernment,

  }){

    emit(AddProductLoadingStates());

    ProductModel productModel =ProductModel(
        productAddress: productAddress,
        productFrom: productFrom,
        productNotes: productNotes,
        productTo: productTo,
        productGovernment: productGovernment,
        productWeight: productWeight,
        productPrice: productPrice,
        productImage: productImage,
    );

    FirebaseFirestore.instance
        .collection('Products')
        .add(productModel.toJson())
        .then((value) {


      debugPrint('Add Product Success');
      emit(AddProductSuccessStates());

    }).catchError((error){

      debugPrint('Error in Add Product is:${error.toString()}');
      emit(AddProductErrorStates());

    });

  }
}

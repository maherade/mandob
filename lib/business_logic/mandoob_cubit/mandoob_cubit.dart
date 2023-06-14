import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
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
          pic: 'https://img.freepik.com/free-vector/businessman-character-avatar-isolated_24877-60111.jpg?t=st=1686738460~exp=1686739060~hmac=81237015ce0733024d3c67a813fbe61ab71869f6894f2f9fcf46097911f4c4ae',
          isCustomer: CashHelper.getData(key: 'isCustomer'));
      await addUserToFireStore(myUser).then((value) {
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

  Future<void> loginWithFirebaseAuth(String email, String password) async {
    try {
      emit(LoginLoadingState());
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      MyUser? myUser = await readUserFromFireStore(credential.user?.uid ?? "");
      if (myUser != null) {
        CashHelper.saveData(key: 'isUid', value: credential.user?.uid);
        await getUser();
        print(CashHelper.getData(key: 'isUid'));
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
    required String ?userName,
    required String ?userPhone,
    required String ?userEmail,
    required String ?userImage,
    required String ?userUid,
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
            productImage: productPath!,
            userEmail: userEmail,
            userImage: userImage,
            userName: userName,
            userPhone: userPhone,
            userUid: userUid

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
    required String ?userName,
    required String ?userPhone,
    required String ?userEmail,
    required String ?userImage,
    required String ?userUid,

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
        userEmail: userEmail,
        userImage: userImage,
        userName: userName,
        userPhone: userPhone,
        userUid: userUid
    );

    FirebaseFirestore.instance
        .collection('Products')
        .add(productModel.toJson())
        .then((value) {
      debugPrint('Add Product Success');
      emit(AddProductSuccessStates());
    }).catchError((error) {
      debugPrint('Error in Add Product is:${error.toString()}');
      emit(AddProductErrorStates());
    });
  }

  CollectionReference<ProductModel> getProductsCollection() {
    return FirebaseFirestore.instance
        .collection('products')
        .withConverter<ProductModel>(
            fromFirestore: (snapshot, options) =>
                ProductModel.fromJson(snapshot.data()!),
            toFirestore: (product, options) => product.toJson());
  }

  Stream<QuerySnapshot<ProductModel>> getProductsFromFireStore() {
    return getProductsCollection().snapshots();
  }

  MyUser? user;

  Future<void> getUser() async {
    emit(GetUserLoadingState());
    FirebaseFirestore.instance
        .collection('users')
        .doc('${CashHelper.getData(key: 'isUid')}')
        .get()
        .then((value) {
      user = MyUser.fromJson(value.data()!);
      print(user!.name);
      emit(GetUserSuccessState());

    }).catchError((error){


      emit(GetUserErrorState());

    });
    
    
    
    
  }

  // upload user image

  File? profileImage;

  ImageProvider profile = const AssetImage('assets/images/user.png');

  var picker2 = ImagePicker();

  Future<void> getProfileImage() async {
    final pickedFile = await picker2.pickImage(
      source: ImageSource.gallery,
    );

    if (pickedFile != null) {
      profileImage = File(pickedFile.path);
      profile = FileImage(profileImage!);
      debugPrint('Path is ${pickedFile.path}');
      emit(PickProfileImageSuccessState());
    } else {
      debugPrint('No Image selected.');
      emit(PickProfileImageErrorState());
    }

  }


  String ?profilePath;

  Future uploadUserImage(){

    emit(UploadProfileImageLoadingState());
    return firebase_storage.FirebaseStorage.instance.ref()
        .child('usersImage/${Uri.file(profileImage!.path).pathSegments.last}')
        .putFile(profileImage!).then((value) {

      value.ref.getDownloadURL().then((value) {

        debugPrint('Upload Success');
        profilePath = value;

        FirebaseFirestore.instance.collection('users').doc(CashHelper.getData(key: 'isUid')).update({
          'pic':'$profilePath'
        }).then((value) {

          debugPrint('Image Updates');
        });

        getUser();
        emit(UploadProfileImageSuccessState());

      }).catchError((error){

        debugPrint('Error in Upload profileImage ${error.toString()}');
        emit(UploadProfileImageErrorState());

      });

    }).catchError((error){

      debugPrint('Error in Upload profileImage ${error.toString()}');
      emit(UploadProfileImageErrorState());
    });
  }

  List<ProductModel> customerHistory=[];

  void getCustomerHistory(){

    emit(GetCustomerHistoryLoadingState());
    customerHistory=[];
    FirebaseFirestore.instance.collection('Products').get().then((value) {

      value.docs.forEach((element) {

        if(element['userUid']==CashHelper.getData(key: 'isUid')){

          customerHistory.add(ProductModel.fromJson(element.data()));

        }else{

        }

      });

      print(customerHistory.length);
      emit(GetCustomerHistorySuccessState());
    }).catchError((error){

      print('Error in getCustomerHistory is ${error.toString()}');
      emit(GetCustomerHistoryErrorState());

    });



  }



}

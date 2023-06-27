import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mandob/business_logic/mandoob_cubit/mandoob_states.dart';
import 'package:mandob/data/modles/my_products.dart';
import 'package:mandob/data/modles/pay_model.dart';
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
          pic:
              'https://img.freepik.com/free-vector/businessman-character-avatar-isolated_24877-60111.jpg?t=st=1686738460~exp=1686739060~hmac=81237015ce0733024d3c67a813fbe61ab71869f6894f2f9fcf46097911f4c4ae',
          isCustomer: CashHelper.getData(key: 'isCustomer'),
          count: 50,
          carPic:
              'https://img.freepik.com/free-vector/image-upload-concept-illustration_114360-996.jpg?w=740&t=st=1687783702~exp=1687784302~hmac=b8db28cfc86bde6e6930568483053d670e577b0d488017a4d758e9829dce51b1',
          personalIdPic:
              'https://img.freepik.com/free-vector/image-upload-concept-illustration_114360-996.jpg?w=740&t=st=1687783702~exp=1687784302~hmac=b8db28cfc86bde6e6930568483053d670e577b0d488017a4d758e9829dce51b1');
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

  List<String> governmentName = [
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
      product = const AssetImage('assets/images/location.jpg');
      debugPrint('No Image selected.');
      emit(PickProductImageErrorState());
    }
  }

  String? productPath;

  Future uploadProductImage({
    required String productAddress,
    required String productPrice,
    required String productWeight,
    required String productNotes,
    required String productFrom,
    required String productTo,
    required String productGovernment,
    required String? userName,
    required String? userPhone,
    required String? userEmail,
    required String? userImage,
    required String? userUid,
  }) {
    emit(UploadProductImageLoadingState());
    return firebase_storage.FirebaseStorage.instance
        .ref()
        .child(
            'productImages/${Uri.file(productImage!.path).pathSegments.last}')
        .putFile(productImage!)
        .then((value) {
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
            userUid: userUid);

        emit(UploadProductImageSuccessState());
      }).catchError((error) {
        debugPrint('Error in Upload profileImage ${error.toString()}');
        emit(UploadProductImageErrorState());
      });
    }).catchError((error) {
      debugPrint('Error in Upload profileImage ${error.toString()}');
      emit(UploadProductImageErrorState());
    });
  }

  CollectionReference<ProductModel> getProductsCollection() {
    return FirebaseFirestore.instance
        .collection('Products')
        .withConverter<ProductModel>(
            fromFirestore: (snapshot, options) =>
                ProductModel.fromJson(snapshot.data()!),
            toFirestore: (productModel, options) => productModel.toJson());
  }

  Future<void> uploadProduct({
    required String productAddress,
    required String productPrice,
    required String productWeight,
    required String productNotes,
    required String productFrom,
    required String productTo,
    required String productImage,
    required String productGovernment,
    required String? userName,
    required String? userPhone,
    required String? userEmail,
    required String? userImage,
    required String? userUid,
  }) async {
    emit(AddProductLoadingStates());

    ProductModel productModel = ProductModel(
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
        userUid: userUid);
    var collection = getProductsCollection();
    var docRef = collection.doc();
    productModel.productId = docRef.id;
    return docRef.set(productModel);

    // FirebaseFirestore.instance
    //     .collection('Products').doc("id").set(productModel.toJson())
    //     .then((value) {
    //   debugPrint('Add Product Success');
    //   emit(AddProductSuccessStates());
    // }).catchError((error) {
    //   debugPrint('Error in Add Product is:${error.toString()}');
    //   emit(AddProductErrorStates());
    // });
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
    }).catchError((error) {
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

  File? idImage;

  ImageProvider imageId = const AssetImage('assets/images/upload.jpg');
  var picker4 = ImagePicker();

  Future<void> getIdImage() async {
    final pickedFile = await picker4.pickImage(
      source: ImageSource.gallery,
    );

    if (pickedFile != null) {
      idImage = File(pickedFile.path);
      imageId = FileImage(idImage!);
      debugPrint('Path is ${pickedFile.path}');
      emit(PickUserIdImageSuccessState());
    } else {
      debugPrint('No Image selected.');
      emit(PickUserIdImageErrorState());
    }
  }

  ImageProvider carId = const AssetImage('assets/images/upload.jpg');
  var picker5 = ImagePicker();

  Future<void> getCarImage() async {
    final pickedFile = await picker5.pickImage(
      source: ImageSource.gallery,
    );

    if (pickedFile != null) {
      carImage = File(pickedFile.path);
      carId = FileImage(carImage!);
      debugPrint('Path is ${pickedFile.path}');
      emit(PickCarImageSuccessState());
    } else {
      debugPrint('No Image selected.');
      emit(PickCarImageErrorState());
    }
  }

  String? profilePath;

  Future uploadUserImage() {
    emit(UploadProfileImageLoadingState());
    return firebase_storage.FirebaseStorage.instance
        .ref()
        .child('usersImage/${Uri.file(profileImage!.path).pathSegments.last}')
        .putFile(profileImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        debugPrint('Upload Success');
        profilePath = value;

        FirebaseFirestore.instance
            .collection('users')
            .doc(CashHelper.getData(key: 'isUid'))
            .update({'pic': '$profilePath'}).then((value) {
          debugPrint('Image Updates');
        });

        getUser();
        emit(UploadProfileImageSuccessState());
      }).catchError((error) {
        debugPrint('Error in Upload profileImage ${error.toString()}');
        emit(UploadProfileImageErrorState());
      });
    }).catchError((error) {
      debugPrint('Error in Upload profileImage ${error.toString()}');
      emit(UploadProfileImageErrorState());
    });
  }

//upload user id image
  Future uploadUserIdImage() {
    emit(UploadUserIdImageLoadingState());
    return firebase_storage.FirebaseStorage.instance
        .ref()
        .child('usersIdImage/${Uri.file(idImage!.path).pathSegments.last}')
        .putFile(idImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        debugPrint('Upload Success');
        profilePath = value;

        FirebaseFirestore.instance
            .collection('users')
            .doc(CashHelper.getData(key: 'isUid'))
            .update({'personalIdPic': '$profilePath'}).then((value) {
          debugPrint('Image Updates');
        });

        getUser();
        emit(UploadUserIdImageSuccessState());
      }).catchError((error) {
        debugPrint('Error in Upload profileImage ${error.toString()}');
        emit(UploadUserIdImageErrorState());
      });
    }).catchError((error) {
      debugPrint('Error in Upload profileImage ${error.toString()}');
      emit(UploadUserIdImageErrorState());
    });
  }

  File? carImage;

  //upload car image
  Future uploadCarImage() {
    emit(UploadCarImageLoadingState());
    return firebase_storage.FirebaseStorage.instance
        .ref()
        .child('carImage/${Uri.file(carImage!.path).pathSegments.last}')
        .putFile(carImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        debugPrint('Upload Success');
        profilePath = value;

        FirebaseFirestore.instance
            .collection('users')
            .doc(CashHelper.getData(key: 'isUid'))
            .update({'carPic': '$profilePath'}).then((value) {
          debugPrint('Image Updates');
        });

        getUser();
        emit(UploadCarImageSuccessState());
      }).catchError((error) {
        debugPrint('Error in Upload carImage ${error.toString()}');
        emit(UploadCarImageErrorState());
      });
    }).catchError((error) {
      debugPrint('Error in Upload carImage ${error.toString()}');
      emit(UploadCarImageErrorState());
    });
  }

  List<ProductModel> customerHistory = [];

  void getCustomerHistory() {
    emit(GetCustomerHistoryLoadingState());
    customerHistory = [];
    FirebaseFirestore.instance.collection('Products').get().then((value) {
      value.docs.forEach((element) {
        if (element['userUid'] == CashHelper.getData(key: 'isUid')) {
          customerHistory.add(ProductModel.fromJson(element.data()));
        } else {}
      });

      print(customerHistory.length);
      emit(GetCustomerHistorySuccessState());
    }).catchError((error) {
      print('Error in getCustomerHistory is ${error.toString()}');
      emit(GetCustomerHistoryErrorState());
    });
  }

  List<ProductModel> mandoobHistory = [];

  void getMandoobHistory() {
    emit(GetMandoobHistoryLoadingState());
  }

  Future<void> onOrderAccepted(
    String? productAddress,
    String? productPrice,
    String? productWeight,
    String? productNotes,
    String? productFrom,
    String? productTo,
    String? productImage,
    String? productGovernment,
    String? userName,
    String? userPhone,
    String? userEmail,
    String? userImage,
    String? userUid,
  ) async {
    emit(OnOrderAcceptedLoadingState());
    await FirebaseFirestore.instance
        .collection('myProducts')
        .doc('${CashHelper.getData(key: 'isUid')}')
        .collection('orders')
        .add({
      "productAddress": productAddress,
      "productPrice": productPrice,
      "productWeight": productWeight,
      "productNotes": productNotes,
      "productFrom": productFrom,
      "productTo": productTo,
      "productImage": productImage,
      "productGovernment": productGovernment,
      "userName": userName,
      "userPhone": userPhone,
      "userEmail": userEmail,
      "userImage": userImage,
      "userUid": userUid,
    }).then((value) {
      emit(OnOrderAcceptedSuccessState());
    }).catchError((error) {
      print('Error in accept order is ${error.toString()}');
      emit(OnOrderAcceptedErrorState());
    });
  }

  List<MyProduct> myProduct = [];

  Future<void> getUserDetails() async {
    emit(GetUserDetailsLoadingState());
    myProduct = [];
    await FirebaseFirestore.instance
        .collection('myProducts')
        .doc(user!.uId)
        .collection('orders')
        .get()
        .then((value) {
      value.docs.forEach((element) {
        myProduct.add(MyProduct.fromJson(element.data()));
      });

      emit(GetUserDetailsSuccessState());
    }).catchError((error) {
      emit(GetUserDetailsErrorState());
    });
  }

  // upload pay Screen shot

  File? payImage;

  ImageProvider pay = const AssetImage('assets/images/money.jpg');

  var picker3 = ImagePicker();

  Future<void> getPayImage() async {
    final pickedFile = await picker3.pickImage(
      source: ImageSource.gallery,
    );

    if (pickedFile != null) {
      payImage = File(pickedFile.path);
      pay = FileImage(payImage!);
      debugPrint('Path is ${pickedFile.path}');
      emit(PickPayImageSuccessState());
    } else {
      debugPrint('No Image selected.');
      emit(PickPayImageErrorState());
    }
  }

  String? payPath;

  Future uploadPayImage({required int num}) {
    emit(UploadPayImageLoadingState());
    return firebase_storage.FirebaseStorage.instance
        .ref()
        .child('payImages/${Uri.file(payImage!.path).pathSegments.last}')
        .putFile(payImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        debugPrint('Upload Success');
        payPath = value;

        uploadPayModel(screen: payPath!, num: num);

        getPayScreens();
        emit(UploadPayImageSuccessState());
      }).catchError((error) {
        debugPrint('Error in Upload profileImage ${error.toString()}');
        emit(UploadPayImageErrorState());
      });
    }).catchError((error) {
      debugPrint('Error in Upload profileImage ${error.toString()}');
      emit(UploadPayImageErrorState());
    });
  }

  void uploadPayModel({required String screen, required int num}) {
    emit(UploadPayImageLoadingState());

    PayModel payModel = PayModel(
        uId: '${CashHelper.getData(key: 'isUid')}',
        name: user!.name,
        phone: user!.phone,
        isVerified: false,
        isRefuse: false,
        num: num,
        count: user!.count,
        screen: screen,
        pic: user!.pic);

    FirebaseFirestore.instance
        .collection('ScreenShots')
        .doc('${CashHelper.getData(key: 'isUid')}')
        .set(payModel.toJson())
        .then((value) {
      emit(UploadPayImageSuccessState());
    }).catchError((error) {
      print('Error is ${error.toString()}');

      emit(UploadPayImageErrorState());
    });
  }

  List<PayModel> screenShotList = [];

  void getPayScreens() {
    emit(GetScreensLoadingState());
    screenShotList = [];
    FirebaseFirestore.instance.collection('ScreenShots').get().then((value) {
      value.docs.forEach((element) {
        if (element['isVerified'] != true && element['isRefuse'] != true) {
          screenShotList.add(PayModel.fromJson(element.data()));
        }
      });

      emit(GetScreensSuccessState());
    }).catchError((error) {
      print('Error is ${error.toString()}');

      emit(GetScreensErrorState());
    });
  }

  Future isAcceptedPay({
    required String uId,
    required int num,
    required int count,
  }) async {
    emit(IsAcceptedLoadingState());

    FirebaseFirestore.instance
        .collection('ScreenShots')
        .doc(uId)
        .update({'isVerified': true}).then((value) {
      FirebaseFirestore.instance
          .collection('users')
          .doc(uId)
          .update({'count': count + num});
      getPayScreens();

      emit(IsAcceptedSuccessState());
    }).catchError((error) {
      print('Error is ${error.toString()}');

      emit(IsAcceptedErrorState());
    });
  }

  Future isRefusedPay({
    required String uId,
  }) async {
    emit(IsRefusedLoadingState());

    FirebaseFirestore.instance
        .collection('ScreenShots')
        .doc(uId)
        .update({'isRefuse': true}).then((value) {
      getPayScreens();
      emit(IsRefusedSuccessState());
    }).catchError((error) {
      print('Error is ${error.toString()}');

      emit(IsRefusedErrorState());
    });
  }

  Future<void> toPayPal() async {
    String url = "https://www.paypal.com/paypalme/alsawafi65";
    await launch(url, forceSafariVC: false);
    emit(LaunchState());
  }

  Future<void> updateMandoobCounter() {
    CollectionReference updateRef = getUsersCollection();
    return updateRef.doc(user!.uId).update({
      "count": (user!.count)! - 1,
    });
  }

  Future<void> updateIsCustomer() {
    CollectionReference updateRef = getUsersCollection();
    return updateRef.doc(user!.uId!).update({"isCustomer": true});
  }

  Future<void> updateIsMandob() {
    CollectionReference updateRef = getUsersCollection();
    return updateRef.doc(user!.uId!).update({"isCustomer": false});
  }

  Future<void> updateProductsList(ProductModel productModel) {
    CollectionReference updateRef = getProductsCollection();
    return updateRef.doc(productModel.productId).update({
      "isAccepted": true,
    });
  }

  //update delivery arrived
  Future<void> updateArrivedDelivery(ProductModel productModel) {
    CollectionReference updateRef = getProductsCollection();
    return updateRef.doc(productModel.productId).update({
      "isArrived": true,
    });
  }

  //get guest user
  Future<void> getGuestUser({
    required String id,
  }) async {
    emit(GetUserGuestLoadingState());

    FirebaseFirestore.instance.collection('users').doc(id).get().then((value) {
      user = MyUser.fromJson(value.data()!);

      debugPrint('get guest Success');

      emit(GetUserGuestSuccessState());
    }).catchError((error) {
      debugPrint('Error in getUser is ${error.toString()}');
      emit(GetUserGuestErrorState());
    });
  }
}

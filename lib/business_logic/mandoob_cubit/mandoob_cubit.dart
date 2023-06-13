import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mandob/business_logic/mandoob_cubit/mandoob_states.dart';
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
}

abstract class MandoobStates {}

class InitialState extends MandoobStates {}

class LaunchState extends MandoobStates {}

class ChangeCheckBoxState extends MandoobStates {}


// Sign Up States
class SignUpLoadingState extends MandoobStates {}

class SignUpSuccessState extends MandoobStates {}

class SignUpErrorState extends MandoobStates {
  SignUpErrorState(String error);
}

//Login States
class LoginLoadingState extends MandoobStates {}

class LoginSuccessState extends MandoobStates {}

class LoginErrorState extends MandoobStates {
  LoginErrorState(String error);
}
// //Save User
// class SaveUserLoadingState  extends MandoobStates{}
// class SaveUserSuccessState  extends MandoobStates{}
// class SaveUserErrorState  extends MandoobStates{}
//
// class GetUserLoadingState  extends MandoobStates{}
// class GetUserSuccessState  extends MandoobStates{}
// class GetUserErrorState  extends MandoobStates{}

 class PickProductImageSuccessState  extends MandoobStates{}
 class PickProductImageErrorState  extends MandoobStates{}

 class UploadProductImageLoadingState  extends MandoobStates{}
 class UploadProductImageSuccessState  extends MandoobStates{}
 class UploadProductImageErrorState  extends MandoobStates{}

 class AddProductLoadingStates  extends MandoobStates{}
 class AddProductSuccessStates  extends MandoobStates{}
 class AddProductErrorStates  extends MandoobStates{}


 class PickProfileImageSuccessState  extends MandoobStates{}
 class PickProfileImageErrorState  extends MandoobStates{}

 class UploadProfileImageLoadingState  extends MandoobStates{}
 class UploadProfileImageSuccessState  extends MandoobStates{}
 class UploadProfileImageErrorState  extends MandoobStates{}

//Get User
class GetUserLoadingState  extends MandoobStates{}
class GetUserSuccessState  extends MandoobStates{}
class GetUserErrorState  extends MandoobStates{}

class GetCustomerHistoryLoadingState  extends MandoobStates{}
class GetCustomerHistorySuccessState  extends MandoobStates{}
class GetCustomerHistoryErrorState  extends MandoobStates{}



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

//Save User
class SaveUserLoadingState extends MandoobStates {}

class SaveUserSuccessState extends MandoobStates {}

class SaveUserErrorState extends MandoobStates {}
//
// class GetUserLoadingState  extends MandoobStates{}
// class GetUserSuccessState  extends MandoobStates{}
// class GetUserErrorState  extends MandoobStates{}

class PickProductImageSuccessState extends MandoobStates {}

class PickProductImageErrorState extends MandoobStates {}

class UploadProductImageLoadingState extends MandoobStates {}

class UploadProductImageSuccessState extends MandoobStates {}

class UploadProductImageErrorState extends MandoobStates {}

class AddProductLoadingStates extends MandoobStates {}

class AddProductSuccessStates extends MandoobStates {}

class AddProductErrorStates extends MandoobStates {}


class GetProductsLoadingStates extends MandoobStates{}
class GetProductsSuccessStates extends MandoobStates{}
class GetProductsErrorStates extends MandoobStates{}

class ChangeGovernmentState extends MandoobStates {}

class PickProfileImageSuccessState extends MandoobStates {}

class PickProfileImageErrorState extends MandoobStates {}

class UploadProfileImageLoadingState extends MandoobStates {}

class UploadProfileImageSuccessState extends MandoobStates {}

class UploadProfileImageErrorState extends MandoobStates {}

// user id image
class PickUserIdImageLoadingState extends MandoobStates {}

class PickUserIdImageSuccessState extends MandoobStates {}

class PickUserIdImageErrorState extends MandoobStates {}

class UploadUserIdImageLoadingState extends MandoobStates {}

class UploadUserIdImageSuccessState extends MandoobStates {}

class UploadUserIdImageErrorState extends MandoobStates {}

//car image
class PickCarImageLoadingState extends MandoobStates {}

class PickCarImageSuccessState extends MandoobStates {}

class PickCarImageErrorState extends MandoobStates {}

class UploadCarImageLoadingState extends MandoobStates {}

class UploadCarImageSuccessState extends MandoobStates {}

class UploadCarImageErrorState extends MandoobStates {}

//Get User
class GetUserLoadingState extends MandoobStates {}

class GetUserSuccessState extends MandoobStates {}

class GetUserErrorState extends MandoobStates {}

//Guest
class GetUserGuestLoadingState extends MandoobStates {}

class GetUserGuestSuccessState extends MandoobStates {}

class GetUserGuestErrorState extends MandoobStates {}

class GetUserDetailsLoadingState extends MandoobStates {}

class GetUserDetailsSuccessState extends MandoobStates {}

class GetUserDetailsErrorState extends MandoobStates {}

class GetCustomerHistoryLoadingState extends MandoobStates {}

class GetCustomerHistorySuccessState extends MandoobStates {}

class GetCustomerHistoryErrorState extends MandoobStates {}

class GetMandoobHistoryLoadingState extends MandoobStates {}

class GetMandoobHistorySuccessState extends MandoobStates {}

class GetMandoobHistoryErrorState extends MandoobStates {}

class PickPayImageSuccessState extends MandoobStates {}

class PickPayImageErrorState extends MandoobStates {}

class UploadPayImageLoadingState extends MandoobStates {}

class UploadPayImageSuccessState extends MandoobStates {}

class UploadPayImageErrorState extends MandoobStates {}

class GetScreensLoadingState extends MandoobStates {}

class GetScreensSuccessState extends MandoobStates {}

class GetScreensErrorState extends MandoobStates {}

class IsAcceptedLoadingState extends MandoobStates {}

class IsAcceptedSuccessState extends MandoobStates {}

class IsAcceptedErrorState extends MandoobStates {}

class IsRefusedLoadingState extends MandoobStates {}

class IsRefusedSuccessState extends MandoobStates {}

class IsRefusedErrorState extends MandoobStates {}

class OnOrderAcceptedLoadingState extends MandoobStates {}

class OnOrderAcceptedSuccessState extends MandoobStates {}

class OnOrderAcceptedErrorState extends MandoobStates {}

class SaveTokenLoadingState extends MandoobStates {}

class SaveTokenSuccessState extends MandoobStates {}

class SaveTokenErrorState extends MandoobStates {}

class GetTokenLoadingState extends MandoobStates {}

class GetTokenSuccessState extends MandoobStates {}

class GetTokenErrorState extends MandoobStates {}

class CreateNotificationSuccessState extends MandoobStates {}

class CreateNotificationLoadingState extends MandoobStates {}

class CreateNotificationErrorState extends MandoobStates {}

class SaveNotificationLoadingState extends MandoobStates {}

class SaveNotificationSuccessState extends MandoobStates {}

class SaveNotificationErrorState extends MandoobStates {}

class UpdateMandoobCounterLoadingState extends MandoobStates {}

class UpdateMandoobCounterSuccessState extends MandoobStates {}

class UpdateMandoobCounterErrorState extends MandoobStates {}

class DeleteUserLoadingState extends MandoobStates {}

class DeleteUserSuccessState extends MandoobStates {}

class DeleteUserErrorState extends MandoobStates {}

abstract class MandoobStates {}

class InitialState extends MandoobStates {}

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

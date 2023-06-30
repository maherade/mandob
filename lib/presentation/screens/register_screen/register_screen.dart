import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:mandob/business_logic/localization_cubit/app_localization.dart';
import 'package:mandob/business_logic/mandoob_cubit/mandoob_states.dart';
import 'package:mandob/presentation/screens/customer/customer_screen/customer_screen.dart';
import 'package:mandob/presentation/screens/customer/profile_screen/profile_screen.dart';
import 'package:mandob/presentation/screens/login_screen/login_screen.dart';
import 'package:mandob/presentation/screens/mandob/mandob.dart';
import 'package:mandob/styles/color_manager.dart';
import 'package:mandob/uitiles/local/cash_helper.dart';
import 'package:mandob/widgets/default_text_field.dart';
import 'package:mandob/widgets/defualtButton.dart';

import '../../../business_logic/mandoob_cubit/mandoob_cubit.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  var emailController = TextEditingController();
  var phoneController = TextEditingController();
  var passwordController = TextEditingController();
  var userNameController = TextEditingController();
  bool isPassword = false;

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context).size;

    return BlocConsumer<MandoobCubit,MandoobStates>(
        listener: (context,state){

        },
      builder: (context,state){
          var cubit=MandoobCubit.get(context);
          return SafeArea(
            child: Scaffold(
              backgroundColor: ColorManager.lightColor,
              appBar: AppBar(
                backgroundColor: Colors.transparent,
                elevation: 0.0,
              ),
              body: Column(
                children: [

                  Expanded(
                    child: Lottie.asset(
                        "assets/images/login.json",
                        height: MediaQuery.of(context).size.height*.2
                    ),
                  ),

                  Expanded(
                    flex: 2,
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Form(
                          key: formKey,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                                child: DefaultTextField(
                                  hintText: AppLocalizations.of(context)!
                                      .translate("userName")
                                      .toString(),
                                  controller: userNameController,
                                  textInputType: TextInputType.name,
                                  prefixIcon: Icons.edit,
                                ),
                              ),
                              SizedBox(
                                height: mediaQuery.height * .02,
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                                child: DefaultTextField(
                                  hintText: AppLocalizations.of(context)!
                                      .translate("phoneNumber")
                                      .toString(),
                                  controller: phoneController,
                                  textInputType: TextInputType.phone,
                                  prefixIcon: Icons.phone,
                                ),
                              ),
                              SizedBox(
                                height: mediaQuery.height * .02,
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                                child: DefaultTextField(
                                  hintText: AppLocalizations.of(context)!
                                      .translate("email")
                                      .toString(),
                                  controller: emailController,
                                  textInputType: TextInputType.emailAddress,
                                  prefixIcon: Icons.email,
                                ),
                              ),
                              SizedBox(
                                height: mediaQuery.height * .02,
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                                child: DefaultTextField(
                                  hintText: AppLocalizations.of(context)!
                                      .translate("password")
                                      .toString(),
                                  controller: passwordController,
                                  textInputType: TextInputType.text,
                                  prefixIcon: Icons.lock,
                                  isPass: true,
                                ),
                              ),
                              SizedBox(
                                height: mediaQuery.height * .02,
                              ),
                              state is SignUpLoadingState?
                              const Center(
                                child: CircularProgressIndicator(
                                  color: ColorManager.primaryColor,
                                ),
                              ):
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                                child: DefaultButton(
                                    buttonText: AppLocalizations.of(context)!
                                        .translate("signUp")
                                        .toString(),
                                    onPressed: () {
                                      if (CashHelper.getData(key: 'isCustomer') ==
                                          true) {
                                        validateForm(const LoginScreen());
                                      } else if (CashHelper.getData(
                                          key: 'isCustomer') ==
                                          false) {
                                        validateForm(const LoginScreen());
                                      }
                                    },
                                    width: mediaQuery.width * .6,
                                    color2: ColorManager.primaryColor),
                              ),
                              SizedBox(
                                height: mediaQuery.height * .01,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    AppLocalizations.of(context)!
                                        .translate("doYouHaveAccount?")
                                        .toString(),
                                    style: GoogleFonts.cairo(
                                        fontWeight: FontWeight.w500,
                                        color: ColorManager.textColor),
                                  ),
                                  TextButton(
                                      onPressed: () {
                                        Navigator.of(context).pushReplacement(
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                const LoginScreen()));
                                      },
                                      child: Text(
                                        AppLocalizations.of(context)!
                                            .translate("login")
                                            .toString(),
                                        style: GoogleFonts.cairo(
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold,
                                            color: ColorManager.primaryColor),
                                      )),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
      },
    );
  }

  void validateForm(Widget widget) {
    if (formKey.currentState!.validate()) {
      MandoobCubit.get(context).createAccountWithFirebaseAuth(
        emailController.text,
        passwordController.text,
        userNameController.text,
        phoneController.text,
      );
      emailController.clear();
      passwordController.clear();
      userNameController.clear();
      phoneController.clear();
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (_) => widget));
    }
  }
}
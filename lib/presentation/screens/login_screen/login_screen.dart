import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:mandob/business_logic/localization_cubit/app_localization.dart';
import 'package:mandob/business_logic/mandoob_cubit/mandoob_cubit.dart';
import 'package:mandob/presentation/screens/admin/admin_screen.dart';
import 'package:mandob/presentation/screens/customer/customer_screen/customer_screen.dart';
import 'package:mandob/presentation/screens/mandob/mandob.dart';
import 'package:mandob/presentation/screens/register_screen/register_screen.dart';
import 'package:mandob/styles/color_manager.dart';
import 'package:mandob/uitiles/local/cash_helper.dart';
import 'package:mandob/widgets/default_text_field.dart';
import 'package:mandob/widgets/defualtButton.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  bool visible = true;

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context).size;

    return SafeArea(
      child: Scaffold(
        backgroundColor: ColorManager.lightColor,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: mediaQuery.height * .1,
            ),
            Expanded(
              flex: 1,
              child: Lottie.asset(
                "assets/images/login.json",
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
                          SizedBox(
                            height: mediaQuery.height * .02,
                          ),
                          SizedBox(
                            height: mediaQuery.height * .02,
                          ),
                          DefaultTextField(
                            hintText: AppLocalizations.of(context)!
                                .translate('email')
                                .toString(),
                            controller: emailController,
                            textInputType: TextInputType.emailAddress,
                            prefixIcon: Icons.email,
                          ),
                          SizedBox(
                            height: mediaQuery.height * .02,
                          ),
                          DefaultTextField(
                            hintText: AppLocalizations.of(context)!
                                .translate('password')
                                .toString(),
                            controller: passwordController,
                            textInputType: TextInputType.text,
                            prefixIcon: Icons.lock,
                            isPass: true,
                          ),
                          SizedBox(
                            height: mediaQuery.height * .02,
                          ),
                          DefaultButton(
                              buttonText: AppLocalizations.of(context)!
                                  .translate('login')
                                  .toString(),
                              onPressed: () {
                                if (CashHelper.getData(key: 'isCustomer') ==
                                    true) {
                                  if (emailController.text == 'Mandoob' &&
                                      passwordController.text ==
                                          'Mandoob2023') {
                                    Navigator.push(context,
                                        MaterialPageRoute(builder: (_) {
                                      return const AdminScreen();
                                    }));
                                  } else {
                                    validateForm(const CustomerScreen());
                                  }
                                } else if (CashHelper.getData(
                                        key: 'isCustomer') ==
                                    false) {
                                  if (emailController.text == 'Mandoob' &&
                                      passwordController.text ==
                                          'Mandoob2023') {
                                    Navigator.push(context,
                                        MaterialPageRoute(builder: (_) {
                                      return const AdminScreen();
                                    }));
                                  } else {
                                    validateForm(const MandobScreen());
                                  }
                                }
                              },
                              width: mediaQuery.width * .6,
                              color2: ColorManager.primaryColor),
                          SizedBox(
                            height: mediaQuery.height * .01,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                AppLocalizations.of(context)!
                                    .translate("don'tHaveAnAccount?")
                                    .toString(),
                                style: const TextStyle(
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.bold,
                                    color: ColorManager.textColor),
                              ),
                              TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pushReplacement(
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const RegisterScreen()));
                                  },
                                  child: Text(
                                    AppLocalizations.of(context)!
                                        .translate("signUp")
                                        .toString(),
                                    style: const TextStyle(
                                        fontSize: 18.0,
                                        fontWeight: FontWeight.bold,
                                        color: ColorManager.primaryColor),
                                  )),
                            ],
                          ),
                          SizedBox(
                            height: mediaQuery.height * .01,
                          ),
                          TextButton(
                              onPressed: () {
                                MandoobCubit.get(context)
                                    .getGuestUser(id: "IqRzvBp4Po9wE1v91ASo")
                                    .then((value) => Navigator.push(
                                          context,
                                          MaterialPageRoute(builder: (_) {
                                            return const MandobScreen();
                                          }),
                                        ));
                              },
                              child: Text(
                                AppLocalizations.of(context)!
                                    .translate("loginAsGuest")
                                    .toString(),
                                style: const TextStyle(
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.bold,
                                    color: ColorManager.primaryColor),
                              )),
                        ],
                      ),
                    )),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void validateForm(Widget widget) {
    if (formKey.currentState!.validate()) {
      MandoobCubit.get(context).loginWithFirebaseAuth(
        emailController.text,
        passwordController.text,
      ).then((value) {
        emailController.clear();
        passwordController.clear();
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (_) => widget));
      });
    }
  }
}

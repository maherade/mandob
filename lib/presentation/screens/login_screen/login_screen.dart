import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:mandob/business_logic/mandoob_cubit/mandoob_cubit.dart';
import 'package:mandob/presentation/screens/customer/customer_screen.dart';
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
                  child: CashHelper.getData(key: CashHelper.languageKey)
                              .toString() ==
                          'en'
                      ? Form(
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
                                hintText: 'Email',
                                controller: emailController,
                                textInputType: TextInputType.emailAddress,
                                prefixIcon: Icons.email,
                              ),
                              SizedBox(
                                height: mediaQuery.height * .02,
                              ),
                              DefaultTextField(
                                hintText: 'Password',
                                controller: passwordController,
                                textInputType: TextInputType.text,
                                prefixIcon: Icons.lock,
                                isPass: true,
                              ),
                              SizedBox(
                                height: mediaQuery.height * .02,
                              ),
                              DefaultButton(
                                  buttonText: 'Login',
                                  onPressed: () {
                                    if (CashHelper.getData(key: 'isCustomer') ==
                                        true) {
                                      validateForm(const CustomerScreen());
                                    } else if (CashHelper.getData(
                                            key: 'isCustomer') ==
                                        false) {
                                      validateForm(const MandobScreen());
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
                                  const Text(
                                    "Don't have an Account?",
                                    style: TextStyle(
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
                                      child: const Text(
                                        "Create Account",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: ColorManager.primaryColor),
                                      )),
                                ],
                              )
                            ],
                          ),
                        )
                      : Form(
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
                                hintText: 'البريد الالكتروني',
                                controller: emailController,
                                textInputType: TextInputType.emailAddress,
                                prefixIcon: Icons.email,
                              ),
                              SizedBox(
                                height: mediaQuery.height * .02,
                              ),
                              DefaultTextField(
                                hintText: 'كلمة المرور',
                                controller: passwordController,
                                textInputType: TextInputType.text,
                                prefixIcon: Icons.lock,
                                isPass: true,
                              ),
                              SizedBox(
                                height: mediaQuery.height * .02,
                              ),
                              DefaultButton(
                                  buttonText: 'تسجيل الدخول',
                                  onPressed: () {
                                    if (CashHelper.getData(key: 'isCustomer') ==
                                        true) {
                                      validateForm(const CustomerScreen());
                                    } else if (CashHelper.getData(
                                            key: 'isCustomer') ==
                                        false) {
                                      validateForm(const MandobScreen());
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
                                  const Text(
                                    "ليس لديك حساب ؟",
                                    style: TextStyle(
                                        fontSize: 18,
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
                                      child: const Text(
                                        "إنشاء حساب",
                                        style: TextStyle(
                                            fontSize: 18,
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
  }

  void validateForm(Widget widget) {
    if (formKey.currentState!.validate()) {
      MandoobCubit.get(context).loginWithFirebaseAuth(
        emailController.text,
        passwordController.text,
      );
      emailController.clear();
      passwordController.clear();
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (_) => widget));
    }
  }
}

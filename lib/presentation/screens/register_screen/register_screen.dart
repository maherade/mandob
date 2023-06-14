import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:mandob/presentation/screens/login_screen/login_screen.dart';
import 'package:mandob/presentation/screens/mandob/mandob.dart';
import 'package:mandob/styles/color_manager.dart';
import 'package:mandob/uitiles/local/cash_helper.dart';
import 'package:mandob/widgets/default_text_field.dart';
import 'package:mandob/widgets/defualtButton.dart';

import '../../../business_logic/mandoob_cubit/mandoob_cubit.dart';
import '../customer/customer_screen/customer_screen.dart';

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

    return SafeArea(
      child: Scaffold(
        backgroundColor: ColorManager.lightColor,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0.0,
        ),
        body: Column(
          children: [
            SizedBox(
              height: mediaQuery.height * .04,
            ),
            Expanded(
              flex: 1,
              child: Lottie.asset(
                "assets/images/welcome.json",
              ),
            ),
            SizedBox(
              height: mediaQuery.height * .04,
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
                              DefaultTextField(
                                hintText: 'User Name',
                                controller: userNameController,
                                textInputType: TextInputType.name,
                                prefixIcon: Icons.edit,
                              ),
                              SizedBox(
                                height: mediaQuery.height * .02,
                              ),
                              DefaultTextField(
                                hintText: 'Phone Number',
                                controller: phoneController,
                                textInputType: TextInputType.phone,
                                prefixIcon: Icons.phone,
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
                                  buttonText: 'Create Account',
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
                                    "Do You have an Account?",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: ColorManager.textColor),
                            ),
                            TextButton(
                                onPressed: () {
                                  Navigator.of(context).pushReplacement(
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const LoginScreen()));
                                },
                                      child: const Text(
                                        "Login",
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
                              DefaultTextField(
                                hintText: 'اسم المستخدم',
                                controller: userNameController,
                                textInputType: TextInputType.name,
                                prefixIcon: Icons.edit,
                              ),
                              SizedBox(
                                height: mediaQuery.height * .02,
                              ),
                              DefaultTextField(
                                hintText: 'رقم الهاتف',
                                controller: phoneController,
                                textInputType: TextInputType.phone,
                                prefixIcon: Icons.phone,
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
                                  buttonText: 'إنشاء حساب',
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
                                    "لديك حساب بالفعل؟",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: ColorManager.textColor),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pushReplacement(
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const LoginScreen()));
                                    },
                                    child: const Text(
                                      "تسجيل الدخول",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: ColorManager.primaryColor),
                                    ),
                                  ),
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

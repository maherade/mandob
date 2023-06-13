import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:mandob/business_logic/mandoob_cubit/mandoob_cubit.dart';
import 'package:mandob/presentation/screens/customer/customer_screen.dart';
import 'package:mandob/presentation/screens/register_screen/register_screen.dart';
import 'package:mandob/presentation/screens/test.dart';
import 'package:mandob/styles/color_manager.dart';
import 'package:mandob/uitiles/local/cash_helper.dart';

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
        backgroundColor: ColorManager.lightColor2,
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
                        TextFormField(
                          style: const TextStyle(color: ColorManager.textColor),
                          cursorColor: ColorManager.textColor,
                          textInputAction: TextInputAction.next,
                          keyboardType: TextInputType.emailAddress,
                          controller: emailController,
                          validator: (text) {
                            if (text!.trim() == "") {
                              return "Please Enter Your Email";
                            }
                            final bool emailValid = RegExp(
                                    r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                .hasMatch(text);
                            if (emailValid == false) {
                              return "Please Enter Valid Email";
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            suffixIcon: const Icon(
                              Icons.email,
                              color: ColorManager.textColor,
                            ),
                            labelText: "Email",
                            labelStyle: const TextStyle(
                              color: ColorManager.textColor,
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                              borderSide: const BorderSide(
                                  color: ColorManager.textColor),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                              borderSide: const BorderSide(
                                  color: ColorManager.textColor),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: mediaQuery.height * .02,
                        ),
                        TextFormField(
                          style: const TextStyle(color: ColorManager.textColor),
                          cursorColor: ColorManager.textColor,
                          textInputAction: TextInputAction.done,
                          keyboardType: TextInputType.name,
                          controller: passwordController,
                          validator: (text) {
                            if (text!.trim() == "") {
                              return "Please Enter Your Password";
                            }
                            return null;
                          },
                          obscureText: visible,
                          decoration: InputDecoration(
                            suffixIcon: IconButton(
                              onPressed: () {
                                setState(() {
                                  visible = !visible;
                                });
                              },
                              icon: Icon(
                                visible
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                                color: ColorManager.textColor,
                              ),
                            ),
                            labelText: "Password",
                            labelStyle: const TextStyle(
                              color: ColorManager.textColor,
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                              borderSide: const BorderSide(
                                  color: ColorManager.textColor),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                              borderSide: const BorderSide(
                                  color: ColorManager.textColor),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: mediaQuery.height * .02,
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          width: mediaQuery.width * .8,
                          height: mediaQuery.height * .06,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              primary: ColorManager.darkGrey,
                              elevation: 15.0,
                            ),
                            onPressed: () {
                              if (CashHelper.getData(key: 'isCustomer') ==
                                  true) {
                                validateForm(const CustomerScreen());
                              } else if (CashHelper.getData(
                                      key: 'isCustomer') ==
                                  false) {
                                validateForm(const TestScreens());
                              }
                            },
                            child: const Text(
                              "Login",
                              style: TextStyle(
                                  fontSize: 18,
                                  color: ColorManager.lightColor2),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: mediaQuery.height * .01,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              "Don't You have an Account?",
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
                                      color: ColorManager.textColor),
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

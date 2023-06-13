import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:mandob/presentation/screens/login_screen/login_screen.dart';
import 'package:mandob/styles/color_manager.dart';

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
  bool visible = true;

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context).size;

    return SafeArea(
      child: Scaffold(
        backgroundColor: ColorManager.lightColor2,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          centerTitle: true,
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
                  child: Form(
                    key: formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextFormField(
                          style: const TextStyle(color: ColorManager.textColor),
                          cursorColor: ColorManager.textColor,
                          textInputAction: TextInputAction.next,
                          controller: userNameController,
                          keyboardType: TextInputType.name,
                          validator: (text) {
                            if (text!.trim() == "") {
                              return "Please Enter Your User Name";
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            suffixIcon: const Icon(
                              Icons.edit,
                              color: ColorManager.textColor,
                            ),
                            labelText: "User Name",
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
                          controller: phoneController,
                          textInputAction: TextInputAction.next,
                          keyboardType: TextInputType.phone,
                          validator: (text) {
                            if (text!.trim() == "") {
                              return "Please Enter Your Phone Number";
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            suffixIcon: const Icon(
                              Icons.phone,
                              color: ColorManager.textColor,
                            ),
                            labelText: "Phone Number",
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
                          controller: emailController,
                          textInputAction: TextInputAction.next,
                          keyboardType: TextInputType.emailAddress,
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
                          controller: passwordController,
                          textInputAction: TextInputAction.done,
                          keyboardType: TextInputType.name,
                          obscureText: visible,
                          validator: (text) {
                            if (text!.trim() == "") {
                              return "Please Enter Your Password";
                            }
                            return null;
                          },
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
                              validateForm();
                            },
                            child: const Text(
                              "Create Account",
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

  void validateForm() {
    if (formKey.currentState!.validate()) {
      MandoobCubit.get(context).createAccountWithFirebaseAuth(
          emailController.text,
          passwordController.text,
          userNameController.text,
          phoneController.text);

      emailController.clear();
      passwordController.clear();
      userNameController.clear();
      phoneController.clear();
    }
  }
}

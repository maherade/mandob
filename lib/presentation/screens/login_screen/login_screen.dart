import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:mandob/presentation/screens/register_screen/register_screen.dart';
import 'package:mandob/styles/color_manager.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

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
                            borderSide:
                                const BorderSide(color: ColorManager.textColor),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide:
                                const BorderSide(color: ColorManager.textColor),
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
                        obscureText: true,
                        decoration: InputDecoration(
                          suffixIcon: const Icon(
                            Icons.visibility,
                            color: ColorManager.textColor,
                          ),
                          labelText: "Password",
                          labelStyle: const TextStyle(
                            color: ColorManager.textColor,
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide:
                                const BorderSide(color: ColorManager.textColor),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide:
                                const BorderSide(color: ColorManager.textColor),
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
                          onPressed: () {},
                          child: const Text(
                            "Login",
                            style: TextStyle(
                                fontSize: 18, color: ColorManager.lightColor2),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: mediaQuery.height * .01,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextButton(
                              onPressed: () {
                                Navigator.of(context).pushReplacement(
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            RegisterScreen()));
                              },
                              child: const Text(
                                "Create Account",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: ColorManager.textColor),
                              )),
                          const Text(
                            "? Don't You have an Account",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: ColorManager.textColor),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

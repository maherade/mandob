
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:mandob/presentation/screens/home_screen/home_screen.dart';
import 'package:mandob/presentation/screens/test.dart';
import 'package:mandob/styles/color_manager.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    //
    Future.delayed(const Duration(seconds: 3),(){

      Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
      const HomeScreen()
      ), (Route<dynamic> route) => false);

    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        toolbarHeight: 0.0,
        elevation: 0.0,
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarIconBrightness: Brightness.dark,
          statusBarColor: ColorManager.lightColor,
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.topRight,
            colors: [
              ColorManager.lightColor2,
              ColorManager.lightColor,
              ColorManager.lightColor,
              ColorManager.lightColor2,
            ]
          )
        ),
        height: double.infinity,
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children:  [

            Image(
              fit: BoxFit.contain,
              image: const AssetImage('assets/images/logo.jpeg'),
              height: MediaQuery.of(context).size.height*.55,
              width: double.infinity,
            ),

            // Text(
            //   'دكانه',
            //   style: GoogleFonts.cairo(
            //     fontSize: 32.0,
            //     fontWeight: FontWeight.w700,
            //     color: ColorManager.white,
            //   ),
            //   textAlign: TextAlign.center,
            // ),
          ],
        ),
      ),
    );
  }
}

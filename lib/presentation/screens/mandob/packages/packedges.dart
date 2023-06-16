import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:mandob/styles/color_manager.dart';
import 'package:mandob/widgets/package_item.dart';

class Packages extends StatelessWidget {
  const Packages({super.key});

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: ColorManager.lightColor,
      appBar: AppBar(
        titleSpacing: 0.0,
        iconTheme: const IconThemeData(color: ColorManager.textColor),
        backgroundColor: ColorManager.lightColor,
        elevation: 0.0,
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarIconBrightness: Brightness.dark,
          statusBarColor: ColorManager.lightColor,
        ),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            color: ColorManager.textColor,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          'شراء باقات توصيل',
          style: GoogleFonts.cairo(
            fontSize: 20.0,
            fontWeight: FontWeight.w700,
            color: ColorManager.textColor,
          ),
          textAlign: TextAlign.center,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 5.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Lottie.asset("assets/images/pay.json",
                  height: mediaQuery.height * .35),
              Text(
                "اختر باقة التوصيل المناسبة لك",
                style: GoogleFonts.cairo(
                  fontSize: 20.0,
                  fontWeight: FontWeight.w700,
                  color: ColorManager.textColor,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: mediaQuery.height * .03,
              ),
              GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: mediaQuery.width * .00,
                mainAxisSpacing: mediaQuery.height * .03,
                shrinkWrap: true,
                children: [
                  PackageItem(
                    onPressed: () {
                      print("10");
                    },
                    tittle: "10 توصيلات",
                    price: "10 دولار",
                    backgroundColor: ColorManager.primaryColor,
                    textColor: ColorManager.lightColor2,
                  ),
                  PackageItem(
                    onPressed: () {
                      print("20");
                    },
                    tittle: "20 توصيلة",
                    price: "20 دولار",
                    backgroundColor: Colors.deepPurple.shade700,
                    textColor: ColorManager.lightColor2,
                  ),
                  PackageItem(
                    onPressed: () {
                      print("30");
                    },
                    tittle: "30 توصيلة",
                    price: "30 دولار",
                    backgroundColor: Colors.green.shade700,
                    textColor: ColorManager.lightColor2,
                  ),
                  PackageItem(
                    onPressed: () {
                      print("40");
                    },
                    tittle: "40 توصيلة",
                    price: "40 دولار",
                    backgroundColor: Colors.blue.shade700,
                    textColor: ColorManager.lightColor2,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

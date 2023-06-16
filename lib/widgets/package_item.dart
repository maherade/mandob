import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PackageItem extends StatelessWidget {
  Color? backgroundColor;
  Color? textColor;
  String? tittle;
  String? price;
  final Function onPressed;

  PackageItem(
      {required this.tittle,
      required this.price,
      required this.backgroundColor,
      required this.textColor,
      required this.onPressed});

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context).size;
    return MaterialButton(
      onPressed: () {
        onPressed();
      },
      height: mediaQuery.height * .2,
      minWidth: mediaQuery.width * .6,
      child: Container(
        // width: mediaQuery.width * .55,
        // height: mediaQuery.height * .2,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20), color: backgroundColor),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
                child: Text(
              "$tittle",
              style: GoogleFonts.cairo(
                fontSize: 20.0,
                fontWeight: FontWeight.w700,
                color: textColor,
              ),
              textAlign: TextAlign.center,
            )),
            Center(
                child: Text(
              "$price",
              style: GoogleFonts.cairo(
                fontSize: 20.0,
                fontWeight: FontWeight.w700,
                color: textColor,
              ),
              textAlign: TextAlign.center,
            )),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PackageItem extends StatelessWidget {
  Color? backgroundColor;
  Color? textColor;
  String? tittle;
  String? price;
  bool? isClicked;
  final Function onPressed;

  PackageItem(
      {super.key,
      required this.tittle,
      required this.price,
      required this.backgroundColor,
      required this.textColor,
      this.isClicked = true,
      required this.onPressed});

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context).size;
    return Material(
      elevation: 10,
      color: backgroundColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: MaterialButton(
        elevation: 10,
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
      ),
    );
  }
}

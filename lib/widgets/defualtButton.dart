import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mandob/styles/color_manager.dart';


class DefaultButton extends StatelessWidget {
  final String buttonText;
  final Function onPressed;
  Color? color;
  Color? color2;
  double ?radies;
  Color ?textColor;
  String ?icon;
  double ? width;

  DefaultButton(
      {required this.buttonText,
      required this.onPressed,
      this.icon,
      this.radies = 7,
      this.color = ColorManager.primaryColor,
      this.color2 = ColorManager.white,
      this.textColor = Colors.white,
      this.width,
      Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width : double.infinity,
      height: 50,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(radies!),
        gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              color!,
              color2!,
            ]),
      ),
      child: MaterialButton(
        onPressed: (){
          onPressed();
        },
        child: icon==null? Text(
          buttonText,
          style: GoogleFonts.almarai(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: textColor,
          ),
        ):
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              buttonText,
              style: GoogleFonts.almarai(
                fontSize: 16,
                fontWeight: FontWeight.w400,
                color: textColor,
              ),
            ),
            SizedBox(width: MediaQuery.of(context).size.height*.01,),
            Image(image: AssetImage('assets/images/$icon')),
          ],
        ),
      ),
    );
  }
}

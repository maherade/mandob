import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mandob/styles/color_manager.dart';

import '../../../../widgets/default_text_field.dart';
import '../../mandob/mandob.dart';
import '../customer_screen/customer_screen.dart';

class CustomerDetailsScreen extends StatelessWidget {
  final String name;
  final String phone;
  final String pic;

  const CustomerDetailsScreen(
      {super.key, required this.pic, required this.phone, required this.name});

  @override
  Widget build(BuildContext context) {
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
            onPressed: () {
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (_) => const MandobScreen()));
            },
            icon: const Icon(Icons.arrow_back_ios)),
        title: Text(
          'تفاصيل الزبون',
          style: GoogleFonts.cairo(
            fontSize: 20.0,
            fontWeight: FontWeight.w700,
            color: ColorManager.textColor,
          ),
          textAlign: TextAlign.center,
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(
              horizontal: MediaQuery.sizeOf(context).height * .02),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
                child: Image.network(
                  "${pic}",
                  fit: BoxFit.fitWidth,
                ),
              ),
              SizedBox(
                height: MediaQuery.sizeOf(context).height * .015,
              ),
              // العنوان
              Text(
                'الاسم',
                style: GoogleFonts.cairo(
                  fontSize: 18.0,
                  fontWeight: FontWeight.w700,
                  color: ColorManager.textColor,
                ),
                textAlign: TextAlign.center,
              ),
              DefaultTextField(
                  hintText: "${name}",
                  isPass: false,
                  isEnabled: false,
                  prefixIcon: Icons.drive_file_rename_outline,
                  controller: CustomerScreen.fromController,
                  textInputType: TextInputType.text),
              SizedBox(
                height: MediaQuery.sizeOf(context).height * .015,
              ),

              Text(
                'رقم الهاتف',
                style: GoogleFonts.cairo(
                  fontSize: 18.0,
                  fontWeight: FontWeight.w700,
                  color: ColorManager.textColor,
                ),
                textAlign: TextAlign.center,
              ),
              Container(
                padding:
                    EdgeInsets.all(MediaQuery.sizeOf(context).height * .02),
                alignment: AlignmentDirectional.centerStart,
                height: MediaQuery.sizeOf(context).height * .07,
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: Colors.white,
                ),
                child: Row(
                  children: [
                    const Icon(
                      Icons.phone_android,
                      color: Colors.grey,
                    ),
                    SizedBox(
                      width: MediaQuery.sizeOf(context).height * .01,
                    ),
                    Text(
                      "${phone}",
                      style: GoogleFonts.almarai(
                          fontSize: 16.0,
                          fontWeight: FontWeight.w300,
                          color: Colors.grey),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

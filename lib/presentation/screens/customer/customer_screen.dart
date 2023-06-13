import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mandob/styles/color_manager.dart';
import 'package:mandob/widgets/default_text_field.dart';
import 'package:mandob/widgets/defualtButton.dart';

class CustomerScreen extends StatelessWidget {

  static var addressController=TextEditingController();
  static var fromController=TextEditingController();
  static var toController=TextEditingController();
  static var priceController=TextEditingController();
  static var weightController=TextEditingController();

  const CustomerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: ColorManager.lightColor,
      appBar: AppBar(
        backgroundColor: ColorManager.lightColor,
        elevation: 0.0,
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarIconBrightness: Brightness.dark,
          statusBarColor: ColorManager.lightColor,
        ),
        title:Text(
          'اضافه توصيله',
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
          padding: EdgeInsets.symmetric(horizontal: MediaQuery.sizeOf(context).height*.02),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [


              Align(
                alignment: Alignment.center,
                child: Container(
                  padding: const EdgeInsets.all(2),
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(7),
                    border: Border.all(
                      color: Colors.black
                    )
                  ),
                  child: Image(
                    fit: BoxFit.cover,
                    image:const AssetImage('assets/images/location.jpg'),
                    height: MediaQuery.of(context).size.height*.3,
                    width: MediaQuery.of(context).size.height*.35,

                  ),
                ),
              ),

              SizedBox(height: MediaQuery.sizeOf(context).height*.015,),

              // العنوان
              Text(
                'العنوان',
                style: GoogleFonts.cairo(
                  fontSize: 18.0,
                  fontWeight: FontWeight.w700,
                  color: ColorManager.textColor,
                ),
                textAlign: TextAlign.center,
              ),
              DefaultTextField(
                  hintText: 'العنوان',
                  isPass: false,
                  prefixIcon: Icons.location_on,
                  controller: addressController,
                  textInputType: TextInputType.text
              ),

              SizedBox(height: MediaQuery.sizeOf(context).height*.015,),



              // من

              Text(
                'من',
                style: GoogleFonts.cairo(
                  fontSize: 18.0,
                  fontWeight: FontWeight.w700,
                  color: ColorManager.textColor,
                ),
                textAlign: TextAlign.center,
              ),
              DefaultTextField(
                  hintText: 'من',
                  isPass: false,
                  prefixIcon: Icons.location_city,
                  controller: fromController,
                  textInputType: TextInputType.text
              ),
              SizedBox(height: MediaQuery.sizeOf(context).height*.015,),

              // الي

              Text(
                'الي',
                style: GoogleFonts.cairo(
                  fontSize: 18.0,
                  fontWeight: FontWeight.w700,
                  color: ColorManager.textColor,
                ),
                textAlign: TextAlign.center,
              ),
              DefaultTextField(
                  hintText: 'الي',
                  isPass: false,
                  prefixIcon: Icons.location_city,
                  controller: toController,
                  textInputType: TextInputType.text
              ),
              SizedBox(height: MediaQuery.sizeOf(context).height*.015,),

              // السعر

              Text(
                'السعر',
                style: GoogleFonts.cairo(
                  fontSize: 18.0,
                  fontWeight: FontWeight.w700,
                  color: ColorManager.textColor,
                ),
                textAlign: TextAlign.center,
              ),
              DefaultTextField(
                  hintText: 'السعر',
                  prefixIcon: Icons.price_change,
                  isPass: false,
                  controller: priceController,
                  textInputType: TextInputType.text
              ),
              SizedBox(height: MediaQuery.sizeOf(context).height*.015,),

              // الوزن

              Text(
                'الوزن',
                style: GoogleFonts.cairo(
                  fontSize: 18.0,
                  fontWeight: FontWeight.w700,
                  color: ColorManager.textColor,
                ),
                textAlign: TextAlign.center,
              ),
              DefaultTextField(
                  hintText: 'الوزن',
                  isPass: false,
                  prefixIcon: Icons.menu,
                  controller: weightController,
                  textInputType: TextInputType.text
              ),
              SizedBox(height: MediaQuery.sizeOf(context).height*.05,),

            // showModalBottomSheet(context: context, builder: (BuildContext context){
            //   return Container(
            //     color: Colors.red,
            //     height: 200,
            //   );
            // });

              DefaultButton(
                onPressed: (){

                },
                buttonText: 'اضافه',
                color: ColorManager.primaryColor,
                color2: Colors.red,
              ),

              SizedBox(height: MediaQuery.sizeOf(context).height*.015,),

            ],
          ),
        ),
      ),
    );
  }
}

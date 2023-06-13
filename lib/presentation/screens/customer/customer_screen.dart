
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mandob/business_logic/mandoob_cubit/mandoob_cubit.dart';
import 'package:mandob/business_logic/mandoob_cubit/mandoob_states.dart';
import 'package:mandob/styles/color_manager.dart';
import 'package:mandob/widgets/default_text_field.dart';
import 'package:mandob/widgets/defualtButton.dart';

class CustomerScreen extends StatefulWidget {

  static var addressController=TextEditingController();
  static var fromController=TextEditingController();
  static var toController=TextEditingController();
  static var priceController=TextEditingController();
  static var weightController=TextEditingController();
  static var notesController=TextEditingController();
  static var formKey=GlobalKey<FormState>();
  static String bottomValue='';

  const CustomerScreen({super.key});

  @override
  State<CustomerScreen> createState() => _CustomerScreenState();
}

class _CustomerScreenState extends State<CustomerScreen> {
  @override
  Widget build(BuildContext context) {
    return  BlocConsumer<MandoobCubit,MandoobStates>(
        listener: (context,state){

        },
      builder: (context,state){
          var cubit=MandoobCubit.get(context);
          return Scaffold(
            backgroundColor: ColorManager.lightColor,
            appBar: AppBar(
              titleSpacing: 0.0,
              iconTheme: IconThemeData(
                color: ColorManager.textColor
              ),
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
            drawer: Drawer(),
            body: SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: MediaQuery.sizeOf(context).height*.02),
                child: Form(
                  key: CustomerScreen.formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [


                      Align(
                        alignment: Alignment.center,
                        child: GestureDetector(
                          onTap: (){
                            cubit.getProductImage();
                          },
                          child: Container(
                            padding: const EdgeInsets.all(2),
                            clipBehavior: Clip.antiAliasWithSaveLayer,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(7),
                                border: Border.all(
                                    color: Colors.black
                                )
                            ),
                            child: cubit.productImage==null? Image(
                              fit: BoxFit.cover,
                              image:const AssetImage('assets/images/location.jpg'),
                              height: MediaQuery.of(context).size.height*.3,
                              width: MediaQuery.of(context).size.height*.35,

                            ):Image(image: FileImage(cubit.productImage!)),
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
                          controller: CustomerScreen.addressController,
                          textInputType: TextInputType.text
                      ),

                      SizedBox(height: MediaQuery.sizeOf(context).height*.015,),

                      Text(
                        'المحافظه',
                        style: GoogleFonts.cairo(
                          fontSize: 18.0,
                          fontWeight: FontWeight.w700,
                          color: ColorManager.textColor,
                        ),
                        textAlign: TextAlign.center,
                      ),

                      GestureDetector(
                        onTap: (){
                          showModalBottomSheet(context: context, builder: (BuildContext context){
                            return Container(
                              color: ColorManager.lightColor,
                              height: MediaQuery.sizeOf(context).height*.5,
                              child: ListView.separated(
                                  itemBuilder: (context,index){
                                    return GestureDetector(
                                      onTap: (){
                                        setState(() {
                                          CustomerScreen.bottomValue=MandoobCubit.get(context).governmentName[index];
                                        });
                                        Navigator.pop(context);
                                      },
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 5),
                                        child: Text(
                                            MandoobCubit.get(context).governmentName[index],
                                            style: GoogleFonts.cairo(
                                              fontSize: 15.0,
                                              fontWeight: FontWeight.w700,
                                              color: ColorManager.textColor,
                                            )),
                                      ),
                                    );
                                  },
                                  separatorBuilder: (context,index){
                                    return const Divider(color: Colors.black,);
                                  },
                                  itemCount: MandoobCubit.get(context).governmentName.length
                              ),
                            );
                          }).then((value) {
                          });

                        },
                        child: Container(
                          padding: EdgeInsets.all(MediaQuery.sizeOf(context).height*.02),
                          alignment: AlignmentDirectional.centerStart,
                          height: MediaQuery.sizeOf(context).height*.07,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: Colors.white,
                          ),
                          child:Row(
                            children: [
                              const Icon(
                                Icons.house,
                                color: Colors.grey,
                              ),
                              SizedBox(width: MediaQuery.sizeOf(context).height*.01,),

                              CustomerScreen.bottomValue==''? Text(
                                'المحافظه',
                                style: GoogleFonts.almarai(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.w300,
                                    color: Colors.grey
                                ),
                              ):Text(
                                CustomerScreen.bottomValue,
                                style: GoogleFonts.almarai(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.w300,
                                    color: Colors.grey
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

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
                          controller: CustomerScreen.fromController,
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
                          controller: CustomerScreen.toController,
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
                          controller: CustomerScreen.priceController,
                          textInputType: TextInputType.number,

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
                          controller: CustomerScreen.weightController,
                          textInputType: TextInputType.text
                      ),
                      SizedBox(height: MediaQuery.sizeOf(context).height*.015,),

                      // الملاحظات

                      Text(
                        'الملاحظات',
                        style: GoogleFonts.cairo(
                          fontSize: 18.0,
                          fontWeight: FontWeight.w700,
                          color: ColorManager.textColor,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      DefaultTextField(
                          hintText: 'الملاحظات',
                          isPass: false,
                          prefixIcon: Icons.note_alt_rounded,
                          controller: CustomerScreen.notesController,
                          textInputType: TextInputType.text
                      ),
                      SizedBox(height: MediaQuery.sizeOf(context).height*.05,),



                      state is UploadProductImageLoadingState?
                      const Center(child: CircularProgressIndicator(),):
                      DefaultButton(
                        onPressed: (){
                          if(CustomerScreen.formKey.currentState!.validate()){
                             cubit.uploadProductImage(
                                 productGovernment: CustomerScreen.bottomValue,
                                 productAddress:  CustomerScreen.addressController.text,
                                 productPrice: CustomerScreen.priceController.text,
                                 productWeight: CustomerScreen.weightController.text,
                                 productNotes: CustomerScreen.notesController.text,
                                 productFrom: CustomerScreen.fromController.text,
                                 productTo: CustomerScreen.toController.text
                             ).then((value) {
                               CustomerScreen.addressController.clear();
                               CustomerScreen.priceController.clear();
                               CustomerScreen.weightController.clear();
                               CustomerScreen.notesController.clear();
                               CustomerScreen.fromController.clear();
                               CustomerScreen.toController.clear();
                             });
                          }
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
            ),
          );
      },
    );
  }
}

import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mandob/business_logic/localization_cubit/app_localization.dart';
import 'package:mandob/business_logic/mandoob_cubit/mandoob_cubit.dart';
import 'package:mandob/business_logic/mandoob_cubit/mandoob_states.dart';
import 'package:mandob/presentation/screens/customer/customer_history/customer_history.dart';
import 'package:mandob/presentation/screens/customer/profile_screen/profile_screen.dart';
import 'package:mandob/presentation/screens/start_screen/start_screen.dart';
import 'package:mandob/styles/color_manager.dart';
import 'package:mandob/widgets/default_text_field.dart';
import 'package:mandob/widgets/defualtButton.dart';
import 'package:url_launcher/url_launcher.dart';

class CustomerScreen extends StatefulWidget {
  static var addressController = TextEditingController();
  static var fromController = TextEditingController();
  static var toController = TextEditingController();
  static var priceController = TextEditingController();
  static var weightController = TextEditingController();
  static var notesController = TextEditingController();
  static var formKey = GlobalKey<FormState>();
  static String bottomValue = '';

  const CustomerScreen({super.key});

  @override
  State<CustomerScreen> createState() => _CustomerScreenState();
}

class _CustomerScreenState extends State<CustomerScreen> {
  @override
  Widget build(BuildContext context) {
    final Uri iosWhatsapp = Uri.parse('whatsapp://wa.me/+96872261622');
    final Uri androidWhatsapp = Uri.parse('whatsapp://send?phone=+96872261622');
    return BlocConsumer<MandoobCubit, MandoobStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = MandoobCubit.get(context);
        return cubit.user != null
            ? Scaffold(
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
                  title: Text(
                    AppLocalizations.of(context)!
                        .translate("addOrder")
                        .toString(),
                    style: GoogleFonts.cairo(
                      fontSize: 20.0,
                      fontWeight: FontWeight.w700,
                      color: ColorManager.textColor,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                drawer: Drawer(
                  child: Container(
                    color: ColorManager.lightColor,
                    child: Column(
                      children: [
                        SizedBox(
                          height: MediaQuery.sizeOf(context).height * .01,
                        ),
                        Container(
                          height: MediaQuery.sizeOf(context).height * .32,
                          width: double.infinity,
                          color: ColorManager.lightColor2,
                          child: Column(
                            children: [
                              SizedBox(
                                height: MediaQuery.sizeOf(context).height * .06,
                              ),
                              CircleAvatar(
                                radius: 67,
                                backgroundColor: ColorManager.lightColor2,
                                child: CircleAvatar(
                                  backgroundImage:
                                      NetworkImage((cubit.user!.pic!)),
                                  radius: 65,
                                ),
                              ),
                              SizedBox(
                                height: MediaQuery.sizeOf(context).height * .01,
                              ),
                              Text(cubit.user!.name!,
                                  style: GoogleFonts.cairo(
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.w700,
                                    color: ColorManager.textColor,
                                  )),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),

                        // حسابي

                        GestureDetector(
                          onTap: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (_) {
                              return const ProfileScreen();
                            }));
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 15, vertical: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                const Icon(Icons.person_2_outlined),
                                const SizedBox(
                                  width: 10,
                                ),
                                Text(
                                    AppLocalizations.of(context)!
                                        .translate("myProfile")
                                        .toString(),
                                    style: GoogleFonts.cairo(
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.w700,
                                      color: ColorManager.textColor,
                                    )),
                              ],
                            ),
                          ),
                        ),

                        // مرجعي
                        GestureDetector(
                          onTap: () {
                            cubit.getCustomerHistory();
                            Navigator.push(context,
                                MaterialPageRoute(builder: (_) {
                              return const CustomerHistory();
                            }));
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 15, vertical: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                const Icon(Icons.history),
                                const SizedBox(
                                  width: 10,
                                ),
                                Text(
                                    AppLocalizations.of(context)!
                                        .translate("history")
                                        .toString(),
                                    style: GoogleFonts.cairo(
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.w700,
                                      color: ColorManager.textColor,
                                    )),
                              ],
                            ),
                          ),
                        ),
                        //الابلاغ عن مشكلة
                        GestureDetector(
                          onTap: () {
                            cubit.getCustomerHistory();
                            Platform.isIOS
                                ? launchUrl(iosWhatsapp)
                                : launchUrl(androidWhatsapp);
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 15, vertical: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                const Icon(Icons.report_problem_outlined),
                                const SizedBox(
                                  width: 10,
                                ),
                                Text(
                                    AppLocalizations.of(context)!
                                        .translate("reportAProblem")
                                        .toString(),
                                    style: GoogleFonts.cairo(
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.w700,
                                      color: ColorManager.textColor,
                                    )),
                              ],
                            ),
                          ),
                        ),

                        // تسجيل الخروج
                        GestureDetector(
                          onTap: () {
                            FirebaseAuth.instance.signOut();
                            Navigator.of(context).pushAndRemoveUntil(
                                MaterialPageRoute(
                                    builder: (context) => const StartScreen()),
                                (Route<dynamic> route) => false);
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 15, vertical: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                const Icon(Icons.logout),
                                const SizedBox(
                                  width: 10,
                                ),
                                Text(
                                    AppLocalizations.of(context)!
                                        .translate("logOut")
                                        .toString(),
                                    style: GoogleFonts.cairo(
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.w700,
                                      color: ColorManager.textColor,
                                    )),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                body: SingleChildScrollView(
                  child: Container(
                    padding: EdgeInsets.symmetric(
                        horizontal: MediaQuery.sizeOf(context).height * .02),
                    child: Form(
                      key: CustomerScreen.formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Align(
                            alignment: Alignment.center,
                            child: GestureDetector(
                              onTap: () {
                                cubit.getProductImage();
                              },
                              child: Container(
                                padding: const EdgeInsets.all(2),
                                clipBehavior: Clip.antiAliasWithSaveLayer,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(7),
                                    border: Border.all(color: Colors.black)),
                                child: cubit.productImage == null
                                    ? Image(
                                        fit: BoxFit.cover,
                                        image: const AssetImage(
                                            'assets/images/click.jpg'),
                                        height:
                                            MediaQuery.of(context).size.height *
                                                .3,
                                        width:
                                            MediaQuery.of(context).size.height *
                                                .35,
                                      )
                                    : Image(
                                        image: FileImage(cubit.productImage!)),
                              ),
                            ),
                          ),

                          SizedBox(
                            height: MediaQuery.sizeOf(context).height * .015,
                          ),

                          // العنوان
                          Text(
                            AppLocalizations.of(context)!
                                .translate("address")
                                .toString(),
                            style: GoogleFonts.cairo(
                              fontSize: 18.0,
                              fontWeight: FontWeight.w700,
                              color: ColorManager.textColor,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          DefaultTextField(
                              hintText: AppLocalizations.of(context)!
                                  .translate("address")
                                  .toString(),
                              isPass: false,
                              prefixIcon: Icons.location_on,
                              controller: CustomerScreen.addressController,
                              textInputType: TextInputType.text),

                          SizedBox(
                            height: MediaQuery.sizeOf(context).height * .015,
                          ),

                          Text(
                            AppLocalizations.of(context)!
                                .translate("government")
                                .toString(),
                            style: GoogleFonts.cairo(
                              fontSize: 18.0,
                              fontWeight: FontWeight.w700,
                              color: ColorManager.textColor,
                            ),
                            textAlign: TextAlign.center,
                          ),

                          GestureDetector(
                            onTap: () {
                              showModalBottomSheet(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return Container(
                                      color: ColorManager.lightColor,
                                      height:
                                          MediaQuery.sizeOf(context).height *
                                              .5,
                                      child: ListView.separated(
                                          itemBuilder: (context, index) {
                                            return GestureDetector(
                                              onTap: () {
                                                setState(() {
                                                  CustomerScreen.bottomValue =
                                                      MandoobCubit.get(context)
                                                              .governmentName[
                                                          index];
                                                });
                                                Navigator.pop(context);
                                              },
                                              child: Container(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 10,
                                                        vertical: 5),
                                                child: Text(
                                                    MandoobCubit.get(context)
                                                        .governmentName[index],
                                                    style: GoogleFonts.cairo(
                                                      fontSize: 15.0,
                                                      fontWeight:
                                                          FontWeight.w700,
                                                      color: ColorManager
                                                          .textColor,
                                                    )),
                                              ),
                                            );
                                          },
                                          separatorBuilder: (context, index) {
                                            return const Divider(
                                              color: Colors.black,
                                            );
                                          },
                                          itemCount: MandoobCubit.get(context)
                                              .governmentName
                                              .length),
                                    );
                                  }).then((value) {});
                            },
                            child: Container(
                              padding: EdgeInsets.all(
                                  MediaQuery.sizeOf(context).height * .02),
                              alignment: AlignmentDirectional.centerStart,
                              height: MediaQuery.sizeOf(context).height * .07,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: Colors.white,
                              ),
                              child: Row(
                                children: [
                                  const Icon(
                                    Icons.house,
                                    color: Colors.grey,
                                  ),
                                  SizedBox(
                                    width:
                                        MediaQuery.sizeOf(context).height * .01,
                                  ),
                                  CustomerScreen.bottomValue == ''
                                      ? Text(
                                          AppLocalizations.of(context)!
                                              .translate("government")
                                              .toString(),
                                          style: GoogleFonts.almarai(
                                              fontSize: 16.0,
                                              fontWeight: FontWeight.w300,
                                              color: Colors.grey),
                                        )
                                      : Text(
                                          CustomerScreen.bottomValue,
                                          style: GoogleFonts.almarai(
                                              fontSize: 16.0,
                                              fontWeight: FontWeight.w300,
                                              color: Colors.grey),
                                        ),
                                ],
                              ),
                            ),
                          ),

                          // من

                          Text(
                            AppLocalizations.of(context)!
                                .translate("from")
                                .toString(),
                            style: GoogleFonts.cairo(
                              fontSize: 18.0,
                              fontWeight: FontWeight.w700,
                              color: ColorManager.textColor,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          DefaultTextField(
                              hintText: AppLocalizations.of(context)!
                                  .translate("from")
                                  .toString(),
                              isPass: false,
                              prefixIcon: Icons.location_city,
                              controller: CustomerScreen.fromController,
                              textInputType: TextInputType.text),
                          SizedBox(
                            height: MediaQuery.sizeOf(context).height * .015,
                          ),

                          // الي

                          Text(
                            AppLocalizations.of(context)!
                                .translate("to")
                                .toString(),
                            style: GoogleFonts.cairo(
                              fontSize: 18.0,
                              fontWeight: FontWeight.w700,
                              color: ColorManager.textColor,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          DefaultTextField(
                              hintText: AppLocalizations.of(context)!
                                  .translate("to")
                                  .toString(),
                              isPass: false,
                              prefixIcon: Icons.location_city,
                              controller: CustomerScreen.toController,
                              textInputType: TextInputType.text),
                          SizedBox(
                            height: MediaQuery.sizeOf(context).height * .015,
                          ),

                          // السعر

                          Text(
                            AppLocalizations.of(context)!
                                .translate("price")
                                .toString(),
                            style: GoogleFonts.cairo(
                              fontSize: 18.0,
                              fontWeight: FontWeight.w700,
                              color: ColorManager.textColor,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          DefaultTextField(
                            hintText: AppLocalizations.of(context)!
                                .translate("price")
                                .toString(),
                            prefixIcon: Icons.price_change,
                            isPass: false,
                            controller: CustomerScreen.priceController,
                            textInputType: TextInputType.number,
                          ),
                          SizedBox(
                            height: MediaQuery.sizeOf(context).height * .015,
                          ),

                          // الوزن

                          Text(
                            AppLocalizations.of(context)!
                                .translate("weight")
                                .toString(),
                            style: GoogleFonts.cairo(
                              fontSize: 18.0,
                              fontWeight: FontWeight.w700,
                              color: ColorManager.textColor,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          DefaultTextField(
                              hintText: AppLocalizations.of(context)!
                                  .translate("weight")
                                  .toString(),
                              isPass: false,
                              prefixIcon: Icons.menu,
                              controller: CustomerScreen.weightController,
                              textInputType: TextInputType.text),
                          SizedBox(
                            height: MediaQuery.sizeOf(context).height * .015,
                          ),

                          // الملاحظات

                          Text(
                            AppLocalizations.of(context)!
                                .translate("notes")
                                .toString(),
                            style: GoogleFonts.cairo(
                              fontSize: 18.0,
                              fontWeight: FontWeight.w700,
                              color: ColorManager.textColor,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          DefaultTextField(
                            hintText: AppLocalizations.of(context)!
                                .translate("notes")
                                .toString(),
                            controller: CustomerScreen.notesController,
                            textInputType: TextInputType.text,
                            lines: 4,
                          ),
                          SizedBox(
                            height: MediaQuery.sizeOf(context).height * .05,
                          ),

                          state is UploadProductImageLoadingState
                              ? const Center(
                                  child: CircularProgressIndicator(),
                                )
                              : DefaultButton(
                                  onPressed:
                                      // CashHelper.getData(
                                      //                   key: "isGuest") ==
                                      //               true
                                      //           ?
                                      () {
                                    if (CustomerScreen.formKey.currentState!
                                        .validate()) {
                                      cubit
                                          .uploadProductImage(
                                        productGovernment:
                                            CustomerScreen.bottomValue,
                                        productAddress: CustomerScreen
                                            .addressController.text,
                                        productPrice:
                                            CustomerScreen.priceController.text,
                                              productWeight: CustomerScreen
                                            .weightController.text,
                                        productNotes:
                                            CustomerScreen.notesController.text,
                                        productFrom:
                                            CustomerScreen.fromController.text,
                                        productTo:
                                            CustomerScreen.toController.text,
                                        userUid: cubit.user!.uId,
                                        userPhone: cubit.user!.phone,
                                        userName: cubit.user!.name,
                                        userImage: cubit.user!.pic,
                                        userEmail: cubit.user!.email,
                                      )
                                          .then((value) {
                                              CustomerScreen.addressController
                                                  .clear();
                                              CustomerScreen.priceController
                                                  .clear();
                                              CustomerScreen.weightController
                                                  .clear();
                                        CustomerScreen.notesController.clear();
                                        CustomerScreen.fromController.clear();
                                        CustomerScreen.toController.clear();
                                        cubit.productImage = null;
                                      });
                                    }
                                  }
                                  // : () {
                                  //     showDialog<String>(
                                  //       context: context,
                                  //       builder: (BuildContext context) =>
                                  //           AlertDialog(
                                  //         title: Padding(
                                  //             padding: const EdgeInsets.all(
                                  //                 12.0),
                                  //             child: Image(
                                  //               height:
                                  //                   MediaQuery.of(context)
                                  //                           .size
                                  //                           .height *
                                  //                       .07,
                                  //               width:
                                  //                   MediaQuery.of(context)
                                  //                           .size
                                  //                           .height *
                                  //                       .04,
                                  //               color: ColorManager
                                  //                   .primaryColor,
                                  //               image: const AssetImage(
                                  //                   "assets/images/warning.png"),
                                  //             )),
                                  //         content: Text(
                                  //           AppLocalizations.of(context)!
                                  //               .translate("warn")
                                  //               .toString(),
                                  //           style: GoogleFonts.almarai(
                                  //               color:
                                  //                   ColorManager.textColor,
                                  //               fontSize: 16),
                                  //           textAlign: TextAlign.center,
                                  //         ),
                                  //         actions: [
                                  //           Center(
                                  //             child: ElevatedButton(
                                  //                 onPressed: () {
                                  //                   // MandoobCubit.get(
                                  //                   //         context)
                                  //                   //     .getUserDetails();
                                  //                   Navigator.of(context).push(
                                  //                       MaterialPageRoute(
                                  //                           builder: (_) =>
                                  //                               const LoginScreen()));
                                  //                 },
                                  //                 style: ElevatedButton
                                  //                     .styleFrom(
                                  //                   primary: Colors
                                  //                       .blue.shade700,
                                  //                 ),
                                  //                 child: Text(
                                  //                   AppLocalizations.of(
                                  //                           context)!
                                  //                       .translate("login")
                                  //                       .toString(),
                                  //                 )),
                                  //           )
                                  //         ],
                                  //       ),
                                  //     ).then((value) {
                                  //       Navigator.of(context).pop();
                                  //     });
                                  //   },
                                  ,
                                  buttonText: AppLocalizations.of(context)!
                                      .translate("addOrder")
                                      .toString(),
                                  color: ColorManager.primaryColor,
                                  color2: Colors.red,
                                ),

                          SizedBox(
                            height: MediaQuery.sizeOf(context).height * .015,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              )
            : const Scaffold(
                body: SafeArea(
                    child: Center(
                  child: CircularProgressIndicator(),
                )),
              );
      },
    );
  }
}

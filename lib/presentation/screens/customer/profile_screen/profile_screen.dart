import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mandob/business_logic/localization_cubit/app_localization.dart';
import 'package:mandob/business_logic/mandoob_cubit/mandoob_cubit.dart';
import 'package:mandob/business_logic/mandoob_cubit/mandoob_states.dart';
import 'package:mandob/presentation/screens/customer/profile_screen/open_car_image.dart';
import 'package:mandob/presentation/screens/customer/profile_screen/open_id_image.dart';
import 'package:mandob/presentation/screens/customer/profile_screen/open_profile_image.dart';
import 'package:mandob/styles/color_manager.dart';
import 'package:mandob/uitiles/local/cash_helper.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MandoobCubit, MandoobStates>(
      listener: (context,state){
        if (state is PickProfileImageSuccessState) {
          Navigator.push(context, MaterialPageRoute(builder: (_) {
            return const OpenProfileImage();
          }));
        }
        if (state is PickUserIdImageSuccessState) {
          Navigator.push(context, MaterialPageRoute(builder: (_) {
            return const OpenIdImage();
          }));
        }
        if (state is PickCarImageSuccessState) {
          Navigator.push(context, MaterialPageRoute(builder: (_) {
            return const OpenCarImage();
          }));
        }
      },
      builder: (context,state){
        var cubit=MandoobCubit.get(context);
        return Directionality(
          textDirection: TextDirection.rtl,
          child: Scaffold(

            // title
            appBar: AppBar(
              backgroundColor: Colors.white,
              elevation: 0.0,
              title: Text(
                AppLocalizations.of(context)!.translate("myProfile").toString(),
                style: GoogleFonts.almarai(
                    color: ColorManager.textColor,
                    fontWeight: FontWeight.w500,
                    fontSize: MediaQuery.of(context).size.height * .025),
              ),
              titleSpacing: 0,
              leading: IconButton(
                icon: const Icon(
                  Icons.arrow_back_ios,
                  color: ColorManager.textColor,
                ),
                onPressed: (){
                  Navigator.pop(context);
                },
              ),
              systemOverlayStyle: const SystemUiOverlayStyle(
                  statusBarIconBrightness: Brightness.dark,
                  statusBarColor: Colors.white
              ),
            ),

            body: SafeArea(
              child: Container(
                color: Colors.white,
                child: Stack(
                  children: [

                    Container(
                      padding: EdgeInsets.all(MediaQuery.of(context).size.height*.02),
                      margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*.15),
                      height: double.infinity,
                      width: double.infinity,
                      decoration: BoxDecoration(
                          color: ColorManager.lightColor,
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(
                                MediaQuery.of(context).size.height * .03),
                            topLeft: Radius.circular(
                                MediaQuery.of(context).size.height * .03),
                          )),
                      child: SingleChildScrollView(
                        child: Column(
                          // crossAxisAlignment: CashHelper.getData(key: CashHelper.languageKey).toString() == 'en'? CrossAxisAlignment.start:CrossAxisAlignment.end,
                          children: [
                            SizedBox(
                              height: MediaQuery.of(context).size.height * .06,
                            ),

                            // personal information
                            Row(
                              mainAxisAlignment: CashHelper.getData(
                                              key: CashHelper.languageKey)
                                          .toString() ==
                                      'en'
                                  ? MainAxisAlignment.end
                                  : MainAxisAlignment.start,
                              children: [
                                Text(
                                  AppLocalizations.of(context)!
                                      .translate("personalDetails")
                                      .toString(),
                                  style: GoogleFonts.almarai(
                                      color: ColorManager.textColor,
                                      fontWeight: FontWeight.w500,
                                      fontSize:
                                          MediaQuery.of(context).size.height *
                                              .025),
                                ),
                              ],
                            ),

                            SizedBox(
                              height: MediaQuery.of(context).size.height * .01,
                            ),

                            const Divider(
                              color: ColorManager.textColor,
                            ),

                            SizedBox(
                              height: MediaQuery.of(context).size.height * .02,
                            ),

                            // name
                            Row(
                              mainAxisAlignment: CashHelper.getData(
                                              key: CashHelper.languageKey)
                                          .toString() ==
                                      'en'
                                  ? MainAxisAlignment.end
                                  : MainAxisAlignment.start,
                              children: [
                                Text(
                                  '${AppLocalizations.of(context)!.translate("userName").toString()}: ${cubit.user!.name}',
                                  style: GoogleFonts.almarai(
                                      color: ColorManager.textColor,
                                      fontWeight: FontWeight.w500,
                                      fontSize:
                                          MediaQuery.of(context).size.height *
                                              .022),
                                ),
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.height * .01,
                                ),
                              ],
                            ),

                            SizedBox(
                              height: MediaQuery.of(context).size.height * .03,
                            ),

                            // email
                            Row(
                              mainAxisAlignment: CashHelper.getData(
                                              key: CashHelper.languageKey)
                                          .toString() ==
                                      'en'
                                  ? MainAxisAlignment.end
                                  : MainAxisAlignment.start,
                              children: [
                                Text(
                                  '${AppLocalizations.of(context)!.translate("email").toString()}: ${cubit.user!.email}',
                                  style: GoogleFonts.almarai(
                                      color: ColorManager.textColor,
                                      fontWeight: FontWeight.w500,
                                      fontSize:
                                          MediaQuery.of(context).size.height *
                                              .022),
                                ),
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.height * .01,
                                ),
                              ],
                            ),

                            SizedBox(
                              height: MediaQuery.of(context).size.height * .03,
                            ),

                            // phone
                            Row(
                              mainAxisAlignment: CashHelper.getData(
                                              key: CashHelper.languageKey)
                                          .toString() ==
                                      'en'
                                  ? MainAxisAlignment.end
                                  : MainAxisAlignment.start,
                              children: [
                                Text(
                                  '${AppLocalizations.of(context)!.translate("phoneNumber").toString()}: ${cubit.user!.phone}',
                                  style: GoogleFonts.almarai(
                                      color: ColorManager.textColor,
                                      fontWeight: FontWeight.w500,
                                      fontSize:
                                          MediaQuery.of(context).size.height *
                                              .022),
                                ),
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.height * .01,
                                ),
                              ],
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * .03,
                            ),

                            CashHelper.getData(key: "isCustomer") == false
                                ? Row(
                                    mainAxisAlignment: CashHelper.getData(
                                                    key: CashHelper.languageKey)
                                                .toString() ==
                                            'en'
                                        ? MainAxisAlignment.end
                                        : MainAxisAlignment.start,
                                    children: [
                                      Text(
                                        AppLocalizations.of(context)!
                                            .translate("yourId")
                                            .toString(),
                                        style: GoogleFonts.almarai(
                                            color: ColorManager.textColor,
                                            fontWeight: FontWeight.w500,
                                            fontSize: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                .022),
                                      ),
                                    ],
                                  )
                                : const SizedBox(),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * .01,
                            ),
                            CashHelper.getData(key: "isCustomer") == false
                                ? Stack(
                                    children: [
                                      Container(
                                        width: double.infinity,
                                        height:
                                            MediaQuery.sizeOf(context).height *
                                                .3,
                                        color: Colors.white,
                                        child: Image(
                                            image: NetworkImage(
                                                cubit.user!.personalIdPic!)),
                                      ),
                                Positioned(
                                  right:
                                      MediaQuery.of(context).size.height * .01,
                                  bottom:
                                      MediaQuery.of(context).size.height * .01,
                                  child: CircleAvatar(
                                    backgroundColor: Colors.black,
                                    child: IconButton(
                                              onPressed: () {
                                                cubit.getIdImage();
                                              },
                                              icon: const Icon(
                                                Icons.camera_alt,
                                                color: Colors.white,
                                              )),
                                        ),
                                      ),
                                    ],
                                  )
                                : const SizedBox(),

                            SizedBox(
                              height: MediaQuery.of(context).size.height * .03,
                            ),

                            CashHelper.getData(key: "isCustomer") == false
                                ? Row(
                                    mainAxisAlignment: CashHelper.getData(
                                                    key: CashHelper.languageKey)
                                                .toString() ==
                                            'en'
                                        ? MainAxisAlignment.end
                                        : MainAxisAlignment.start,
                                    children: [
                                      Text(
                                        AppLocalizations.of(context)!
                                            .translate("carPic")
                                            .toString(),
                                        style: GoogleFonts.almarai(
                                            color: ColorManager.textColor,
                                            fontWeight: FontWeight.w500,
                                            fontSize: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                .022),
                                      ),
                                    ],
                                  )
                                : const SizedBox(),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * .01,
                            ),
                            CashHelper.getData(key: "isCustomer") == false
                                ? Stack(
                                    children: [
                                      Container(
                                        width: double.infinity,
                                        height:
                                            MediaQuery.sizeOf(context).height *
                                                .3,
                                        color: Colors.white,
                                        child: Image(
                                            image: NetworkImage(
                                                cubit.user!.carPic!)),
                                      ),
                                Positioned(
                                  right:
                                      MediaQuery.of(context).size.height * .01,
                                  bottom:
                                      MediaQuery.of(context).size.height * .01,
                                  child: CircleAvatar(
                                    backgroundColor: Colors.black,
                                    child: IconButton(
                                              onPressed: () {
                                                cubit.getCarImage();
                                              },
                                              icon: const Icon(
                                                Icons.camera_alt,
                                                color: Colors.white,
                                              )),
                                        ),
                                      ),
                                    ],
                                  )
                                : const SizedBox(),
                          ],
                        ),
                      ),
                    ),

                    // profile image
                    Positioned(
                      top:  MediaQuery.of(context).size.height*.04,
                      left:  MediaQuery.of(context).size.height*.02,
                      child: Stack(
                        children: [
                          CircleAvatar(
                            backgroundColor: Colors.white,
                            radius:  MediaQuery.of(context).size.height*.08,
                            child: CircleAvatar(
                              radius: MediaQuery.of(context).size.height*.078,
                              backgroundImage:NetworkImage(cubit.user!.pic!),
                            ),
                          ),
                          Positioned(
                            right:  MediaQuery.of(context).size.height*.00,
                            bottom:  MediaQuery.of(context).size.height*.00,
                            child: CircleAvatar(
                              backgroundColor: Colors.white,
                              child: IconButton(
                                  onPressed: () {
                                    cubit.getProfileImage();
                                  },
                                  icon: const Icon(Icons.camera_alt)),
                            ),
                          ),
                        ],
                      ),
                    ),
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
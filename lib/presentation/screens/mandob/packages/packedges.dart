import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:mandob/business_logic/localization_cubit/app_localization.dart';
import 'package:mandob/business_logic/mandoob_cubit/mandoob_cubit.dart';
import 'package:mandob/business_logic/mandoob_cubit/mandoob_states.dart';
import 'package:mandob/presentation/screens/mandob/packages/screen_shot_screen.dart';
import 'package:mandob/styles/color_manager.dart';
import 'package:mandob/widgets/package_item.dart';

class Packages extends StatelessWidget {
  const Packages({super.key});

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context).size;
    return BlocConsumer<MandoobCubit,MandoobStates>(
        listener: (context,state){

        },
      builder: (context,state){
          var cubit=MandoobCubit.get(context);
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
              AppLocalizations.of(context)!.translate("buyPackages").toString(),
              style: GoogleFonts.cairo(
                fontSize: 20.0,
                fontWeight: FontWeight.w700,
                color: ColorManager.textColor,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 5.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Lottie.asset("assets/images/pay.json",
                      height: mediaQuery.height * .35),
                  Text(
                    AppLocalizations.of(context)!
                        .translate("choosePackage")
                        .toString(),
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
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GridView.count(
                        crossAxisCount: 2,
                        childAspectRatio: 0.8/0.7,
                        crossAxisSpacing: mediaQuery.width * .03,
                        mainAxisSpacing: mediaQuery.height * .03,
                        shrinkWrap: true,
                        children: [
                          PackageItem(
                            onPressed: () {
                            cubit.toPayPal().then((value) {
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (_) {
                                return const ScreenShotScreen(
                                  num: 10,
                                );
                              }));
                            });
                          },
                          tittle:
                              "10 ${AppLocalizations.of(context)!.translate("delivery").toString()}",
                          price:
                              "0.5 ${AppLocalizations.of(context)!.translate("dinar").toString()}",
                          backgroundColor: ColorManager.primaryColor,
                          textColor: ColorManager.lightColor2,
                        ),
                          PackageItem(
                            onPressed: () {
                            cubit.toPayPal().then((value) {
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (_) {
                                return const ScreenShotScreen(
                                  num: 20,
                                );
                              }));
                            });
                          },
                          tittle:
                              "20 ${AppLocalizations.of(context)!.translate("delivery").toString()}",
                          price:
                              "1 ${AppLocalizations.of(context)!.translate("dinar").toString()}",
                          backgroundColor: Colors.deepPurple.shade700,
                          textColor: ColorManager.lightColor2,
                        ),
                          PackageItem(
                            onPressed: () {
                            cubit.toPayPal().then((value) {
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (_) {
                                return const ScreenShotScreen(
                                  num: 30,
                                );
                              }));
                            });
                          },
                          tittle:
                              "30 ${AppLocalizations.of(context)!.translate("delivery").toString()}",
                          price:
                              "1.5 ${AppLocalizations.of(context)!.translate("dinar").toString()}",
                          backgroundColor: Colors.green.shade700,
                          textColor: ColorManager.lightColor2,
                        ),
                          PackageItem(
                            onPressed: () {
                            cubit.toPayPal().then((value) {
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (_) {
                                return const ScreenShotScreen(
                                  num: 50,
                                );
                              }));
                            });
                          },
                          tittle:
                              "50 ${AppLocalizations.of(context)!.translate("delivery").toString()}",
                          price:
                              "2.5 ${AppLocalizations.of(context)!.translate("dinar").toString()}",
                          backgroundColor: Colors.blue.shade700,
                          textColor: ColorManager.lightColor2,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: mediaQuery.height * .01,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      PackageItem(
                        onPressed: () {
                          cubit.toPayPal().then((value) {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (_) {
                              return const ScreenShotScreen(
                                num: 100,
                              );
                            }));
                          });
                        },
                        tittle:
                            "100 ${AppLocalizations.of(context)!.translate("delivery").toString()}",
                        price:
                            "5 ${AppLocalizations.of(context)!.translate("dinar").toString()}",
                        backgroundColor: Colors.orange.shade700,
                        textColor: ColorManager.lightColor2,
                      ),
                    ],
                  ),
                ],
                ),
              ),
            ),
          );
      },
    );
  }
}

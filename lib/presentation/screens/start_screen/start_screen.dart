import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mandob/business_logic/localization_cubit/app_localization.dart';
import 'package:mandob/business_logic/localization_cubit/localization_cubit.dart';
import 'package:mandob/business_logic/mandoob_cubit/mandoob_cubit.dart';
import 'package:mandob/business_logic/mandoob_cubit/mandoob_states.dart';
import 'package:mandob/presentation/screens/login_screen/login_screen.dart';
import 'package:mandob/styles/color_manager.dart';
import 'package:mandob/uitiles/local/cash_helper.dart';
import 'package:mandob/widgets/toast.dart';

class StartScreen extends StatelessWidget {
  const StartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MandoobCubit,MandoobStates>(
        builder: (context,state){
          return Scaffold(
            backgroundColor: ColorManager.lightColor,
            appBar: AppBar(
              actions: [
                GestureDetector(
                  onTap: (){
                    if(CashHelper.getData(key: CashHelper.languageKey).toString() == 'en'){
                      LocalizationCubit.get(context).changeLanguage(code: 'ar');
                    }
                    else{
                      LocalizationCubit.get(context).changeLanguage(code: 'en');
                    }
                  },
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        AppLocalizations.of(context)!
                            .translate('language')
                            .toString(),
                        style: GoogleFonts.almarai(
                            fontSize: MediaQuery.of(context).size.height * .02,
                            color: ColorManager.textColor,
                            fontWeight: FontWeight.w700),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * .005,
                      ),
                      CashHelper.getData(key: CashHelper.languageKey)
                                  .toString() ==
                              'en'
                          ? Container(
                              width: MediaQuery.of(context).size.height * .06,
                              height:
                                  MediaQuery.of(context).size.height * .0035,
                              color: Colors.black,
                            )
                          : Container(
                              width: MediaQuery.of(context).size.height*.03,
                        height: MediaQuery.of(context).size.height*.0035,
                        color: Colors.black,
                      )
                    ],
                  ),
                ),
                SizedBox(width: MediaQuery.of(context).size.height*.025,),
              ],
              elevation: 0.0,
              backgroundColor: ColorManager.lightColor,
              systemOverlayStyle: const SystemUiOverlayStyle(
                statusBarIconBrightness: Brightness.dark,
                statusBarColor: ColorManager.lightColor,
              ),

            ),
            body: Column(
              children: [
                Image(
                  image: const AssetImage('assets/images/delivery.png'),
                  height: MediaQuery.of(context).size.height * .2,
                  width: MediaQuery.of(context).size.height * .2,
                ),

                CashHelper.getData(key: CashHelper.languageKey).toString() ==
                    'en'
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Mandoob ',
                            style: GoogleFonts.almarai(
                                fontWeight: FontWeight.w700,
                                fontSize:
                                    MediaQuery.of(context).size.height * .03,
                                color: ColorManager.black),
                            textAlign: TextAlign.center,
                          ),
                          Text(
                            'مندوب ',
                            style: GoogleFonts.almarai(
                                fontWeight: FontWeight.w700,
                                fontSize:
                                    MediaQuery.of(context).size.height * .03,
                                color: ColorManager.primaryColor),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      )
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'مندوب ',
                            style: GoogleFonts.almarai(
                                fontWeight: FontWeight.w700,
                                fontSize:
                                    MediaQuery.of(context).size.height * .03,
                                color: ColorManager.primaryColor),
                            textAlign: TextAlign.center,
                          ),
                          Text(
                            'Mandoob ',
                            style: GoogleFonts.almarai(
                                fontWeight: FontWeight.w700,
                                fontSize:
                                    MediaQuery.of(context).size.height * .03,
                                color: ColorManager.black),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),


                Text('يوصلك كل شي',style: GoogleFonts.cairo(
                    fontWeight: FontWeight.w700,
                    fontSize: MediaQuery.of(context).size.height*.025,
                    color: ColorManager.black),
                  textAlign: TextAlign.center,
                ),
                const Spacer(),
                Container(
                  height: MediaQuery.of(context).size.height*.48,
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(15),
                      topLeft: Radius.circular(15),
                    ),
                  ),
                  child: Column(
                    children: [
                      SizedBox(height: MediaQuery.of(context).size.height*.06,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Checkbox(
                              value: MandoobCubit.get(context).isCheckBoxTrue,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(2.0),
                              ),
                              side: MaterialStateBorderSide.resolveWith(
                                    (states) =>  const BorderSide(
                                    width: 1.0, color: ColorManager.white
                                ),),
                              onChanged: (bool? value) {
                                MandoobCubit.get(context).changeCheckBox(value: value!);
                              }),
                          Text.rich(
                            TextSpan(
                                text: '${AppLocalizations.of(context)!.translate('privacyMessage').toString()} ',
                                style: GoogleFonts.almarai(
                                    fontSize: MediaQuery.of(context).size.height*.021,
                                    color:ColorManager.white,
                                    fontWeight: FontWeight.w600
                                ),
                                children: <TextSpan>[
                                  TextSpan(
                                    text: AppLocalizations.of(context)!.translate('privacyLink').toString(),
                                    style: GoogleFonts.almarai(
                                        fontSize: MediaQuery.of(context).size.height*.021,
                                        color:ColorManager.primaryColor,
                                        fontWeight: FontWeight.w600,
                                        decoration: TextDecoration.underline
                                    ),
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {
                                        MandoobCubit.get(context).toPrivacy();
                                      },
                                  ),
                                ]),
                          ),
                        ],
                      ),
                      SizedBox(height: MediaQuery.of(context).size.height*.02,),
                      Padding(
                        padding:EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.height*.025),
                        child: Text(AppLocalizations.of(context)!.translate('warningMessage').toString(),style: GoogleFonts.almarai(
                            fontWeight: FontWeight.w500,
                            fontSize: MediaQuery.of(context).size.height*.022,
                            color: ColorManager.lightColor2
                        ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      SizedBox(height: MediaQuery.of(context).size.height*.055,),
                      MaterialButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(7)
                        ),
                        padding: EdgeInsets.symmetric(
                          horizontal: CashHelper.getData(key: CashHelper.languageKey).toString() == 'en'?MediaQuery.of(context).size.height*.18:MediaQuery.of(context).size.height*.21,
                          vertical: MediaQuery.of(context).size.height*.018,
                        ),
                        color: ColorManager.primaryColor,
                        onPressed: (){

                          if(MandoobCubit.get(context).isCheckBoxTrue==true){
                            CashHelper.saveData(key: 'isCustomer',value: true);
                            Navigator.push(context, MaterialPageRoute(builder: (_){
                              return  const LoginScreen();
                            }));
                          }
                          else{
                            customToast(title:AppLocalizations.of(context)!.translate('privacyToast').toString(), color: Colors.red);
                          }

                        },
                        child: Text(AppLocalizations.of(context)!.translate('customer').toString(),style: GoogleFonts.almarai(
                            fontWeight: FontWeight.w600,
                              fontSize:
                                  MediaQuery.of(context).size.height * .02,
                              color: ColorManager.lightColor),),
                      ),
                      SizedBox(height:MediaQuery.of(context).size.height*.02,),
                      MaterialButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(7)
                        ),
                        padding: EdgeInsets.symmetric(
                          horizontal: MediaQuery.of(context).size.height*.2,
                          vertical: MediaQuery.of(context).size.height*.018,
                        ),

                        color: ColorManager.primaryColor,
                        onPressed: (){
                          if(MandoobCubit.get(context).isCheckBoxTrue==true){
                            CashHelper.saveData(key: 'isCustomer',value: false);
                            Navigator.push(context, MaterialPageRoute(builder: (_){
                              return const LoginScreen();
                            }));
                          }
                          else{
                            customToast(title:AppLocalizations.of(context)!.translate('privacyToast').toString(), color: Colors.red);
                          }

                        },
                        child: Text(AppLocalizations.of(context)!.translate('driver').toString(),style: GoogleFonts.almarai(
                            fontWeight: FontWeight.w600,
                              fontSize:
                                  MediaQuery.of(context).size.height * .02,
                              color: ColorManager.white),),
                      ),

                    ],
                  ),
                )
              ],
            ),
          );
        },
        listener: (context,state){

        }
    );
  }
}
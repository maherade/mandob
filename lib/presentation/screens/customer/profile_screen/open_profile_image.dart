import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mandob/business_logic/mandoob_cubit/mandoob_cubit.dart';
import 'package:mandob/business_logic/mandoob_cubit/mandoob_states.dart';
import 'package:mandob/styles/color_manager.dart';


class OpenProfileImage extends StatelessWidget {
  const OpenProfileImage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MandoobCubit,MandoobStates>(
      listener: (context,state){

         if(state is UploadProfileImageSuccessState){

           // customToast(title: AppLocalizations.of(context)!.translate('profileImageSave').toString(), color: ColorManager.primary);
           // Navigator.pop(context);

         }

      },
      builder: (context,state){
        var cubit=MandoobCubit.get(context);
          return Directionality(
            textDirection: TextDirection.rtl,
            child: Scaffold(
               backgroundColor: ColorManager.lightColor,
              // title
              appBar: AppBar(
                backgroundColor: ColorManager.lightColor,
                elevation: 0.0,
                title: Text('الصوره الشخصيه',
                  style: GoogleFonts.almarai(
                      color: ColorManager.black,
                      fontWeight: FontWeight.w500,
                      fontSize: MediaQuery.of(context).size.height*.03
                  ),),
                titleSpacing: 0,
                leading: IconButton(
                  icon: const Icon(
                    Icons.arrow_back_ios,
                    color: ColorManager.black,
                  ),
                  onPressed: (){
                    Navigator.pop(context);
                  },
                ),
                systemOverlayStyle: const SystemUiOverlayStyle(
                    statusBarIconBrightness: Brightness.dark,
                    statusBarColor: ColorManager.lightColor
                ),
              ),

              body: SafeArea(
                child: Container(
                  margin: const EdgeInsets.symmetric(
                      horizontal: 25,
                      vertical: 10
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [

                      SizedBox(height: MediaQuery.of(context).size.height*.02,),


                      // profile image
                      GestureDetector(
                        onTap: (){
                          cubit.getProfileImage();
                        },
                        child: Container(
                            height: MediaQuery.of(context).size.height*.6,
                            width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              border: Border.all(
                                color: ColorManager.textColor,
                              ),
                              image:DecorationImage(
                                image:  FileImage(cubit.profileImage!)
                              )
                          ),
                        ),
                      ),

                      const Spacer(),

                      // upload profile image
                      state is UploadProfileImageLoadingState ?
                      const Align(
                        alignment: Alignment.topRight,
                        child: CircularProgressIndicator(
                          color: ColorManager.primaryColor,
                        ),
                      ):
                      Align(
                        alignment: Alignment.topRight,
                        child: FloatingActionButton(
                          backgroundColor: ColorManager.textColor,
                          onPressed: (){
                            cubit.uploadUserImage().then((value) {
                              Navigator.pop(context);
                            });
                          },
                          child: const Icon(
                              Icons.arrow_back_ios,
                              size: 25,
                          ),
                        ),
                      ),
                      SizedBox(height: MediaQuery.of(context).size.height*.02,)

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

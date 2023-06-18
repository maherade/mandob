import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mandob/business_logic/mandoob_cubit/mandoob_cubit.dart';
import 'package:mandob/business_logic/mandoob_cubit/mandoob_states.dart';
import 'package:mandob/styles/color_manager.dart';
import 'package:mandob/widgets/defualtButton.dart';

class ScreenShotScreen extends StatelessWidget {
  final int num;
  const ScreenShotScreen({super.key,required this.num});

  @override
  Widget build(BuildContext context) {
    return  BlocConsumer<MandoobCubit,MandoobStates>(
        listener: (context,state){

        },
      builder: (context,state){
          var cubit=MandoobCubit.get(context);
          return Scaffold(
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
                'صفحه الدفع',
                style: GoogleFonts.cairo(
                  fontSize: 20.0,
                  fontWeight: FontWeight.w700,
                  color: ColorManager.textColor,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            body: Container(
              color: ColorManager.lightColor,
              child: Column(
                children: [
                  GestureDetector(
                    onTap: (){
                      cubit.getPayImage();
                    },
                    child: Container(
                      height: MediaQuery.sizeOf(context).height*.7,
                      margin: const EdgeInsets.all(10),
                      padding: const EdgeInsets.all(2),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                            color: Colors.black
                        ),
                      ),
                      child: cubit.payImage==null?
                      const Image(image: AssetImage('assets/images/money.jpg')
                      ):Image(image: FileImage(cubit.payImage!)),
                    ),
                  ),

                  const Spacer(),
                  state is UploadPayImageLoadingState?
                  const Center(
                    child: CircularProgressIndicator(),
                  ):
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: DefaultButton(
                        color: ColorManager.primaryColor,
                        color2: Colors.red,
                        buttonText: 'ارسال',
                        onPressed: (){
                          cubit.uploadPayImage(num: num).then((value) {
                            cubit.payImage=null;

                            showDialog<String>(
                              context: context,
                              builder: (BuildContext context) => AlertDialog(
                                title: Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: Image(
                                      height: MediaQuery.of(context).size.height*.07,
                                      width: MediaQuery.of(context).size.height*.04,
                                      color: ColorManager.primaryColor,
                                      image: const AssetImage('assets/images/check.png')
                                  ),
                                ),
                                content: Text('تم الارسال بنجاح سوف يتم التحقق من الصوره و الاشتراك في الباقه',style: GoogleFonts.almarai(
                                    color: ColorManager.textColor,
                                    fontSize: 16
                                ),
                                  textAlign: TextAlign.center,
                                ),

                              ),
                            ).then((value) {

                              Navigator.of(context).pop();
                            });


                          });
                        }
                    ),
                  ),
                  SizedBox(height: MediaQuery.sizeOf(context).height*.02,)
                ],
              ),
            ),
          );
      },
    );
  }
}

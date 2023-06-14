
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mandob/business_logic/mandoob_cubit/mandoob_cubit.dart';
import 'package:mandob/business_logic/mandoob_cubit/mandoob_states.dart';
import 'package:mandob/presentation/screens/customer/customer_screen/customer_screen.dart';
import 'package:mandob/presentation/screens/on_boarding/on_boarding.dart';
import 'package:mandob/styles/color_manager.dart';
import 'package:mandob/uitiles/local/cash_helper.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    //
    Future.delayed(const Duration(seconds: 3),(){

      if(CashHelper.getData(key: 'isUid')!=null&&CashHelper.getData(key: 'isCustomer')==true){
        if(MandoobCubit.get(context).user!.pic!=null){
          MandoobCubit.get(context).getUser().then((value) {
            Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
            const CustomerScreen()
            ), (Route<dynamic> route) => false);
          });
        }

      }
      else{
        Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
        const OnBoarding()
        ), (Route<dynamic> route) => false);
      }


    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MandoobCubit,MandoobStates>(
        listener: (context,state){

        },
      builder: (context,state){
          return Scaffold(
            appBar: AppBar(
              toolbarHeight: 0.0,
              elevation: 0.0,
              systemOverlayStyle: const SystemUiOverlayStyle(
                statusBarIconBrightness: Brightness.dark,
                statusBarColor: ColorManager.lightColor,
              ),
            ),
            body: Container(
              decoration: const BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.topRight,
                      colors: [
                        ColorManager.lightColor2,
                        ColorManager.lightColor,
                        ColorManager.lightColor,
                        ColorManager.lightColor2,
                      ]
                  )
              ),
              height: double.infinity,
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children:  [

                  Image(
                    fit: BoxFit.contain,
                    image: const AssetImage('assets/images/logo.jpeg'),
                    height: MediaQuery.of(context).size.height*.55,
                    width: double.infinity,
                  ),


                ],
              ),
            ),
          );
      },
    );
  }
}

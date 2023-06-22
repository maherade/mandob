import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:mandob/data/modles/onbaording_model.dart';
import 'package:mandob/presentation/screens/register_screen/register_screen.dart';
import 'package:mandob/presentation/screens/start_screen/start_screen.dart';
import 'package:mandob/styles/color_manager.dart';
import 'package:mandob/widgets/defualtButton.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnBoarding extends StatelessWidget {
  static var pageController = PageController();

  static List<OnBoardingModel> onBoardingData = [
    OnBoardingModel(
        title: 'تطبيق يكسبك فلوس وانت علي دربك',
        describtion: '''
        طريقة سهلة في استقبال الطلبات
              طلبات توصلك وين ما كنت
              تواصل مع العميل مباشرةً
        ''',
        image: 'assets/images/food.json'),
    OnBoardingModel(
        title: 'مميزات التطبيق لأصحاب المشاريع المنزلية',
        describtion: '''
        الإستلام من باب بيتك
        مندوبك متوفر علي مدار الساعة
        نضمن لك سلامة منتجاتك
        تتبع طلبك بكل سهولة
        ''',
        image: 'assets/images/onboarding3.json'),
    OnBoardingModel(
        title: '#حط_طلبك_يوصل_لك',
        describtion: ''' سجل كمندوب واكسب فلوس 
        في وقت فراغك و عيش حياتك
        ''',
        image: 'assets/images/onboarding2.json'),
  ];

  const OnBoarding({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: ColorManager.lightColor2,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                controller: pageController,
                  itemBuilder: (context,index){
                    return Container(
                      padding: EdgeInsets.symmetric(horizontal: MediaQuery.sizeOf(context).height*.03),
                      child: Column(
                        children: [

                          Align(
                            alignment: Alignment.topCenter,
                            child: Lottie.asset(onBoardingData[index].image!,
                              height: MediaQuery.of(context).size.height*.42,
                              width: MediaQuery.of(context).size.height*.45,
                            ),
                          ),

                          SizedBox(height: MediaQuery.sizeOf(context).height*.015,),

                          Text(
                            onBoardingData[index].title!,
                            style: GoogleFonts.cairo(
                              fontSize: 24.0,
                              fontWeight: FontWeight.w700,
                              color: ColorManager.darkGrey,
                            ),
                            textAlign: TextAlign.center,
                          ),

                          SizedBox(height: MediaQuery.sizeOf(context).height*.01,),

                          Text(
                            onBoardingData[index].describtion!,
                            style: GoogleFonts.cairo(
                              fontSize: 15.0,
                              fontWeight: FontWeight.w700,
                              color: ColorManager.darkGrey,
                            ),
                            textAlign: TextAlign.center,
                          ),

                          SizedBox(height: MediaQuery.sizeOf(context).height*.035,),

                          SmoothPageIndicator(
                            controller: pageController,  // PageController
                            count:  3,
                            effect: const ExpandingDotsEffect(
                                dotColor: Colors.grey,
                                dotHeight: 8,
                                activeDotColor:  ColorManager.primaryColor
                            ),   // your preferred effect

                          ),

                          SizedBox(height: MediaQuery.sizeOf(context).height*.04,),

                          DefaultButton(
                            buttonText: 'Get Started',
                          onPressed: () {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => const StartScreen()));
                          },
                          color: ColorManager.primaryColor,
                          color2: Colors.red,
                        ),

                          SizedBox(height: MediaQuery.sizeOf(context).height*.025,),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                            Text(
                              'Don\'t have an account?',
                              style: GoogleFonts.cairo(
                                fontSize: 15.0,
                                fontWeight: FontWeight.w700,
                                color: ColorManager.darkGrey,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (_) =>
                                            const RegisterScreen()));
                              },
                              child: Text(
                                ' SignUp ',
                                style: GoogleFonts.cairo(
                                  fontSize: 15.0,
                                  fontWeight: FontWeight.w700,
                                  color: ColorManager.primaryColor,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ],
                          ),


                        ],
                      ),
                    );
                  },
                  itemCount: 3,
              ),
            ),


          ],
        ),
      ),
    );
  }
}

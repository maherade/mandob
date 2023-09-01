import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:mandob/business_logic/localization_cubit/app_localization.dart';
import 'package:mandob/business_logic/mandoob_cubit/mandoob_cubit.dart';
import 'package:mandob/business_logic/mandoob_cubit/mandoob_states.dart';
import 'package:mandob/presentation/screens/admin/admin_verified.dart';
import 'package:mandob/styles/color_manager.dart';

class AdminScreen extends StatelessWidget {
  const AdminScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MandoobCubit, MandoobStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = MandoobCubit.get(context);
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
              AppLocalizations.of(context)!.translate("adminPage").toString(),
              style: GoogleFonts.cairo(
                fontSize: 20.0,
                fontWeight: FontWeight.w700,
                color: ColorManager.textColor,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          body: Column(
            children: [
              cubit.screenShotList.isEmpty
                  ? Center(
                      child: Column(
                        children: [
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.18,
                          ),
                          Lottie.asset(
                            "assets/images/empty.json",
                            fit: BoxFit.fill,
                            width: MediaQuery.of(context).size.height * 0.25,
                            height: MediaQuery.of(context).size.height * 0.25,
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.04,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                                AppLocalizations.of(context)!
                                    .translate("noOrderNeeds")
                                    .toString(),
                                style: GoogleFonts.cairo(
                                  fontSize: 15.0,
                                  fontWeight: FontWeight.w700,
                                  color: ColorManager.textColor,
                                ),
                                textAlign: TextAlign.center),
                          )
                        ],
                      ),
                    )
                  : Expanded(
                      child: ListView.separated(
                          itemBuilder: (context, index) {
                            return Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 15),
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.push(context,
                                      MaterialPageRoute(builder: (_) {
                                    return AdminVerifiedScreen(
                                      screen:
                                          '${cubit.screenShotList[index].screen}',
                                      uId: cubit.screenShotList[index].uId!,
                                      count: cubit.screenShotList[index].count!,
                                      num: cubit.screenShotList[index].num!,
                                    );
                                  }));
                                },
                                child: Material(
                                  borderRadius: BorderRadius.circular(12),
                                  color: ColorManager.lightColor2,
                                  elevation: 10,
                                  child: Container(
                                    height:
                                        MediaQuery.sizeOf(context).height * .15,
                                    decoration: BoxDecoration(
                                        color: ColorManager.lightColor2,
                                        borderRadius:
                                            BorderRadius.circular(12)),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        CircleAvatar(
                                          backgroundImage: NetworkImage(
                                              '${cubit.screenShotList[index].pic}'),
                                          radius: 35,
                                        ),
                                        const SizedBox(
                                          width: 15,
                                        ),
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                                " ${AppLocalizations.of(context)!.translate("userName").toString()} :  ${cubit.screenShotList[index].name}",
                                                style: GoogleFonts.cairo(
                                                  fontSize: 15.0,
                                                  fontWeight: FontWeight.w700,
                                                  color: ColorManager.textColor,
                                                ),
                                                textAlign: TextAlign.center),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            Text(
                                                " ${AppLocalizations.of(context)!.translate("phoneNumber").toString()} :  ${cubit.screenShotList[index].phone}",
                                                style: GoogleFonts.cairo(
                                                  fontSize: 15.0,
                                                  fontWeight: FontWeight.w700,
                                                  color: ColorManager.textColor,
                                                ),
                                                textAlign: TextAlign.center),
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                          separatorBuilder: (context, index) {
                            return const SizedBox(
                              height: 15,
                            );
                          },
                          itemCount: cubit.screenShotList.length),
                    )
            ],
          ),
        );
      },
    );
  }
}

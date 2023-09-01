import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mandob/business_logic/localization_cubit/app_localization.dart';
import 'package:mandob/business_logic/mandoob_cubit/mandoob_cubit.dart';
import 'package:mandob/business_logic/mandoob_cubit/mandoob_states.dart';
import 'package:mandob/styles/color_manager.dart';
import 'package:mandob/widgets/defualtButton.dart';

class AdminVerifiedScreen extends StatelessWidget {
  final String screen;
  final String uId;
  final int num;
  final int count;

  const AdminVerifiedScreen({
    super.key,
    required this.screen,
    required this.uId,
    required this.num,
    required this.count,
  });

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MandoobCubit, MandoobStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = MandoobCubit.get(context);
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
              AppLocalizations.of(context)!.translate("confirmPay").toString(),
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
                Container(
                    height: MediaQuery.sizeOf(context).height * .7,
                    margin: const EdgeInsets.all(10),
                    padding: const EdgeInsets.all(2),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.black),
                    ),
                    child: Image(image: NetworkImage(screen))),
                const Spacer(),
                Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: DefaultButton(
                            color: Colors.blue,
                            color2: Colors.lightBlue,
                            buttonText: AppLocalizations.of(context)!
                                .translate("confirm")
                                .toString(),
                            onPressed: () {
                              cubit
                                  .isAcceptedPay(
                                      num: num, count: count, uId: uId)
                                  .then((value) {
                                Navigator.pop(context);
                              });
                            }),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: DefaultButton(
                            color: ColorManager.primaryColor,
                            color2: Colors.red,
                            buttonText: AppLocalizations.of(context)!
                                .translate("reject")
                                .toString(),
                            onPressed: () {
                              cubit.isRefusedPay(uId: uId);
                            }),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: MediaQuery.sizeOf(context).height * .02,
                )
              ],
            ),
          ),
        );
      },
    );
  }
}

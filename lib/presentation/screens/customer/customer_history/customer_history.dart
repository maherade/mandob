import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:mandob/business_logic/localization_cubit/app_localization.dart';
import 'package:mandob/business_logic/mandoob_cubit/mandoob_cubit.dart';
import 'package:mandob/business_logic/mandoob_cubit/mandoob_states.dart';
import 'package:mandob/styles/color_manager.dart';
import 'package:mandob/uitiles/local/cash_helper.dart';
import 'package:mandob/widgets/customer_history_item.dart';

class CustomerHistory extends StatefulWidget {
  const CustomerHistory({super.key});

  @override
  State<CustomerHistory> createState() => _CustomerHistoryState();
}

class _CustomerHistoryState extends State<CustomerHistory> {
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
            leading: GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: const Icon(Icons.arrow_back_ios)),
            title: Text(
              AppLocalizations.of(context)!.translate("history").toString(),
              style: GoogleFonts.cairo(
                fontSize: 20.0,
                fontWeight: FontWeight.w700,
                color: ColorManager.textColor,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          body: cubit.customerHistory.isEmpty &&
                  CashHelper.getData(key: "isGuest")
              ? Center(
                  child: Column(
                    children: [
                      SizedBox(
                        height: MediaQuery.sizeOf(context).height * .2,
                      ),
                      Lottie.asset(
                        "assets/images/empty.json",
                        fit: BoxFit.fill,
                        width: MediaQuery.of(context).size.height * 0.25,
                        height: MediaQuery.of(context).size.height * 0.25,
                      ),
                      Text(
                          AppLocalizations.of(context)!
                              .translate("noOrders")
                              .toString(),
                          style: GoogleFonts.cairo(
                            fontSize: 15.0,
                            fontWeight: FontWeight.w700,
                            color: ColorManager.textColor,
                          ))
                    ],
                  ),
                )
              : Container(
                  padding: const EdgeInsets.all(5),
                  margin: const EdgeInsets.all(5),
                  child: Column(
                    children: [
                      Expanded(
                        child: ListView.builder(
                            itemCount: cubit.customerHistory.length,
                            itemBuilder: (context, index) {
                              return CustomerHistoryItem(
                                  cubit.customerHistory[index]);
                            }),
                      )
                    ],
                  ),
                ),
        );
      },
    );
  }
}
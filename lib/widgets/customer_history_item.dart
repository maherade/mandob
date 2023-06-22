import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:mandob/business_logic/localization_cubit/app_localization.dart';
import 'package:mandob/business_logic/mandoob_cubit/mandoob_cubit.dart';
import 'package:mandob/widgets/defualtButton.dart';
import 'package:url_launcher/url_launcher.dart';

import '../styles/color_manager.dart';

class CustomerHistoryItem extends StatefulWidget {
  var productModel;

  CustomerHistoryItem(this.productModel, {super.key});

  @override
  State<CustomerHistoryItem> createState() => _CustomerHistoryItemState();
}

class _CustomerHistoryItemState extends State<CustomerHistoryItem> {
  @override
  Widget build(BuildContext context) {
    final Uri iosWhatsapp = Uri.parse('whatsapp://wa.me/+96872261622');
    final Uri androidWhatsapp = Uri.parse('whatsapp://send?phone=+96872261622');
    return Container(
      width: double.infinity,
      height: MediaQuery.of(context).size.height * .48,
      padding: const EdgeInsets.symmetric(
        vertical: 10,
        horizontal: 10,
      ),
      margin: const EdgeInsets.symmetric(
        vertical: 10,
        horizontal: 10,
      ),
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.grey.shade500,
            blurRadius: 5.0,
          )
        ],
        borderRadius: BorderRadius.circular(5),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: SizedBox(
              width: double.infinity,
              child: Image.network(
                '${widget.productModel.productImage}',
                fit: BoxFit.fitWidth,
              ),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: MediaQuery.sizeOf(context).height*.01,),

              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                    child: Text(
                      "${AppLocalizations.of(context)!.translate("from").toString()}: ${widget.productModel.productFrom}",
                      style: GoogleFonts.cairo(
                        fontSize: 16.0,
                        fontWeight: FontWeight.w600,
                        color: ColorManager.textColor,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: MediaQuery.sizeOf(context).height*.01,),

              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                    child: Text(
                      "${AppLocalizations.of(context)!.translate("to").toString()}: ${widget.productModel.productTo}",
                      style: GoogleFonts.cairo(
                        fontSize: 16.0,
                        fontWeight: FontWeight.w600,
                        color: ColorManager.textColor,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: MediaQuery.sizeOf(context).height*.01,),

              Row(
                children: [
                  Expanded(
                    child: Text(
                      "${AppLocalizations.of(context)!.translate("weight").toString()}: ${widget.productModel.productWeight}",
                      style: GoogleFonts.cairo(
                        fontSize: 16.0,
                        fontWeight: FontWeight.w600,
                        color: ColorManager.textColor,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: MediaQuery.sizeOf(context).height*.01,),

              Row(
                children: [
                  Expanded(
                    child: Text(
                      "${AppLocalizations.of(context)!.translate("price").toString()}: ${widget.productModel.productPrice}",
                      style: GoogleFonts.cairo(
                        fontSize: 16.0,
                        fontWeight: FontWeight.w600,
                        color: ColorManager.textColor,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * .01,
              ),
              widget.productModel.isArrived == false
                  ? Row(
                      children: [
                        Expanded(
                          child: DefaultButton(
                            buttonText: AppLocalizations.of(context)!
                                .translate("orderDelivered")
                                .toString(),
                            color: Colors.green.shade700,
                            color2: Colors.green.shade700,
                            onPressed: () {
                              setState(() {
                                MandoobCubit.get(context)
                                    .updateArrivedDelivery(widget.productModel)
                                    .then((value) => showDialog<String>(
                                          context: context,
                                          builder: (BuildContext context) =>
                                              AlertDialog(
                                            title: Lottie.asset(
                                                "assets/images/check.json",
                                                height:
                                                    MediaQuery.sizeOf(context)
                                                            .height *
                                                        .25),
                                            actions: [
                                              Center(
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Text(
                                                      AppLocalizations.of(
                                                              context)!
                                                          .translate(
                                                              "successDelivered")
                                                          .toString(),
                                                      style: GoogleFonts.almarai(
                                                          fontSize: 20.0,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          color: ColorManager
                                                              .textColor),
                                                    ),
                                                    SizedBox(
                                                      height: MediaQuery.sizeOf(
                                                                  context)
                                                              .height *
                                                          .02,
                                                    ),
                                                    DefaultButton(
                                                      buttonText:
                                                          AppLocalizations.of(
                                                                  context)!
                                                              .translate("ok")
                                                              .toString(),
                                                      color: ColorManager.blue,
                                                      color2: ColorManager.blue,
                                                      textColor: ColorManager
                                                          .lightColor,
                                                      onPressed: () {
                                                        setState(() {
                                                          Navigator.of(context)
                                                              .pop();
                                                        });
                                                      },
                                                    ),
                                                  ],
                                                ),
                                              )
                                            ],
                                          ),
                                        ).then(
                                            (value) => Navigator.pop(context)));
                              });
                            },
                          ),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * .05,
                        ),
                        Expanded(
                          child: DefaultButton(
                            buttonText: AppLocalizations.of(context)!
                                .translate("problem")
                                .toString(),
                            color: ColorManager.primaryColor,
                            color2: ColorManager.primaryColor,
                            textColor: ColorManager.lightColor,
                            onPressed: () {
                              Platform.isIOS
                                  ? launchUrl(iosWhatsapp)
                                  : launchUrl(androidWhatsapp);
                            },
                          ),
                        ),
                      ],
                    )
                  : const SizedBox(),
            ],
          ),
        ],
      ),
    );
  }
}

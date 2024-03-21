import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mandob/business_logic/localization_cubit/app_localization.dart';
import 'package:mandob/business_logic/mandoob_cubit/mandoob_cubit.dart';
import 'package:mandob/data/modles/product_model.dart';
import 'package:mandob/presentation/screens/customer/customer_details/customer_details.dart';
import 'package:mandob/presentation/screens/login_screen/login_screen.dart';
import 'package:mandob/presentation/screens/mandob/mandob.dart';
import 'package:mandob/presentation/screens/mandob/order_details_screen/order_details.dart';
import 'package:mandob/uitiles/local/cash_helper.dart';
import 'package:mandob/widgets/defualtButton.dart';

import '../styles/color_manager.dart';

class OrderItem extends StatefulWidget {
  ProductModel productModel;

  OrderItem({
    required this.productModel,
  });

  @override
  State<OrderItem> createState() => _OrderItemState();
}

class _OrderItemState extends State<OrderItem> {
  @override
  Widget build(BuildContext context) {
    return widget.productModel.isAccepted == false
        ? Container(
            width: double.infinity,
            height: MediaQuery.of(context).size.height * .70,
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
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        "${AppLocalizations.of(context)!.translate("from").toString()}: ${widget.productModel.productFrom}",
                        style: GoogleFonts.cairo(
                          fontSize: 16.0,
                          fontWeight: FontWeight.w600,
                          color: ColorManager.textColor,
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * .01,
                      ),
                      Text(
                        "${AppLocalizations.of(context)!.translate("to").toString()}: ${widget.productModel.productTo}",
                        style: GoogleFonts.cairo(
                          fontSize: 16.0,
                          fontWeight: FontWeight.w600,
                          color: ColorManager.textColor,
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * .01,
                      ),
                      Text(
                        "${AppLocalizations.of(context)!.translate("weight").toString()}: ${widget.productModel.productWeight}",
                        style: GoogleFonts.cairo(
                          fontSize: 16.0,
                          fontWeight: FontWeight.w600,
                          color: ColorManager.textColor,
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * .01,
                      ),
                      Text(
                        "${AppLocalizations.of(context)!.translate("price").toString()}: ${widget.productModel.productPrice}",
                        style: GoogleFonts.cairo(
                          fontSize: 16.0,
                          fontWeight: FontWeight.w600,
                          color: ColorManager.textColor,
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * .01,
                      ),
                      Text(
                        "${AppLocalizations.of(context)!.translate("date").toString()}: ${widget.productModel.date}",
                        style: GoogleFonts.cairo(
                          fontSize: 16.0,
                          fontWeight: FontWeight.w600,
                          color: ColorManager.textColor,
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * .01,
                      ),
                      Expanded(
                        child: Row(
                          children: [
                            Expanded(
                              child: DefaultButton(
                                  buttonText: AppLocalizations.of(context)!
                                      .translate("accept")
                                      .toString(),
                                  color: ColorManager.primaryColor,
                                  color2: ColorManager.primaryColor,
                                  onPressed:
                                      // CashHelper.getData(key: "isGuest") ==
                                      //         false
                                      //     ?

                                      () {
                                    if (CashHelper.getData(key: "isGuest") !=
                                        true) {
                                      print(
                                          MandoobCubit.get(context).user!.uId);
                                      setState(() {
                                        MandoobCubit.get(context)
                                            .updateMandoobCounter();
                                        MandoobCubit.get(context)
                                            .updateProductsList(
                                                widget.productModel);
                                      });
                                      MandoobCubit.get(context).onOrderAccepted(
                                        widget.productModel.productAddress,
                                        widget.productModel.productPrice,
                                        widget.productModel.productWeight,
                                        widget.productModel.productNotes,
                                        widget.productModel.productFrom,
                                        widget.productModel.productTo,
                                        widget.productModel.productImage,
                                        widget.productModel.productGovernment,
                                        widget.productModel.userName,
                                        widget.productModel.userPhone,
                                        widget.productModel.userEmail,
                                        widget.productModel.userImage,
                                        widget.productModel.userUid,
                                      );
                                      showDialog<String>(
                                        context: context,
                                        builder: (BuildContext context) =>
                                            AlertDialog(
                                          title: Padding(
                                            padding: const EdgeInsets.all(12.0),
                                            child: Image(
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    .07,
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    .04,
                                                color:
                                                    ColorManager.primaryColor,
                                                image: const AssetImage(
                                                    'assets/images/check.png')),
                                          ),
                                          content: Text(
                                            AppLocalizations.of(context)!
                                                .translate("orderAccept")
                                                .toString(),
                                            style: GoogleFonts.almarai(
                                                color: ColorManager.textColor,
                                                fontSize: 16),
                                            textAlign: TextAlign.center,
                                          ),
                                          actions: [
                                            Center(
                                              child: ElevatedButton(
                                                  onPressed: () {
                                                    MandoobCubit.get(context)
                                                        .getUserDetails();
                                                    Navigator.of(context)
                                                        .push(MaterialPageRoute(
                                                          builder: (_) =>
                                                              CustomerDetailsScreen(
                                                            name: widget
                                                                .productModel
                                                                .userName!,
                                                            phone: widget
                                                                .productModel
                                                                .userPhone!,
                                                            pic: widget
                                                                .productModel
                                                                .userImage!,
                                                          ),
                                                        ))
                                                        .then((value) => {
                                                              MandoobCubit.get(
                                                                      context)
                                                                  .updateMandoobCounter(),
                                                              MandoobCubit.get(
                                                                      context)
                                                                  .getUser(),
                                                              Navigator.of(
                                                                      context)
                                                                  .pushReplacement(
                                                                      MaterialPageRoute(
                                                                          builder: (context) =>
                                                                              const MandobScreen())),
                                                            });
                                                  },
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                    backgroundColor: Colors.green.shade700,
                                                  ),
                                                  child: Text(
                                                    AppLocalizations.of(
                                                            context)!
                                                        .translate("ok")
                                                        .toString(),
                                                  )),
                                            )
                                          ],
                                        ),
                                      ).then((value) {
                                        Navigator.of(context).pop();
                                      });
                                    } else {
                                      showDialog<String>(
                                        context: context,
                                        builder: (BuildContext context) =>
                                            AlertDialog(
                                          title: Padding(
                                              padding:
                                                  const EdgeInsets.all(12.0),
                                              child: Image(
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    .07,
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    .04,
                                                color:
                                                    ColorManager.primaryColor,
                                                image: const AssetImage(
                                                    "assets/images/warning.png"),
                                              )),
                                          content: Text(
                                            AppLocalizations.of(context)!
                                                .translate("warn")
                                                .toString(),
                                            style: GoogleFonts.almarai(
                                                color: ColorManager.textColor,
                                                fontSize: 16),
                                            textAlign: TextAlign.center,
                                          ),
                                          actions: [
                                            Center(
                                              child: ElevatedButton(
                                                  onPressed: () {
                                                    MandoobCubit.get(context)
                                                        .getUserDetails();
                                                    Navigator.of(context)
                                                        .pushAndRemoveUntil(
                                                            MaterialPageRoute(
                                                                builder:
                                                                    (context) =>
                                                                        const LoginScreen()),
                                                            (Route<dynamic>
                                                                    route) =>
                                                                false);
                                                  },
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                    backgroundColor: ColorManager
                                                        .primaryColor,
                                                  ),
                                                  child: Text(
                                                    AppLocalizations.of(
                                                            context)!
                                                        .translate("login")
                                                        .toString(),
                                                  )),
                                            )
                                          ],
                                        ),
                                      ).then((value) {
                                        Navigator.of(context).pop();
                                      });
                                    }
                                  }),
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * .05,
                            ),
                            Expanded(
                              child: DefaultButton(
                                buttonText: AppLocalizations.of(context)!
                                    .translate("viewDetails")
                                    .toString(),
                                color: ColorManager.gold,
                                color2: ColorManager.gold,
                                textColor: ColorManager.textColor,
                                onPressed: () {
                                  if (CashHelper.getData(key: 'isGuest') !=
                                      true) {
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (_) => OrderDetails(
                                                widget.productModel)));
                                  } else {
                                    showDialog<String>(
                                      context: context,
                                      builder: (BuildContext context) =>
                                          AlertDialog(
                                        title: Padding(
                                            padding: const EdgeInsets.all(12.0),
                                            child: Image(
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  .07,
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  .04,
                                              color: ColorManager.primaryColor,
                                              image: const AssetImage(
                                                  "assets/images/warning.png"),
                                            )),
                                        content: Text(
                                          AppLocalizations.of(context)!
                                              .translate("warn")
                                              .toString(),
                                          style: GoogleFonts.almarai(
                                              color: ColorManager.textColor,
                                              fontSize: 16),
                                          textAlign: TextAlign.center,
                                        ),
                                        actions: [
                                          Center(
                                            child: ElevatedButton(
                                                onPressed: () {
                                                  MandoobCubit.get(context)
                                                      .getUserDetails();

                                                  Navigator.of(context)
                                                      .pushAndRemoveUntil(
                                                          MaterialPageRoute(
                                                              builder: (context) =>
                                                                  const LoginScreen()),
                                                          (Route<dynamic>
                                                                  route) =>
                                                              false);
                                                },
                                                style: ElevatedButton.styleFrom(
                                                  backgroundColor: ColorManager.primaryColor,
                                                ),
                                                child: Text(
                                                  AppLocalizations.of(context)!
                                                      .translate("login")
                                                      .toString(),
                                                )),
                                          )
                                        ],
                                      ),
                                    ).then((value) {
                                      Navigator.of(context).pop();
                                    });
                                  }
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )
        : const SizedBox();
  }
}
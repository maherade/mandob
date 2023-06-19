import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mandob/business_logic/mandoob_cubit/mandoob_cubit.dart';
import 'package:mandob/data/modles/product_model.dart';
import 'package:mandob/presentation/screens/customer/customer_details/customer_details.dart';
import 'package:mandob/presentation/screens/mandob/order_details_screen/order_details.dart';
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
            height: MediaQuery.of(context).size.height * .45,
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
                  child: Container(
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
                      Expanded(
                        child: Text(
                          "من: ${widget.productModel.productFrom}",
                          style: GoogleFonts.cairo(
                            fontSize: 16.0,
                            fontWeight: FontWeight.w600,
                            color: ColorManager.textColor,
                          ),
                        ),
                      ),
                      Expanded(
                          child: Text(
                        "الي: ${widget.productModel.productTo}",
                        style: GoogleFonts.cairo(
                          fontSize: 16.0,
                          fontWeight: FontWeight.w600,
                          color: ColorManager.textColor,
                        ),
                      )),
                      Expanded(
                        child: Text(
                          "الوزن: ${widget.productModel.productWeight}",
                          style: GoogleFonts.cairo(
                            fontSize: 16.0,
                            fontWeight: FontWeight.w600,
                            color: ColorManager.textColor,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Text(
                          "السعر: ${widget.productModel.productPrice}",
                          style: GoogleFonts.cairo(
                            fontSize: 16.0,
                            fontWeight: FontWeight.w600,
                            color: ColorManager.textColor,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * .01,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: DefaultButton(
                              buttonText: "موافق",
                              color: ColorManager.primaryColor,
                              color2: ColorManager.primaryColor,
                              onPressed: () {
                                setState(() {
                                  MandoobCubit.get(context)
                                      .updateMandoobCounter();
                                  MandoobCubit.get(context)
                                      .updateProductsList(widget.productModel);
                                });
                                MandoobCubit.get(context)
                                    .onOrderAccepted(
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
                                )
                                    .then((value) {
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
                                                'assets/images/check.png')),
                                      ),
                                      content: Text(
                                        'لقد وافقت علي الطلب يمكنك الان التواصل مع صاحب الطلب',
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
                                                        .productModel.userName!,
                                                    phone: widget.productModel
                                                        .userPhone!,
                                                    pic: widget.productModel
                                                        .userImage!,
                                                  ),
                                                ));
                                              },
                                              style: ElevatedButton.styleFrom(
                                                primary: Colors.green.shade700,
                                              ),
                                              child: const Text("OK")),
                                        )
                                      ],
                                    ),
                                  ).then((value) {
                                    Navigator.of(context).pop();
                                  });
                                });
                              },
                            ),
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * .05,
                          ),
                          Expanded(
                            child: DefaultButton(
                              buttonText: "عرض التفاصيل",
                              color: ColorManager.gold,
                              color2: ColorManager.gold,
                              textColor: ColorManager.textColor,
                              onPressed: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (_) =>
                                        OrderDetails(widget.productModel)));
                              },
                            ),
                          ),
                        ],
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

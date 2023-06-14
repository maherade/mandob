import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mandob/data/modles/product_model.dart';
import 'package:mandob/widgets/defualtButton.dart';

import '../styles/color_manager.dart';

class OrderItem extends StatefulWidget {
  ProductModel productModel;

  OrderItem(this.productModel, {super.key});

  @override
  State<OrderItem> createState() => _OrderItemState();
}

class _OrderItemState extends State<OrderItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
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
                        onPressed: () {},
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
                        onPressed: () {},
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

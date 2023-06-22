import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mandob/business_logic/localization_cubit/app_localization.dart';
import 'package:mandob/data/modles/my_products.dart';

import '../styles/color_manager.dart';

class MandoobHistoryItem extends StatefulWidget {
  MyProduct myProduct;

  MandoobHistoryItem(this.myProduct, {super.key});

  @override
  State<MandoobHistoryItem> createState() => _MandoobHistoryItemState();
}

class _MandoobHistoryItemState extends State<MandoobHistoryItem> {
  @override
  Widget build(BuildContext context) {
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
            child: Container(
              width: double.infinity,
              child: Image.network(
                '${widget.myProduct.productImage}',
                fit: BoxFit.fitWidth,
              ),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: MediaQuery.sizeOf(context).height * .01,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                    child: Text(
                      "${AppLocalizations.of(context)!.translate("from").toString()}: ${widget.myProduct.productFrom}",
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
                height: MediaQuery.sizeOf(context).height * .01,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                    child: Text(
                      "${AppLocalizations.of(context)!.translate("to").toString()}: ${widget.myProduct.productTo}",
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
                height: MediaQuery.sizeOf(context).height * .01,
              ),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      "${AppLocalizations.of(context)!.translate("weight").toString()}: ${widget.myProduct.productWeight}",
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
                height: MediaQuery.sizeOf(context).height * .01,
              ),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      "${AppLocalizations.of(context)!.translate("price").toString()}: ${widget.myProduct.productPrice}",
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
            ],
          ),
        ],
      ),
    );
  }
}

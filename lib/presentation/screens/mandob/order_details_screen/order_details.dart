import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mandob/business_logic/localization_cubit/app_localization.dart';
import 'package:mandob/data/modles/product_model.dart';
import 'package:mandob/presentation/screens/customer/customer_screen/customer_screen.dart';
import 'package:mandob/presentation/screens/mandob/mandob.dart';
import 'package:mandob/styles/color_manager.dart';
import 'package:mandob/widgets/default_text_field.dart';

class OrderDetails extends StatelessWidget {
  static const String routeName = 'order-details';
  ProductModel model;

  OrderDetails(this.model);

  @override
  Widget build(BuildContext context) {
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
            onPressed: () {
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (_) => const MandobScreen()));
            },
            icon: const Icon(Icons.arrow_back_ios)),
        title: Text(
          AppLocalizations.of(context)!.translate("orderDetails").toString(),
          style: GoogleFonts.cairo(
            fontSize: 20.0,
            fontWeight: FontWeight.w700,
            color: ColorManager.textColor,
          ),
          textAlign: TextAlign.center,
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(
              horizontal: MediaQuery.sizeOf(context).height * .02),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
                child: Image.network(
                  "${model.productImage}",
                  // ?? "https://firebasestorage.googleapis.com/v0/b/mandoob-e229e.appspot.com/o/usersImage%2FFB_IMG_1686572474106.jpg?alt=media&token=d25fdf45-6ec3-4731-b157-4702878d98d2",

                  fit: BoxFit.fitWidth,
                ),
              ),
              SizedBox(
                height: MediaQuery.sizeOf(context).height * .015,
              ),
              // العنوان
              Text(
                AppLocalizations.of(context)!.translate("address").toString(),
                style: GoogleFonts.cairo(
                  fontSize: 18.0,
                  fontWeight: FontWeight.w700,
                  color: ColorManager.textColor,
                ),
                textAlign: TextAlign.center,
              ),
              DefaultTextField(
                  hintText: "${model.productAddress}",
                  isPass: false,
                  isEnabled: false,
                  prefixIcon: Icons.location_city,
                  controller: CustomerScreen.fromController,
                  textInputType: TextInputType.text),
              SizedBox(
                height: MediaQuery.sizeOf(context).height * .015,
              ),
              //المحافظة
              Text(
                AppLocalizations.of(context)!
                    .translate("government")
                    .toString(),
                style: GoogleFonts.cairo(
                  fontSize: 18.0,
                  fontWeight: FontWeight.w700,
                  color: ColorManager.textColor,
                ),
                textAlign: TextAlign.center,
              ),
              Container(
                padding:
                    EdgeInsets.all(MediaQuery.sizeOf(context).height * .02),
                alignment: AlignmentDirectional.centerStart,
                height: MediaQuery.sizeOf(context).height * .07,
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: Colors.white,
                ),
                child: Row(
                  children: [
                    const Icon(
                      Icons.house,
                      color: Colors.grey,
                    ),
                    SizedBox(
                      width: MediaQuery.sizeOf(context).height * .01,
                    ),
                    Text(
                      "${model.productGovernment}",
                      style: GoogleFonts.almarai(
                          fontSize: 16.0,
                          fontWeight: FontWeight.w300,
                          color: Colors.grey),
                    ),
                  ],
                ),
              ),
              Text(
                AppLocalizations.of(context)!.translate("from").toString(),
                style: GoogleFonts.cairo(
                  fontSize: 18.0,
                  fontWeight: FontWeight.w700,
                  color: ColorManager.textColor,
                ),
                textAlign: TextAlign.center,
              ),
              DefaultTextField(
                  hintText: "${model.productFrom}",
                  isPass: false,
                  isEnabled: false,
                  prefixIcon: Icons.location_city,
                  controller: CustomerScreen.fromController,
                  textInputType: TextInputType.text),
              SizedBox(
                height: MediaQuery.sizeOf(context).height * .015,
              ),
              Text(
                AppLocalizations.of(context)!.translate("to").toString(),
                style: GoogleFonts.cairo(
                  fontSize: 18.0,
                  fontWeight: FontWeight.w700,
                  color: ColorManager.textColor,
                ),
                textAlign: TextAlign.center,
              ),
              DefaultTextField(
                  hintText: "${model.productTo}",
                  isPass: false,
                  isEnabled: false,
                  prefixIcon: Icons.location_city,
                  controller: CustomerScreen.toController,
                  textInputType: TextInputType.text),
              SizedBox(
                height: MediaQuery.sizeOf(context).height * .015,
              ),
              // السعر

              Text(
                AppLocalizations.of(context)!.translate("price").toString(),
                style: GoogleFonts.cairo(
                  fontSize: 18.0,
                  fontWeight: FontWeight.w700,
                  color: ColorManager.textColor,
                ),
                textAlign: TextAlign.center,
              ),
              DefaultTextField(
                hintText: "${model.productPrice}",
                prefixIcon: Icons.price_change,
                isPass: false,
                isEnabled: false,
                controller: CustomerScreen.priceController,
                textInputType: TextInputType.number,
              ),
              SizedBox(
                height: MediaQuery.sizeOf(context).height * .015,
              ),

              // الوزن

              Text(
                AppLocalizations.of(context)!.translate("weight").toString(),
                style: GoogleFonts.cairo(
                  fontSize: 18.0,
                  fontWeight: FontWeight.w700,
                  color: ColorManager.textColor,
                ),
                textAlign: TextAlign.center,
              ),
              DefaultTextField(
                  hintText: "${model.productWeight}",
                  isPass: false,
                  isEnabled: false,
                  prefixIcon: Icons.menu,
                  controller: CustomerScreen.weightController,
                  textInputType: TextInputType.text),
              SizedBox(
                height: MediaQuery.sizeOf(context).height * .015,
              ),

              // الملاحظات

              Text(
                AppLocalizations.of(context)!.translate("notes").toString(),
                style: GoogleFonts.cairo(
                  fontSize: 18.0,
                  fontWeight: FontWeight.w700,
                  color: ColorManager.textColor,
                ),
                textAlign: TextAlign.center,
              ),
              DefaultTextField(
                hintText: "${model.productNotes}",
                controller: CustomerScreen.notesController,
                isEnabled: false,
                textInputType: TextInputType.text,
                lines: 4,
              ),
              SizedBox(
                height: MediaQuery.sizeOf(context).height * .05,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

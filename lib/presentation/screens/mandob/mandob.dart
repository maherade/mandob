import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:mandob/data/modles/product_model.dart';
import 'package:mandob/styles/color_manager.dart';
import 'package:mandob/uitiles/database_utils/datebase_utils.dart';
import 'package:mandob/widgets/view_order.dart';

class MandobScreen extends StatefulWidget {
  const MandobScreen({super.key});

  @override
  State<MandobScreen> createState() => _MandobScreenState();
}

class _MandobScreenState extends State<MandobScreen> {
  final Stream<QuerySnapshot> products = FirebaseFirestore.instance
      .collection('products')
      .snapshots(includeMetadataChanges: true);

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
        actions: [
          Center(
            child: Text("ترتيب حسب",
                style: GoogleFonts.cairo(
                  fontSize: 15.0,
                  fontWeight: FontWeight.w700,
                  color: ColorManager.textColor,
                )),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.filter_list_outlined, size: 30),
          )
        ],
        title: Text(
          'قائمة الطلبات',
          style: GoogleFonts.cairo(
            fontSize: 20.0,
            fontWeight: FontWeight.w700,
            color: ColorManager.textColor,
          ),
          textAlign: TextAlign.center,
        ),
      ),
      drawer: Drawer(),
      body: Container(
        padding: const EdgeInsets.all(5),
        margin: const EdgeInsets.all(5),
        child: Column(
          children: [
            StreamBuilder<QuerySnapshot<ProductModel>>(
                stream: getProductsFromFireStore(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (snapshot.hasError) {
                    return const Center(child: Text('Something went Wrong'));
                  }

                  var product =
                      snapshot.data?.docs.map((doc) => doc.data()).toList() ??
                          [];

                  if (product.isEmpty) {
                    return Center(
                      child: Column(
                        children: [
                          Lottie.asset(
                            "assets/images/empty.json",
                            fit: BoxFit.fill,
                            width: MediaQuery.of(context).size.height * 0.25,
                            height: MediaQuery.of(context).size.height * 0.25,
                          ),
                          Text("لا يوجد طلبات متاحة",
                              style: GoogleFonts.cairo(
                                fontSize: 15.0,
                                fontWeight: FontWeight.w700,
                                color: ColorManager.textColor,
                              ))
                        ],
                      ),
                    );
                  }
                  return Expanded(
                    child: ListView.builder(
                        itemCount: product.length,
                        itemBuilder: (context, index) {
                          return OrderItem(product[index]);
                        }),
                  );
                })
          ],
        ),
      ),
    );
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:mandob/business_logic/mandoob_cubit/mandoob_cubit.dart';
import 'package:mandob/data/modles/product_model.dart';
import 'package:mandob/presentation/screens/customer/customer_screen/customer_screen.dart';
import 'package:mandob/presentation/screens/customer/profile_screen/profile_screen.dart';
import 'package:mandob/styles/color_manager.dart';
import 'package:mandob/uitiles/database_utils/datebase_utils.dart';
import 'package:mandob/widgets/order_item.dart';

import '../../../uitiles/local/cash_helper.dart';
import '../login_screen/login_screen.dart';

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
            onPressed: () {
              // TODO filtration
              showModalBottomSheet(
                  context: context,
                  builder: (BuildContext context) {
                    return Container(
                      color: ColorManager.lightColor,
                      height: MediaQuery.sizeOf(context).height * .5,
                      child: ListView.separated(
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () {
                                setState(() {
                                  CustomerScreen.bottomValue =
                                      MandoobCubit.get(context)
                                          .governmentName[index];
                                });
                                Navigator.pop(context);
                              },
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 5),
                                child: Text(
                                    MandoobCubit.get(context)
                                        .governmentName[index],
                                    style: GoogleFonts.cairo(
                                      fontSize: 15.0,
                                      fontWeight: FontWeight.w700,
                                      color: ColorManager.textColor,
                                    )),
                              ),
                            );
                          },
                          separatorBuilder: (context, index) {
                            return const Divider(
                              color: Colors.black,
                            );
                          },
                          itemCount:
                              MandoobCubit.get(context).governmentName.length),
                    );
                  }).then((value) {});
            },
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
      drawer: Drawer(
        child: Container(
          color: ColorManager.lightColor,
          child: Column(
            children: [
              SizedBox(
                height: MediaQuery.sizeOf(context).height * .01,
              ),
              Container(
                height: MediaQuery.sizeOf(context).height * .32,
                width: double.infinity,
                color: ColorManager.lightColor2,
                child: Column(
                  children: [
                    SizedBox(
                      height: MediaQuery.sizeOf(context).height * .06,
                    ),
                    CircleAvatar(
                      radius: 67,
                      backgroundColor: ColorManager.lightColor2,
                      child: CircleAvatar(
                        backgroundImage: NetworkImage((cubit.user!.pic!)),
                        radius: 65,
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.sizeOf(context).height * .01,
                    ),
                    Text(cubit.user!.name!,
                        style: GoogleFonts.cairo(
                          fontSize: 18.0,
                          fontWeight: FontWeight.w700,
                          color: ColorManager.textColor,
                        )),
                  ],
                ),
              ),
              const SizedBox(
                height: 5,
              ),

              // حسابي

              GestureDetector(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (_) {
                    return const ProfileScreen();
                  }));
                },
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const Icon(Icons.person),
                      const SizedBox(
                        width: 10,
                      ),
                      Text('حسابي',
                          style: GoogleFonts.cairo(
                            fontSize: 18.0,
                            fontWeight: FontWeight.w700,
                            color: ColorManager.textColor,
                          )),
                    ],
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  // cubit.getCustomerHistory();
                  // Navigator.push(context, MaterialPageRoute(builder: (_){
                  //   return const CustomerHistory();
                  // }));
                },
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const Icon(Icons.cached_sharp),
                      const SizedBox(
                        width: 10,
                      ),
                      Text('باقات التوصيل',
                          style: GoogleFonts.cairo(
                            fontSize: 16.0,
                            fontWeight: FontWeight.w700,
                            color: ColorManager.textColor,
                          )),
                    ],
                  ),
                ),
              ),

              // مرجعي
              GestureDetector(
                onTap: () {
                  // cubit.getCustomerHistory();
                  // Navigator.push(context, MaterialPageRoute(builder: (_){
                  //   return const CustomerHistory();
                  // }));
                },
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const Icon(Icons.history),
                      const SizedBox(
                        width: 10,
                      ),
                      Text('مرجعي',
                          style: GoogleFonts.cairo(
                            fontSize: 16.0,
                            fontWeight: FontWeight.w700,
                            color: ColorManager.textColor,
                          )),
                    ],
                  ),
                ),
              ),

              // تسجيل الخروج
              GestureDetector(
                onTap: () {
                  CashHelper.removeData(key: 'isUid');
                  Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(
                          builder: (context) => const LoginScreen()),
                      (Route<dynamic> route) => false);
                },
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const Icon(Icons.logout),
                      const SizedBox(
                        width: 10,
                      ),
                      Text('تسجيل الخروج',
                          style: GoogleFonts.cairo(
                            fontSize: 16.0,
                            fontWeight: FontWeight.w700,
                            color: ColorManager.textColor,
                          )),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
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

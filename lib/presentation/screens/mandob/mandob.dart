import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:mandob/business_logic/mandoob_cubit/mandoob_cubit.dart';
import 'package:mandob/data/modles/product_model.dart';
import 'package:mandob/presentation/screens/customer/profile_screen/profile_screen.dart';
import 'package:mandob/presentation/screens/mandob/mandoob_history/mandoob_history.dart';
import 'package:mandob/presentation/screens/start_screen/start_screen.dart';
import 'package:mandob/styles/color_manager.dart';
import 'package:mandob/uitiles/database_utils/datebase_utils.dart';
import 'package:mandob/widgets/order_item.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../uitiles/local/cash_helper.dart';
import 'packages/packedges.dart';

class MandobScreen extends StatefulWidget {
  const MandobScreen({super.key});

  static String government = '';
  static List<ProductModel> allProducts = [];

  @override
  State<MandobScreen> createState() => _MandobScreenState();
}

class _MandobScreenState extends State<MandobScreen> {
  final Stream<QuerySnapshot> products = FirebaseFirestore.instance
      .collection('products')
      .snapshots(includeMetadataChanges: true);

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Uri iosWhatsapp = Uri.parse('whatsapp://wa.me/+96872261622');
    final Uri androidWhatsapp = Uri.parse('whatsapp://send?phone=+96872261622');
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
                                  MandobScreen.government =
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
                height: MediaQuery.sizeOf(context).height * .3,
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
                      const Icon(Icons.person_2_outlined),
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
              // عدد الباقات المتبقية
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Icon(Icons.backpack_outlined),
                    const SizedBox(
                      width: 10,
                    ),
                    Text('متبقي ${cubit.user!.count!} توصيلة ',
                        style: GoogleFonts.cairo(
                          fontSize: 18.0,
                          fontWeight: FontWeight.w700,
                          color: ColorManager.textColor,
                        )),
                  ],
                ),
              ),
              //شراء الباقات
              GestureDetector(
                onTap: () {
                  showDialog<String>(
                    context: context,
                    builder: (BuildContext context) => AlertDialog(
                      title: Lottie.asset("assets/images/money.json",
                          height: MediaQuery.sizeOf(context).height * .25),
                      actions: [
                        Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "اختر طريقة الدفع المناسبة لك",
                                style: GoogleFonts.almarai(
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.w500,
                                    color: ColorManager.textColor),
                              ),
                              SizedBox(
                                height: MediaQuery.sizeOf(context).height * .02,
                              ),
                              ElevatedButton(
                                  onPressed: () {
                                    MandoobCubit.get(context).getUserDetails();
                                    Navigator.of(context)
                                        .push(MaterialPageRoute(
                                      builder: (_) => const Packages(),
                                    ));
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.blue.shade900,
                                  ),
                                  child: Text(
                                    "الدفع عن طريق باي بال",
                                    style: GoogleFonts.almarai(
                                        fontSize: 18.0,
                                        fontWeight: FontWeight.w300,
                                        color: Colors.white),
                                  )),
                              SizedBox(
                                height: MediaQuery.sizeOf(context).height * .01,
                              ),
                              ElevatedButton(
                                  onPressed: () {
                                    Platform.isIOS
                                        ? launchUrl(iosWhatsapp)
                                        : launchUrl(androidWhatsapp);
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.green.shade900,
                                  ),
                                  child: Text(
                                    "التواصل مع المسئول للدفع",
                                    style: GoogleFonts.almarai(
                                        fontSize: 18.0,
                                        fontWeight: FontWeight.w300,
                                        color: Colors.white),
                                  )),
                            ],
                          ),
                        )
                      ],
                    ),
                  ).then((value) => Navigator.pop(context));
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
                      Text('شراء باقات توصيل',
                          style: GoogleFonts.cairo(
                            fontSize: 18.0,
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
                  cubit.getCustomerHistory();
                  Navigator.push(context, MaterialPageRoute(builder: (_) {
                    return const MandoobHistory();
                  }));
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
                            fontSize: 18.0,
                            fontWeight: FontWeight.w700,
                            color: ColorManager.textColor,
                          )),
                    ],
                  ),
                ),
              ),
              //الابلاغ عن مشكلة
              GestureDetector(
                onTap: () {
                  cubit.getCustomerHistory();
                  Platform.isIOS
                      ? launchUrl(iosWhatsapp)
                      : launchUrl(androidWhatsapp);
                },
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const Icon(Icons.report_problem_outlined),
                      const SizedBox(
                        width: 10,
                      ),
                      Text('الابلاغ عن مشكلة',
                          style: GoogleFonts.cairo(
                            fontSize: 18.0,
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
                          builder: (context) => const StartScreen()),
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
                            fontSize: 18.0,
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

                  if (MandobScreen.government == 'محافظة الداخلية') {
                    MandobScreen.allProducts = [];

                    product.forEach((element) {
                      if (element.productGovernment == 'محافظة الداخلية') {
                        MandobScreen.allProducts.add(element);
                      }
                    });
                  } else if (MandobScreen.government == 'محافظة الظاهرة') {
                    MandobScreen.allProducts = [];

                    product.forEach((element) {
                      if (element.productGovernment == 'محافظة الظاهرة') {
                        MandobScreen.allProducts.add(element);
                      }
                    });
                  } else if (MandobScreen.government == 'محافظة شمال الباطنة') {
                    MandobScreen.allProducts = [];

                    product.forEach((element) {
                      if (element.productGovernment == 'محافظة شمال الباطنة') {
                        MandobScreen.allProducts.add(element);
                      }
                    });
                  } else if (MandobScreen.government == 'محافظة جنوب الباطنة') {
                    MandobScreen.allProducts = [];

                    product.forEach((element) {
                      if (element.productGovernment == 'محافظة جنوب الباطنة') {
                        MandobScreen.allProducts.add(element);
                      }
                    });
                  } else if (MandobScreen.government == 'محافظة البريمي') {
                    MandobScreen.allProducts = [];

                    product.forEach((element) {
                      if (element.productGovernment == 'محافظة البريمي') {
                        MandobScreen.allProducts.add(element);
                      }
                    });
                  } else if (MandobScreen.government == 'محافظة شمال الشرقية') {
                    MandobScreen.allProducts = [];

                    product.forEach((element) {
                      if (element.productGovernment == 'محافظة شمال الشرقية') {
                        MandobScreen.allProducts.add(element);
                      }
                    });
                  } else if (MandobScreen.government == 'محافظة الوسطى') {
                    MandobScreen.allProducts = [];

                    product.forEach((element) {
                      if (element.productGovernment == 'محافظة الوسطى') {
                        MandobScreen.allProducts.add(element);
                      }
                    });
                  } else if (MandobScreen.government == 'محافظة جنوب الشرقية') {
                    MandobScreen.allProducts = [];

                    product.forEach((element) {
                      if (element.productGovernment == 'محافظة جنوب الشرقية') {
                        MandobScreen.allProducts.add(element);
                      }
                    });
                  } else if (MandobScreen.government == 'محافظة ظفار') {
                    MandobScreen.allProducts = [];

                    product.forEach((element) {
                      if (element.productGovernment == 'محافظة ظفار') {
                        MandobScreen.allProducts.add(element);
                      }
                    });
                  } else if (MandobScreen.government == 'محافظة مسقط') {
                    MandobScreen.allProducts = [];

                    product.forEach((element) {
                      if (element.productGovernment == 'محافظة مسقط') {
                        MandobScreen.allProducts.add(element);
                      }
                    });
                  } else if (MandobScreen.government == 'محافظة مسندم') {
                    MandobScreen.allProducts = [];

                    product.forEach((element) {
                      if (element.productGovernment == 'محافظة مسندم') {
                        MandobScreen.allProducts.add(element);
                      }
                    });
                  } else {
                    MandobScreen.allProducts = [];
                    product.forEach((element) {
                      MandobScreen.allProducts.add(element);
                    });
                  }

                  if (MandobScreen.allProducts.isEmpty) {
                    return Center(
                      child: Column(
                        children: [
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.2,
                          ),
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
                  } else if (MandoobCubit.get(context).user!.count == 0) {
                    return Center(
                      child: Column(
                        children: [
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.18,
                          ),
                          Lottie.asset(
                            "assets/images/card.json",
                            fit: BoxFit.fill,
                            width: MediaQuery.of(context).size.height * 0.25,
                            height: MediaQuery.of(context).size.height * 0.25,
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.04,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                                "انتا استهلكت كل التوصيلات المجانيه لاستمرار اشترك في احدي الباقات المتاحه",
                                style: GoogleFonts.cairo(
                                  fontSize: 15.0,
                                  fontWeight: FontWeight.w700,
                                  color: ColorManager.textColor,
                                ),
                                textAlign: TextAlign.center),
                          )
                        ],
                      ),
                    );
                  }

                  return Expanded(
                    child: ListView.builder(
                        itemCount: MandobScreen.allProducts.length,
                        itemBuilder: (context, index) {
                          return OrderItem(
                              productModel: MandobScreen.allProducts[index]);
                        }),
                  );
                })
          ],
        ),
      ),
    );
  }
}

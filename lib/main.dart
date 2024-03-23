import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:mandob/business_logic/localization_cubit/app_localization.dart';
import 'package:mandob/business_logic/localization_cubit/localization_states.dart';
import 'package:mandob/business_logic/mandoob_cubit/mandoob_cubit.dart';
import 'package:mandob/presentation/screens/home_screen/home_screen.dart';
import 'package:mandob/presentation/screens/login_screen/login_screen.dart';
import 'package:mandob/presentation/screens/splash_screen/splash_screen.dart';
import 'package:mandob/styles/color_manager.dart';
import 'package:mandob/uitiles/local/cash_helper.dart';
import 'business_logic/localization_cubit/localization_cubit.dart';
import 'firebase_options.dart';
import 'presentation/screens/register_screen/register_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await CashHelper.init();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  AwesomeNotifications().initialize(
    'resource://drawable/delivery',
    [
      NotificationChannel(
        channelKey: 'basic key',
        channelName: 'test chanel',
        channelDescription: 'notification test',
        playSound: true,
        channelShowBadge: true,
      ),
    ],
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});




  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (BuildContext context) => MandoobCubit()
              ..getCustomerHistory()..getProduct()
              ..getUser()
              ..getPayScreens()),
        BlocProvider(
            create: (BuildContext context) =>
                LocalizationCubit()..fetchLocalization()),
      ],
      child: BlocConsumer<LocalizationCubit, LocalizationStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return MaterialApp(
            theme: ThemeData(
              appBarTheme: const AppBarTheme(
                iconTheme: IconThemeData(
                  color: Colors.black
                ),
                systemOverlayStyle: SystemUiOverlayStyle(
                  statusBarIconBrightness: Brightness.dark,
                  statusBarColor: ColorManager.lightColor,
                ),
              ),
            ),
            debugShowCheckedModeBanner: false,
            home: const SplashScreen(),
            localizationsDelegates: const [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
              DefaultCupertinoLocalizations.delegate,
            ],
            supportedLocales: const [
              Locale("en", ""),
              Locale("ar", ""),
            ],
            locale: LocalizationCubit.get(context).appLocal,
            localeResolutionCallback: (currentLang, supportLang) {
              if (currentLang != null) {
                for (Locale locale in supportLang) {
                  if (locale.languageCode == currentLang.languageCode) {
                    return currentLang;
                  }
                }
              }
              return supportLang.first;
            },
            routes: {
              "register": (_) => const RegisterScreen(),
              "login": (_) => const LoginScreen(),
              "home": (_) => const HomeScreen(),
            },
          );
        },
      ),
    );
  }
}

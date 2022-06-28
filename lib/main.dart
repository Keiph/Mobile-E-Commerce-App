import 'package:boogle_mobile/providers/cart_list.dart';
import 'package:boogle_mobile/providers/history_list.dart';
import 'package:boogle_mobile/providers/liked_list.dart';

import 'package:boogle_mobile/providers/product_list.dart';
import 'package:boogle_mobile/screens/add_product_screen.dart';
import 'package:boogle_mobile/screens/cart_payment_screen.dart';
import 'package:boogle_mobile/screens/cart_screen.dart';
import 'package:boogle_mobile/screens/history_screen.dart';

import 'package:boogle_mobile/screens/login_screen.dart';
import 'package:boogle_mobile/screens/order_screen.dart';
import 'package:boogle_mobile/screens/payment_screen.dart';
import 'package:boogle_mobile/screens/product_screen.dart';
import 'package:boogle_mobile/screens/random_shuffle_screen.dart';
import 'package:boogle_mobile/screens/settings_screen.dart';
import 'package:boogle_mobile/screens/splash_screen.dart';

import 'package:boogle_mobile/widgets/bottom_navbar.dart';
import 'package:country_code_picker/country_localizations.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.black54,
      systemNavigationBarColor: Colors.transparent,
    ),
  );
  SystemChrome.setPreferredOrientations(
    [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown],
  );

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  // Using "static" so that we can easily access it later
  static ValueNotifier<ThemeMode> themeNotifier =
      ValueNotifier(ThemeMode.light);

  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<ProductList>(
          create: (BuildContext ctx) => ProductList(),
        ),
        ChangeNotifierProvider<LikedList>(
          create: (BuildContext ctx) => LikedList(),
        ),
        ChangeNotifierProvider<CartList>(
          create: (BuildContext ctx) => CartList(),
        ),
        ChangeNotifierProvider<HistoryList>(
          create: (BuildContext ctx) => HistoryList(),
        ),
      ],
      child: ValueListenableBuilder<ThemeMode>(
        valueListenable: MyApp.themeNotifier,
        // '_' means the builder requires the arguments, however we are not using it
        builder: (_, ThemeMode currentMode, __) {
          return MaterialApp(
            supportedLocales: const [
              Locale('en', 'US'),
              Locale('en', 'UK'),
            ],
            localizationsDelegates: const [CountryLocalizations.delegate],
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              fontFamily: 'Montserrat',
              primarySwatch: Colors.blue,
            ),
            darkTheme: ThemeData.dark().copyWith(
              textTheme: ThemeData.dark().textTheme.apply(
                    fontFamily: 'Montserrat',
                  ),
              primaryTextTheme: ThemeData.dark().textTheme.apply(
                    fontFamily: 'Montserrat',
                  ),
            ),
            themeMode: currentMode,
            home: const SplashScreen(),
            routes: {
              LoginScreen.routeName: (_) {
                return const LoginScreen();
              },
              ProductScreen.routeName: (_) {
                return const ProductScreen();
              },
              PaymentScreen.routeName: (_) {
                return const PaymentScreen();
              },
              CartPaymentScreen.routeName: (_) {
                return const CartPaymentScreen();
              },
              CartScreen.routeName: (_) {
                return const CartScreen();
              },
              AddProductScreen.routeName: (_) {
                return const AddProductScreen();
              },
              HistoryScreen.routeName: (_) {
                return const HistoryScreen();
              },
              SettingsScreen.routeName: (_) {
                return const SettingsScreen();
              },
              RandomShuffleScreen.routeName: (_) {
                return RandomShuffleScreen();
              },
              OrderScreen.routeName: (_) {
                return const OrderScreen();
              },
            },
          );
        },
      ),
    );
  }
}

class MainScreen extends StatelessWidget {
  static String routeName = '/';

  const MainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      resizeToAvoidBottomInset: false,
      body: Center(),
      bottomNavigationBar: BottomNav(),
    );
  }
}

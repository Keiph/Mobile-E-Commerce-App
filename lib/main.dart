import 'package:boogle_mobile/providers/cart_list.dart';
import 'package:boogle_mobile/providers/history_list.dart';
import 'package:boogle_mobile/providers/liked_list.dart';

import 'package:boogle_mobile/providers/product_list.dart';
import 'package:boogle_mobile/screens/add_product_screen.dart';
import 'package:boogle_mobile/screens/cart_payment_screen.dart';
import 'package:boogle_mobile/screens/cart_screen.dart';
import 'package:boogle_mobile/screens/edit_product_screen.dart';
import 'package:boogle_mobile/screens/history_screen.dart';
import 'package:boogle_mobile/screens/home_screen.dart';

import 'package:boogle_mobile/screens/login_screen.dart';
import 'package:boogle_mobile/screens/order_screen.dart';
import 'package:boogle_mobile/screens/payment_screen.dart';
import 'package:boogle_mobile/screens/product_screen.dart';
import 'package:boogle_mobile/screens/qr_code_scanner_screen.dart';
import 'package:boogle_mobile/screens/random_shuffle_screen.dart';
import 'package:boogle_mobile/screens/register_screen.dart';
import 'package:boogle_mobile/screens/reset_password_screen.dart';
import 'package:boogle_mobile/screens/settings_screen.dart';
import 'package:boogle_mobile/services/auth_service.dart';

import 'package:boogle_mobile/widgets/bottom_navbar.dart';
import 'package:country_code_picker/country_localizations.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart';

void main() {
  //binds the framework to the Flutter engine
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.black54,
      systemNavigationBarColor: Colors.transparent,
    ),
  );
  SystemChrome.setPreferredOrientations(
    //only portrait mode for the phone is enabled turning it landscape will not work
    [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown],
  );

  runApp(MyApp());



}

class MyApp extends StatefulWidget {
  // Using "static" so that we can easily access it later
  static ValueNotifier<ThemeMode> themeNotifier =
      ValueNotifier(ThemeMode.light);


  @override
  State<MyApp> createState() => _MyAppState();

}

class _MyAppState extends State<MyApp> {
  AuthService authService = AuthService();
  @override
  void initState() {
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ThemeMode>(
        valueListenable: MyApp.themeNotifier,
        // '_' means the builder requires the arguments, however we are not using it
        builder: (_, ThemeMode currentMode, __) {
          return FutureBuilder(
              future: Firebase.initializeApp(),
              builder: (ctx, snapshot) => snapshot.connectionState == ConnectionState.waiting ?
              Center(child: CircularProgressIndicator()) :StreamBuilder<User?>(
                  stream: authService.getAuthUser(),
                  builder: (context, snapshot) {
                    return MaterialApp(
                      supportedLocales: const [
                        Locale('en', 'US'),
                        Locale('en', 'UK'),
                      ],
                      localizationsDelegates: const [
                        CountryLocalizations.delegate
                      ],
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
                      //themeMode changes to ThemeMode.dark / ThemeMode.light
                      themeMode: currentMode,
                      home: snapshot.connectionState == ConnectionState.waiting ?
                      Center(child: CircularProgressIndicator()) :
                      snapshot.hasData ? MainScreen(snapshot.data as User) : LoginScreen(),
                      routes: {
                        LoginScreen.routeName: (_) {
                          return LoginScreen();
                        },
                        RegisterScreen.routeName: (_) {
                          return RegisterScreen();
                        },
                        ResetPasswordScreen.routeName: (_) {
                          return ResetPasswordScreen();
                        },
                        ProductScreen.routeName: (_) {
                          return const ProductScreen();
                        },
                        PaymentScreen.routeName: (_) {
                          return const PaymentScreen();
                        },
                        CartPaymentScreen.routeName: (_) {
                          return CartPaymentScreen();
                          },
                        CartScreen.routeName: (_) {
                          return const CartScreen();
                          },
                        AddProductScreen.routeName: (_) {
                          return const AddProductScreen();
                        },
                        EditProductScreen.routeName: (_) {
                          return const EditProductScreen();
                        },
                        /*
              HistoryScreen.routeName: (_) {
                return const HistoryScreen();
              },*/
                        SettingsScreen.routeName: (_) {
                          return const SettingsScreen();
                        },
                        /*
              RandomShuffleScreen.routeName: (_) {
                return RandomShuffleScreen();
              },*/
                        OrderScreen.routeName: (_) {
                          return OrderScreen();
                        },
                        QRCodeScannerScreen.routeName: (_) {
                          return QRCodeScannerScreen();
                        },
                      },
                    );
                  }));
        },
      );
  }
}

class MainScreen extends StatelessWidget {
  static String routeName = '/';

  User currentUser;
  MainScreen(this.currentUser);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      resizeToAvoidBottomInset: false,
      body: Center(),
      bottomNavigationBar: BottomNav(),
    );
  }
}

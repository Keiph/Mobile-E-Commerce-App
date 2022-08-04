import 'package:boogle_mobile/main.dart';
import 'package:boogle_mobile/screens/register_screen.dart';
import 'package:boogle_mobile/screens/reset_password_screen.dart';
import 'package:boogle_mobile/services/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  static String routeName = '/login';


  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  String? email;
  String? password;
  var form = GlobalKey<FormState>();
  login() {
    bool isValid = form.currentState!.validate();
    if (isValid) {
      form.currentState!.save();
      AuthService authService = AuthService();
      return authService.login(email, password).then((value) {
        FocusScope.of(context).unfocus();
        Navigator.of(context).pushNamed(MainScreen.routeName);
        ScaffoldMessenger.of(context).hideCurrentSnackBar();
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content:
        Text('Login successfully!'),));
      }).catchError((error) {
        FocusScope.of(context).unfocus();
        String message = error.toString();
        ScaffoldMessenger.of(context).hideCurrentSnackBar();
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content:
        Text(message),));
      });      }
  }


  bool _ishidden = true; // password hide first on init

  @override
  Widget build(BuildContext context) {
    //final isPortrait = MediaQuery.of(context).orientation == Orientation.portrait; //once build method "build the screen" get orientation of screen
    return Scaffold(
      resizeToAvoidBottomInset:
          false, // does not resize the screen when keyboard pops up. (learning note: Quick fix to RenderFlex Overflow error)
      body: Container(
        width: double.infinity,
        height: double.infinity,
        constraints: const BoxConstraints.expand(),
        decoration: BoxDecoration(
          image: DecorationImage(
            image: const AssetImage(
              'images/ruchindra-gunasekara-GK8x_XCcDZg-unsplash.jpg',
            ),
            fit: BoxFit.fill,
            colorFilter: ColorFilter.mode(
              Colors.black.withOpacity(0.7),
              BlendMode.darken,
            ),
          ),
        ),
        child: SafeArea(
          child: Form(
            key: form,
            child: Container(
              padding: const EdgeInsets.symmetric(
                vertical: 10.0,
                horizontal: 30.0,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Expanded(
                    flex: 3,
                    child: Icon(
                      Icons.shopping_cart,
                      size: 100,
                      color: Colors.white,
                    ),
                  ),
                  // 'B good like google' text box
                  Expanded(
                    flex: 1,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(
                          color: Colors.black,
                          width: 1,
                        ),
                      ),
                      margin: const EdgeInsets.all(5.0),
                      padding: const EdgeInsets.all(5.0),
                      child: const Text(
                        'B GOOD LIKE GOOGLE',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                  const Flexible(
                    flex: 1,
                    child: Divider(
                      height: 10,
                      thickness: 1,
                      indent: 65,
                      endIndent: 65,
                      color: Colors.white,
                    ),
                  ),
                  const Expanded(
                    flex: 2,
                    child: Text(
                      'B O O G L E',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 38,
                        color: Colors.white,
                      ),
                    ),
                  ),

                  Expanded(
                    flex: 2,
                    child: Padding(
                      padding:
                          const EdgeInsets.only(left: 30, top: 20, right: 30),
                      child: TextFormField(
                        style: const TextStyle(color: Colors.black),
                        decoration: const InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(),
                          labelStyle: TextStyle(color: Colors.black),
                          hintText: 'Enter Email',
                          hintStyle: TextStyle(color: Colors.black),

                        ),
                        keyboardType: TextInputType.emailAddress,
                        validator: (value) {
                          if (value == null)
                            return "Please provide an email address.";
                          else if (!value.contains('@'))
                            return "Please provide a valid email address.";
                          else
                            return null;
                        },
                        onSaved: (value) {
                          email = value;
                          },
                      ),
                    ),
                  ),

                  Expanded(
                    flex: 2,
                    child: Padding(
                      padding:
                          const EdgeInsets.only(left: 30, top: 20, right: 30),
                      child: TextFormField(
                        style: const TextStyle(color: Colors.black),
                        obscureText: _ishidden,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          border: const OutlineInputBorder(),
                          hintText: 'Enter Password',
                          hintStyle: const TextStyle(color: Colors.black),
                          suffixIcon: IconButton(
                            icon: Icon(
                              _ishidden ? Icons.visibility : Icons.visibility_off,
                              color: Colors.black,
                            ),
                            onPressed: () {
                              setState(() {
                                _ishidden =
                                    !_ishidden; //switching between true & false
                              });
                            },
                          ),
                        ),
                        validator: (value) {
                          if (value == null)
                            return 'Please provide a password.';
                          else if (value.length < 6)
                            return 'Password must be at least 6 characters.';
                          else
                            return null;
                        },
                        onSaved: (value) {
                          password = value;
                        },
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Padding(
                      padding: const EdgeInsets.only(right: 25.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          TextButton(
                            style: TextButton.styleFrom(
                              textStyle: const TextStyle(
                                fontSize: 15,
                                decoration: TextDecoration.underline,
                              ),
                            ),
                            onPressed: () { Navigator.of(context).pushNamed(ResetPasswordScreen.routeName); },
                            child: const Text('Forgot Password?'),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 20.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              Navigator.of(context).pushNamed(RegisterScreen.routeName);
                            },
                            child: const Text(
                              'Register',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              login();
                            },
                            child: const Text(
                              'Login',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 30.0),
                      child: ElevatedButton(
                        child: const Text(
                          'Guest',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          shape: const CircleBorder(),
                          padding: const EdgeInsets.all(30.0),
                        ),
                        onPressed: () {},
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

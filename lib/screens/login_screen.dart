import 'package:boogle_mobile/screens/forgot_password_screen.dart';
import 'package:boogle_mobile/main.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../main.dart';

class LoginScreen extends StatefulWidget {
  static String routeName = '/login';
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _ishidden = true; // password hide first on init


  @override
  Widget build(BuildContext context) {
    //final isPortrait = MediaQuery.of(context).orientation == Orientation.portrait; //once build method "build the screen" get orientation of screen
    return Scaffold(
      resizeToAvoidBottomInset: false, // does not resize the screen when keyboard pops up. (learning note: Quick fix to RenderFlex Overflow error)
      body: Container(
        width: double.infinity,
        height: double.infinity,
        constraints: BoxConstraints.expand(),
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/ruchindra-gunasekara-GK8x_XCcDZg-unsplash.jpg'),
            fit: BoxFit.fill,
            colorFilter: ColorFilter.mode(
                Colors.black.withOpacity(0.7), BlendMode.darken),
          ),
        ),
        child: SafeArea(
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 30.0), //additional padding with respective to SafeArea pre-programmed padding
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
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
                        )),
                    margin: const EdgeInsets.all(5.0),
                    padding: const EdgeInsets.all(5.0),
                    child: Text(
                      'B GOOD LIKE GOOGLE',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black
                      ),
                    ),
                  ),
                ),
                Flexible(
                  flex: 1,
                  child: Divider(
                    height: 10,
                    thickness: 1,
                    indent: 65,
                    endIndent: 65,
                    color: Colors.white,
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Text(
                    'B O O G L E',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 38,
                        color: Colors.white),
                  ),
                ),

                Expanded(
                  flex: 2,
                  child: Padding(
                    padding: EdgeInsets.only(left: 30, top: 20, right: 30),
                    child: TextFormField(
                      style: TextStyle(color: Colors.black),
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(),
                        labelStyle: TextStyle(color: Colors.black),
                        hintText: "Enter Email",
                        hintStyle: TextStyle(color: Colors.black),
                      ),
                    ),
                  ),
                ),

                Expanded(
                  flex: 2,
                  child: Padding(
                    padding: EdgeInsets.only(left: 30, top: 20, right: 30),
                    child: TextFormField(
                      style: TextStyle(color: Colors.black),
                      obscureText: _ishidden,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(),
                        hintText: "Enter Password",
                        hintStyle: TextStyle(color: Colors.black),
                        suffixIcon: IconButton(
                          icon: Icon(
                            _ishidden ? Icons.visibility : Icons.visibility_off,
                            color: Colors.black,
                          ),
                          onPressed: () {
                            setState(() {
                              _ishidden = !_ishidden; //switching between true & false
                            });
                          },
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Padding(
                    padding: EdgeInsets.only(right: 25.0),
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
                          onPressed: () {} ,
                          child: const Text('Forgot Password?'),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Padding(
                    padding: EdgeInsets.only(top:20.0),
                    child:Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton(
                            onPressed:(){},
                            child: const Text('Register', style: TextStyle(color: Colors.white, fontSize: 20.0,fontWeight: FontWeight.bold),)
                        ),
                        ElevatedButton(
                            onPressed:(){Navigator.of(context).pushNamed(MainScreen.routeName);},
                            child: const Text('Login', style: TextStyle(color: Colors.white, fontSize: 20.0,fontWeight: FontWeight.bold),)
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Padding(
                    padding: EdgeInsets.only(top: 30.0),
                    child: ElevatedButton(
                      child: Text('Guest', style: TextStyle(color: Colors.white, fontSize: 20.0,fontWeight: FontWeight.bold)),
                      style: ElevatedButton.styleFrom(
                        shape: CircleBorder(),
                        padding: EdgeInsets.all(30.0),
                      ),
                      onPressed: (){},

                    ),
                  ),
                ),
              ],
            ),
          ),
        ),

      ),

    );
  }
}

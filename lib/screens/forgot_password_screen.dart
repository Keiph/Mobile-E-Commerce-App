import 'package:boogle_mobile/screens/login_screen.dart';
import 'package:flutter/material.dart';

class ForgotPasswordScreen extends StatelessWidget {
  static String routeName = '/forgot-password';

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              flex: 1,
              child: Row(
                children: [
                  IconButton(icon: Icon(Icons.arrow_back), onPressed: () { }),
                  Padding(
                    padding: EdgeInsets.only(left: 10.0) ,
                    child: Text('Forgot Password', style: TextStyle( color: Colors.black, fontSize: 20, fontWeight: FontWeight.w500,fontFamily: "Montserrat"),),
                  ),
                ],
            ),
            ),
          ],
        ),
      ),
    );
  }
}

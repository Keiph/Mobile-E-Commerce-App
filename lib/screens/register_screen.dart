import 'package:boogle_mobile/services/auth_service.dart';
import 'package:boogle_mobile/services/firestore_service.dart';
import 'package:flutter/material.dart';

class RegisterScreen extends StatefulWidget {
  static String routeName= '/register';
  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  String? email;
  String? userName;
  String? phoneNo;
  String? password;
  String? confirmPassword;

  var form = GlobalKey<FormState>();

  register() {
    bool isValid = form.currentState!.validate();
    if (isValid) {
      form.currentState!.save();
      if (password != confirmPassword) {
        FocusScope.of(context).unfocus();
        ScaffoldMessenger.of(context).hideCurrentSnackBar();
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Password and Confirm Password does not match!'),));
      }
      AuthService authService = AuthService();
      FirestoreService fsService = FirestoreService();
      return authService.register(email, password).then((value) {
        return fsService.addUser(email, userName, phoneNo).then((value){
          FocusScope.of(context).unfocus();
          ScaffoldMessenger.of(context).hideCurrentSnackBar();
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('User Registered successfully!'),));
        });
      }).catchError((error) {
        FocusScope.of(context).unfocus();
        String message = error.toString();
        ScaffoldMessenger.of(context).hideCurrentSnackBar();
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content:
        Text(message),));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:Text('Register'),
    ),body: Form(
      key: form,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TextFormField(
            decoration: InputDecoration(label: Text('Username')),
            keyboardType: TextInputType.text,
            validator: (value) {
              if (value == null)
                return "Please provide an username.";
              else
                return null;
            },
            onSaved: (value) {
              userName = value;
            },
          ),
          TextFormField(
            decoration: InputDecoration(label: Text('Email')),
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
          TextFormField(
            decoration: InputDecoration(label: Text('Phone Number')),
            keyboardType: TextInputType.number,
            validator: (value) {
              if (value == null)
                return "Please provide an mobile number.";
              else
                return null;
            },
            onSaved: (value) {
              phoneNo = value;
            },
          ),
          TextFormField(
            decoration: InputDecoration(label: Text('Password')),
            obscureText: true,
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
          TextFormField(
            decoration: InputDecoration(label: Text('Confirm Password')),
            obscureText: true,
            validator: (value) {
              if (value == null)
                return 'Please provide a password.';
              else if (value.length < 6)
                return 'Password must be at least 6 characters.';
              else
                return null;
            },
            onSaved: (value) {
              confirmPassword = value;
            },
          ),
          SizedBox(height: 20),
          ElevatedButton(onPressed: () { register(); }, child: Text('Register')),
        ],
      ),
    ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../widgets/my_appbar.dart';
import '../services/firebase_services.dart';
import '../widgets/login_signup_screens/custom_textfield.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
  static GlobalKey<FormState> _loginScreenFormKey = GlobalKey<FormState>();
}

class _LoginScreenState extends State<LoginScreen> {
  String _password;
  String _emailAddress;
  final FocusNode _passwordFocus = FocusNode();
  final FocusNode _emailAddressFocus = FocusNode();
  final FirebaseServices _auth = FirebaseServices();

  @override
  Widget build(BuildContext context) {
    final MediaQueryData mediaQuery = MediaQuery.of(context);

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: myAppBar(),
        body: Form(
          key: LoginScreen._loginScreenFormKey,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomTextField(
                  focusNode: _emailAddressFocus,
                  hintText: 'Your email address',
                  keyboardType: TextInputType.emailAddress,
                  onChanged: (newValue) {
                    setState(() {
                      _emailAddress = newValue;
                    });
                  },
                  onFieldSubmitted: (val) {
                    _emailAddressFocus.unfocus();
                    FocusScope.of(context).requestFocus(_passwordFocus);
                  },
                  validation: (value) {
                    if (!RegExp(
                            r"^([a-zA-Z0-9_\-\.]+)@([a-zA-Z0-9_\-\.]+)\.([a-zA-Z]{2,5})$")
                        .hasMatch(value)) {
                      return 'Enter valid email address';
                    }
                    return null;
                  },
                ),
                CustomTextField(
                    focusNode: _passwordFocus,
                    obscureText: true,
                    hintText: 'Your password',
                    onChanged: (newValue) {
                      setState(() {
                        _password = newValue;
                      });
                    },
                    onFieldSubmitted: (val) {
                      _passwordFocus.unfocus();
                    },
                    textInputAction: TextInputAction.done,
                    validation: (String input) {
                      if (input.isEmpty)
                        return "Password cannot be null";
                      else
                        return null;
                    }),
                RaisedButton(
                  elevation: 5.0,
                  color: Color(0xFFC6D7C3),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  onPressed: () async {
                    if (!LoginScreen._loginScreenFormKey.currentState
                        .validate())
                      return;
                    else {
                      LoginScreen._loginScreenFormKey.currentState.save();
                      FirebaseUser user =
                          await _auth.signInWithEmailAndPassword(
                              email: _emailAddress, password: _password);
                      if (user != null)
                        Navigator.pushReplacementNamed(context, '/splash');
                    }
                  },
                  child: Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.symmetric(
                      vertical: 7.0,
                    ),
                    width: mediaQuery.size.width * 0.75,
                    child: Text(
                      'Log in',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20.0,
                      ),
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
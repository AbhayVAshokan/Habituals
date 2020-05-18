// User registration/create account screen.

import 'package:flutter/material.dart';
import 'package:habituals/screens/privacy_policy_tos.dart';

import './login_screen.dart';
import '../widgets/my_appbar.dart';
import '../services/api_calls.dart';
import '../widgets/login_signup_screens/custom_textfield.dart';

class CreateAccountScreen extends StatefulWidget {
  @override
  _CreateAccountScreenState createState() => _CreateAccountScreenState();
  static GlobalKey<FormState> _createAccountFormKey = GlobalKey<FormState>();
}

class _CreateAccountScreenState extends State<CreateAccountScreen> {
  bool _checkBox = true;

  int _age;
  String _gender;
  String _password;
  String _position;
  String _emailAddress;
  final FocusNode _ageFocus = FocusNode();
  final FocusNode _genderFocus = FocusNode();
  final FocusNode _passwordFocus = FocusNode();
  final FocusNode _positionFocus = FocusNode();
  final FocusNode _emailAddressFocus = FocusNode();

  @override
  Widget build(BuildContext context) {
    final MediaQueryData mediaQuery = MediaQuery.of(context);
    bool isLargeScreen = mediaQuery.size.width >= 900;

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: myAppBar(
          context: context,
          closeButton: true,
        ),
        body: SizedBox(
          width: mediaQuery.size.width,
          child: Form(
            key: CreateAccountScreen._createAccountFormKey,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40.0),
              child: SingleChildScrollView(
                child: SizedBox(
                  height: mediaQuery.size.height,
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
                          FocusScope.of(context).requestFocus(_genderFocus);
                        },
                        validation: (String input) {
                          bool _checkNumber() {
                            int flag = 0;
                            for (var i = 0; i < input.length; i++) {
                              if ("1234567890".contains(input[i])) flag = 1;
                            }
                            if (flag == 1)
                              return true;
                            else
                              return false;
                          }

                          bool _checkCharacter() {
                            int flag = 0;
                            for (var i = 0; i < input.length; i++) {
                              if ("abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"
                                  .contains(input[i])) flag = 1;
                            }
                            if (flag == 1)
                              return true;
                            else
                              return false;
                          }

                          if (input.length < 8)
                            return "Must contain atleast 8 characters";
                          else if (!_checkNumber())
                            return "Must contain atleast one digit";
                          else if (!_checkCharacter())
                            return "Must contain atleast one character";
                          else
                            return null;
                        },
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          top: 25,
                          bottom: 3.0,
                        ),
                        child: const Text(
                          'Tell us about yourself',
                          style: const TextStyle(
                            fontSize: 15.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      CustomTextField(
                        focusNode: _genderFocus,
                        hintText: 'What is your gender',
                        onChanged: (newValue) {
                          setState(() {
                            _gender = newValue;
                          });
                        },
                        onFieldSubmitted: (val) {
                          _genderFocus.unfocus();
                          FocusScope.of(context).requestFocus(_ageFocus);
                        },
                        validation: (value) {
                          if (value.isEmpty)
                            return "Gender cannot be null";
                          else
                            return null;
                        },
                      ),
                      CustomTextField(
                        focusNode: _ageFocus,
                        hintText: 'Your age',
                        keyboardType: TextInputType.number,
                        onChanged: (newValue) {
                          setState(() {
                            _age = newValue;
                          });
                        },
                        onFieldSubmitted: (val) {
                          _ageFocus.unfocus();
                          FocusScope.of(context).requestFocus(_positionFocus);
                        },
                        validation: (value) {
                          if (!RegExp(r"^[0-9]*$").hasMatch(value)) {
                            return 'Enter valid age';
                          }
                          return null;
                        },
                      ),
                      CustomTextField(
                        focusNode: _positionFocus,
                        hintText:
                            'Your position (Junior, Mid-Level, Senior etc.)',
                        textInputAction: TextInputAction.done,
                        onChanged: (newValue) {
                          setState(() {
                            _position = newValue;
                          });
                        },
                        validation: (value) => null,
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          top: 25,
                          bottom: 5.0,
                        ),
                        child: SizedBox(
                          width: isLargeScreen ? 620 : mediaQuery.size.width,
                          child: Row(
                            children: [
                              SizedBox(
                                height: 20.0,
                                child: Checkbox(
                                  value: _checkBox,
                                  onChanged: (value) {
                                    setState(() {
                                      _checkBox = value;
                                    });
                                  },
                                ),
                              ),
                              const Text(
                                'I agree to join Habituals mailing list',
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: mediaQuery.size.height * 0.075),
                      Hero(
                        tag: 'signinButton',
                        child: RaisedButton(
                          elevation: 5.0,
                          color: Color(0xFFC6D7C3),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          onPressed: () async {
                            if (!CreateAccountScreen
                                ._createAccountFormKey.currentState
                                .validate())
                              return;
                            else {
                              CreateAccountScreen
                                  ._createAccountFormKey.currentState
                                  .save();
                              var status = await registerUser(
                                age: _age,
                                gender: _gender,
                                password: _password,
                                position: _position,
                                mailingList: _checkBox,
                                createdAt: DateTime.now(),
                                emailAddress: _emailAddress,
                              );
                              if (status != null)
                                Navigator.pushNamedAndRemoveUntil(
                                  context,
                                  '/instruction',
                                  (route) => false,
                                );
                            }
                          },
                          child: Container(
                            alignment: Alignment.center,
                            padding: const EdgeInsets.symmetric(
                              vertical: 7.0,
                            ),
                            width: isLargeScreen
                                ? 400
                                : mediaQuery.size.width * 0.75,
                            child: Text(
                              'Create Account',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20.0,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 20),
                            child: Wrap(
                              alignment: WrapAlignment.center,
                              children: [
                                const Text(
                                  'By clicking \'Create Account\' you agree to our ',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () => Navigator.push(
                                    context,
                                    PageRouteBuilder(
                                      pageBuilder: (context, animation,
                                              secondaryAnimation) =>
                                          FadeTransition(
                                        opacity: Tween(
                                          begin: 0.0,
                                          end: 1.0,
                                        ).animate(animation),
                                        child: PrivacyPolicyTOS(
                                          initialIndex: 0,
                                        ),
                                      ),
                                      transitionDuration:
                                          const Duration(milliseconds: 500),
                                    ),
                                  ),
                                  child: const Text(
                                    'TOS ',
                                    style: const TextStyle(
                                      color: Colors.blue,
                                      decoration: TextDecoration.underline,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                const Text(
                                  'and  ',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () => Navigator.push(
                                    context,
                                    PageRouteBuilder(
                                      pageBuilder: (context, animation,
                                              secondaryAnimation) =>
                                          FadeTransition(
                                        opacity: Tween(
                                          begin: 0.0,
                                          end: 1.0,
                                        ).animate(animation),
                                        child: PrivacyPolicyTOS(
                                          initialIndex: 1,
                                        ),
                                      ),
                                      transitionDuration:
                                          const Duration(milliseconds: 500),
                                    ),
                                  ),
                                  child: const Text(
                                    'Privacy Policy',
                                    style: const TextStyle(
                                      color: Colors.blue,
                                      decoration: TextDecoration.underline,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          FittedBox(
                            child: Hero(
                              tag: 'already_have_an_account',
                              flightShuttleBuilder: (flightContext,
                                      animation,
                                      flightDirection,
                                      fromHeroContext,
                                      toHeroContext) =>
                                  DefaultTextStyle(
                                style: DefaultTextStyle.of(toHeroContext).style,
                                child: toHeroContext.widget,
                              ),
                              child: Row(
                                children: [
                                  const Text(
                                    'Already have an account? ',
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () => Navigator.push(
                                      context,
                                      PageRouteBuilder(
                                        pageBuilder: (context, animation,
                                                secondaryAnimation) =>
                                            FadeTransition(
                                          opacity: Tween(
                                            begin: 0.0,
                                            end: 1.0,
                                          ).animate(animation),
                                          child: LoginScreen(),
                                        ),
                                        transitionDuration:
                                            const Duration(milliseconds: 500),
                                      ),
                                    ),
                                    child: const Text(
                                      'Log in',
                                      style: const TextStyle(
                                        color: Colors.blue,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

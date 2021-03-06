// Custom textfields for login and signup screens.

import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String hintText;
  final bool obscureText;
  final Function onChanged;
  final FocusNode focusNode;
  final Function validation;
  final Function onFieldSubmitted;
  final TextInputType keyboardType;
  final TextInputAction textInputAction;

  CustomTextField({
    @required this.hintText,
    @required this.validation,
    this.onChanged,
    this.focusNode,
    this.onFieldSubmitted,
    this.obscureText = false,
    this.keyboardType = TextInputType.text,
    this.textInputAction = TextInputAction.next,
  });

  @override
  Widget build(BuildContext context) {
    final MediaQueryData mediaQuery = MediaQuery.of(context);
    bool isLargeScreen = mediaQuery.orientation == Orientation.landscape;

    return Container(
      width: isLargeScreen ? 600 : mediaQuery.size.width,
      margin: const EdgeInsets.symmetric(
        horizontal: 1.0,
        vertical: 5,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5.0),
        boxShadow: [
          BoxShadow(
            offset: Offset(
              0.0,
              2.0,
            ),
            color: Colors.black26,
            blurRadius: 5.0,
          ),
        ],
        color: Colors.white,
      ),
      child: TextFormField(
        focusNode: focusNode,
        maxLines: 1,
        onFieldSubmitted: onFieldSubmitted,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric(
            vertical: 0.0,
            horizontal: 10.0,
          ),
          hintText: hintText,
          hintStyle: const TextStyle(
            color: Color(0xFF616161),
            fontWeight: FontWeight.w400,
            fontSize: 15.0,
          ),
          errorMaxLines: 1,
          errorBorder: InputBorder.none,
          focusedErrorBorder: InputBorder.none,
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(
              color: Color(0xFF8DAC9E),
            ),
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.lightGreen,
            ),
          ),
        ),
        style: TextStyle(
          color: Colors.black,
          letterSpacing: 1.5,
          height: 1.0,
          fontWeight: FontWeight.w400,
        ),
        cursorColor: Colors.lightGreen,
        keyboardType: keyboardType,
        obscureText: obscureText,
        validator: validation,
        textInputAction: textInputAction,
        onChanged: onChanged,
      ),
    );
  }
}

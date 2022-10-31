import 'package:flutter/material.dart';

class LoginInWidgets {

  static MaterialButton materialButtons({required String buttonText, required Function() onPressed, required Color btnColor}) {
    return MaterialButton(
      onPressed: onPressed,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(11.0),
      ),
      minWidth: 235.0,
      height: 61.0,
      elevation: 6.0,
      color: btnColor,
      child: Text(
        buttonText,
        style: TextStyle(
          color: buttonText == 'Login Now' ? Colors.white : Colors.black,
          fontFamily: 'artifica',
          fontSize: 16.0,
        ),
      ),
    );
  }

}
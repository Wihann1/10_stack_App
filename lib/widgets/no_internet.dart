import 'package:flutter/material.dart';

//DISPLAY A WIDGET WHEN THE APP DETECTS NO INTERNET TO INFORM THE USER.
Widget noInternt() {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Image.asset(
        'lib/resources/images/NoInternet.png',
        height: 150,
        width: 150,
      ),
      const Divider(
        thickness: 3,
        indent: 50,
        endIndent: 50,
      ),
      const Text(
        '     Sorry!\nNo internet.',
        style: TextStyle(fontSize: 24),
      )
    ],
  );
}

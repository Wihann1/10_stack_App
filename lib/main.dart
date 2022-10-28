import 'package:flutter/material.dart';
import 'package:ten_stock/Screens/HomePage.dart';
import 'package:ten_stock/theme/Colors.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: '10 Stock',
        theme: ThemeData(
          //Primary Font

          fontFamily: 'NanumGothic',
          //Primary Color
          colorScheme: ColorScheme.fromSwatch(primarySwatch: MyColors.navy)
              .copyWith(secondary: Colors.grey[500]),
          //Appbar Theme
          appBarTheme: const AppBarTheme(
              centerTitle: true,
              titleTextStyle:
                  TextStyle(fontWeight: FontWeight.w800, fontSize: 24)),
        ),
        //Raisedbutton Theme

        //Default Page

        home: const HomePage());
  }
}

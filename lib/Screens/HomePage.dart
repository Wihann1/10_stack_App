import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:ten_stock/widgets/no_internet.dart';
import 'package:ten_stock/widgets/stocks_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //APPBAR
      appBar: AppBar(
        title:
            //Animated Image in appBar
            Row(
          children: [
            Image.asset(
              'lib/resources/images/Appbar_Coin.gif',
              height: 32,
              width: 32,
            ),
            //Defaul appBar title
            const Text('10 Stack'),
          ],
        ),
      ),

      //BODY
      body: //FUTURE BUILDER FOR INTERNET CHECK
          FutureBuilder(
              future: InternetConnectionChecker().hasConnection,
              builder: (ctx, snapshot) {
                if (snapshot.data == true) {
                  return const StocksWidget();
                }
                if (snapshot.data == false) {
                  return noInternt();
                } else {
                  return const Center(child: CircularProgressIndicator());
                }
              }),
    );
  }
}

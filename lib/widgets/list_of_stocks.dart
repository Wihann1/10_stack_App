import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../api/marketstack/poplist.dart';
import 'no_internet.dart';

//Creating the listview builder to show the stocks with relavant data.

Widget listofstocks(DateTime dateOne, DateTime dateTwo) {
  return FutureBuilder(
      future: popList(DateFormat('yyyy-MM-dd').format(dateOne),
          DateFormat('yyyy-MM-dd').format(dateTwo)),
      builder: (ctx, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          var stocks = snapshot.data;
          //Create string for financial info
          return Expanded(
            child: ListView.builder(
                itemCount: 1,
                itemBuilder: (context, index) {
                  return _stockCard(stocks?[index].symbol, stocks?[index].name,
                      stocks?[index].priceClose, stocks?[index].persDif);
                }),
          );
        }
        if (snapshot.connectionState == ConnectionState.none) {
          return noInternt();
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      });
}

//CARD of one stock
Widget _stockCard(
    String symbol, String name, String priceClose, String persDiff) {
  return Card(
    color: persDiff.contains('-')
        ? const Color.fromARGB(255, 255, 195, 190)
        : const Color.fromARGB(255, 190, 255, 195),
    margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 4),
    child: Padding(
      padding: const EdgeInsets.all(4.0),
      child: ListTile(
          title: Text(symbol),
          subtitle: SizedBox(
              height: 10,
              child: FittedBox(
                  alignment: Alignment.topLeft,
                  fit: BoxFit.scaleDown,
                  child: Text(name))),
          trailing: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('\$$priceClose'),
              Text(
                '$persDiff%',
                style: TextStyle(
                    fontSize: 12,
                    color: persDiff.contains('-') ? Colors.red : Colors.green),
              ),
            ],
          )),
    ),
  );
}

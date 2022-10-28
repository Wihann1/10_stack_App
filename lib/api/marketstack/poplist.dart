import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:ten_stock/api/marketstack/apikey.dart';
import 'package:ten_stock/providers/stock.dart';

//Populate the list of stocks from the API using tickers call
Future<List> popList(String dateOne, String dateTwo) async {
  //Get random number for offset
  //list for result
  List<Stock> result = [];
  var response = await http.get(Uri.parse(
      'http://api.marketstack.com/v1/tickers?access_key=$apikey&offset=0&limit=10'));

  var data = jsonDecode(response.body);
  if (response.statusCode == 200) {
    for (var i = 0; i < 1; i++) {
      result.add(
        Stock(
            symbol: data['data'][i]['symbol'] ?? 'Not Available',
            name: data['data'][i]['name'] ?? 'Not Available',
            hasIntraday: data['data'][i]['has_intraday'] ? 'Yes' : 'No',
            hasEod: data['data'][i]['has_eod'] ? 'Yes' : 'No',
            country: data['data'][i]['country'] ?? 'Not Available',
            priceClose:
                await _getCurrentPrice(data['data'][i]['symbol'], dateOne),
            persDif:
                await _getPersDif(data['data'][i]['symbol'], dateOne, dateTwo)),
      );
    }

    return result;
  } else {
    throw Exception('Error getting ticker');
  }
}

//Get the most recent price using api call.
Future<String> _getCurrentPrice(String ticker, String date) async {
  var httpsUri = Uri(
      scheme: 'http',
      host: 'api.marketstack.com',
      path: 'v1/eod/$date',
      queryParameters: {
        'access_key': apikey,
        'symbols': ticker,
        'limit': '1',
      });

  var response = await http.get(httpsUri);

  var data = jsonDecode(response.body);
  try {
    return data['data'][0]['close'].toString();
  } catch (e) {
    return 'NA';
  }
}

//Get the oldest price from range.
Future<String> _getPreviousPrice(String ticker, String date) async {
  var httpsUri = Uri(
      scheme: 'http',
      host: 'api.marketstack.com',
      path: 'v1/eod/$date',
      queryParameters: {
        'access_key': apikey,
        'symbols': ticker,
        'limit': '1',
      });

  var response = await http.get(httpsUri);

  var data = jsonDecode(response.body);
  try {
    return data['data'][0]['open'].toString();
  } catch (e) {
    return 'NA';
  }
}

//Calcualte the diffrence for the %.
Future<String> _getPersDif(
    String ticker, String currentDate, String perviousDate) async {
  try {
    var currPrice = double.parse(await _getCurrentPrice(ticker, currentDate));
    var prevPrice = double.parse(await _getPreviousPrice(ticker, perviousDate));

    var persDif = (currPrice - prevPrice) / prevPrice * 100;
    return persDif.toStringAsFixed(2);
  } catch (e) {
    return 'NA';
  }
}

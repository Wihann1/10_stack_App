import 'package:easy_search_bar/easy_search_bar.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ten_stock/theme/Colors.dart';
import 'package:ten_stock/widgets/list_of_stocks.dart';

//Starting dates for date range selector.
var searchedText = TextEditingController();
DateTime _selectedDateOne = DateTime.now().subtract(const Duration(days: 2));
DateTime _selectedDateTwo = DateTime.now().subtract(const Duration(days: 1));

class StocksWidget extends StatefulWidget {
  const StocksWidget({super.key});

  @override
  State<StocksWidget> createState() => _StocksWidgetState();
}

class _StocksWidgetState extends State<StocksWidget> {
  //Get the first date.
  void _presentDatePickerOne() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2019),
      lastDate: DateTime.now(),
    ).then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      setState(() {
        if (pickedDate.day == DateTime.now().day) {
          _selectedDateOne = pickedDate.subtract(const Duration(days: 1));
        } else {
          _selectedDateOne = pickedDate;
        }
      });
    });
  }

//Get the second date.
  void _presentDatePickerTwo() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2019),
      lastDate: DateTime.now(),
    ).then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      setState(() {
        if (pickedDate.day == DateTime.now().day) {
          _selectedDateTwo = pickedDate.subtract(const Duration(days: 1));
        } else {
          _selectedDateTwo = pickedDate;
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Date range: ',
              style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                width: 100,
                height: 30,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).colorScheme.secondary),
                  onPressed: _presentDatePickerOne,
                  child:
                      Text(DateFormat('yyyy-MM-dd').format(_selectedDateOne)),
                ),
              ),
            ),
            const Icon(
              Icons.arrow_forward,
              size: 16,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                width: 100,
                height: 30,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).colorScheme.secondary),
                  onPressed: _presentDatePickerTwo,
                  child:
                      Text(DateFormat('yyyy-MM-dd').format(_selectedDateTwo)),
                ),
              ),
            ),
          ],
        ),
        searchBar(),
        listofstocks(_selectedDateTwo, _selectedDateOne)
      ],
    );
  }
}

//Search bar widget that needs work.
Widget searchBar() {
  return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        width: 340,
        height: 60,
        child: EasySearchBar(
          title: const Text('Search'),
          backgroundColor: MyColors.navy,
          iconTheme: const IconThemeData(color: Colors.white),
          suggestions: const ['Green', 'Blue'],
          onSearch: (value) {},
        ),
      ));
}

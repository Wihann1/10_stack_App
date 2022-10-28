//USING OOP TO CREATE A STOCK CLASS TO CODE AROUND.

class Stock {
  Stock(
      {required this.symbol,
      required this.name,
      required this.hasIntraday,
      required this.hasEod,
      required this.country,
      required this.priceClose,
      required this.persDif});

  //Description Info
  String symbol;
  String name;
  String hasIntraday;
  String hasEod;
  String country;

  //Financial Info
  String priceClose;
  String persDif;
}

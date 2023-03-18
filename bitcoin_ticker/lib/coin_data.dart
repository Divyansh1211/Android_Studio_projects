import 'dart:convert';
import 'package:http/http.dart' as http;
import 'price_screen.dart';

const apiKey = 'E7D0359E-DD7C-4B9E-B279-05EDA3A63A8A';
const url = 'https://rest.coinapi.io/v1/exchangerate/';

const List<String> currenciesList = [
  'AUD',
  'BRL',
  'CAD',
  'CNY',
  'EUR',
  'GBP',
  'HKD',
  'IDR',
  'ILS',
  'INR',
  'JPY',
  'MXN',
  'NOK',
  'NZD',
  'PLN',
  'RON',
  'RUB',
  'SEK',
  'SGD',
  'USD',
  'ZAR'
];

const List<String> cryptoList = [
  'BTC',
  'ETH',
  'LTC',
];

class CoinData {
  String selectedCrypto = 'BTC';
  Map<String, String> cryptoPrices = {};
  Future getData(String selectedCurrency) async {
    for (String crypto in cryptoList) {
      String url1 = '$url$crypto/$selectedCurrency?apikey=$apiKey';
      http.Response response = await http.get(
        Uri.parse(url1),
      );
      if (response.statusCode == 200) {
        var decodedData = jsonDecode(response.body);
        double price = decodedData['rate'];
        cryptoPrices[crypto] = price.toStringAsFixed(0);
        print(crypto);
      } else {
        print(response.statusCode);
      }
    }
    return cryptoPrices;
  }
}

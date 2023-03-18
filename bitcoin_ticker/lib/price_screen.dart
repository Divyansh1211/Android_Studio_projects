import 'dart:io';
import 'package:flutter/material.dart';
import 'coin_data.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'cryptocard.dart';

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  String selectedCurrency = 'AUD';
  String selectedCrypto = 'BTC';
  String valueinUSD = '?';

  @override
  List<DropdownMenuItem> getDropdownItems() {
    List<DropdownMenuItem<String>> dropdownItems = [];
    for (String items in currenciesList) {
      var newItem = DropdownMenuItem(
        child: Text(items),
        value: items,
      );
      dropdownItems.add(newItem);
    }
    return dropdownItems;
  }

  Map<String, String> coinValues = {};
  bool isWaiting = false;

  void getMoreData() async {
    isWaiting = true;
    CoinData coinData = CoinData();
    try {
      var data = await coinData.getData(selectedCurrency);
      isWaiting = false;
      setState(() {
        coinValues = data;
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    getMoreData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    getDropdownItems();
    return Scaffold(
      appBar: AppBar(
        title: Text('🤑 Coin Ticker'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          CryptoCard(
            valueinUSD: isWaiting ? '?' : coinValues['BTC'],
            selectedCurrency: selectedCurrency,
            selectedCrypto: 'BTC',
          ),
          CryptoCard(
            valueinUSD: isWaiting ? '?' : coinValues['ETH'],
            selectedCurrency: selectedCurrency,
            selectedCrypto: 'ETH',
          ),
          CryptoCard(
            valueinUSD: isWaiting ? '?' : coinValues['LTC'],
            selectedCurrency: selectedCurrency,
            selectedCrypto: 'LTC',
          ),
          Divider(
            height: 240,
          ),
          Container(
            height: 150.0,
            alignment: Alignment.center,
            padding: EdgeInsets.only(bottom: 30.0),
            color: Colors.lightBlue,
            child: DropdownButton(
              value: selectedCurrency,
              items: getDropdownItems(),
              onChanged: (value) {
                setState(() {
                  selectedCurrency = value!;
                  getMoreData();
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}

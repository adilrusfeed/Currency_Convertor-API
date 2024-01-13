import 'package:currency_converter/models/ratesModel.dart';
import 'package:currency_converter/services/api_services.dart';
import 'package:flutter/material.dart';

class HomeProvider extends ChangeNotifier {
  late RatesModel _result;
  late Map _allCurrencies;

  HomeProvider() {
    _result = RatesModel(
        disclaimer: '', license: '', timestamp: 0, base: '', rates: {});
    _allCurrencies = {};
    refreshRates();
  }

  RatesModel get result => _result;
  Map get allCurrencies => _allCurrencies;
  get exchangedValue => null;

  Future<void> refreshRates() async {
    _result = await ExchangeRates().fetchRates();
    _allCurrencies = await ExchangeRates().fetchCurrencies();
    notifyListeners();
  }
}

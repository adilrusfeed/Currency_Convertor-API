import 'package:currency_converter/services/api_services.dart';
import 'package:flutter/material.dart';

class moneyProvider extends ChangeNotifier {
  TextEditingController amountController = TextEditingController();
  String dropdownValue1 = "INR";
  String dropdownValue2 = "USD";
  String result = "Converted Currency :";

  void changedValue1(String? value) {
    dropdownValue1 = value!;
    notifyListeners();
  }

  void chagedValue2(String? value) {
    dropdownValue2 = value!;
    notifyListeners();
  }

  void resetValue1() {
    dropdownValue1 = result;
    notifyListeners();
  }

  void resultValue2() {
    dropdownValue2 = result;
    notifyListeners();
  }

  void convertCurrency(
      rates, String amount, String fromCurrency, String toCurrency) {
    result =
        '${ExchangeRates().convertCurrency(rates, amount, fromCurrency, toCurrency)}$toCurrency';
    notifyListeners();
  }
}

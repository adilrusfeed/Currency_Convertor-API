import "package:currency_converter/models/allcurrencies.dart";
import "package:currency_converter/models/ratesModel.dart";
import "package:http/http.dart" as http;

class ExchangeRates {
  Future<RatesModel> fetchRates() async {
    final response = await http.get(Uri.parse(
        'https://openexchangerates.org/api/latest.json?app_id=5351d510a4cb48d5ab9824627cf81fc1'));

    if (response.statusCode == 200) {
      final result = ratesModelFromJson(response.body);
      return result;
    }else{
      throw Exception('Failed to load currency rates');
    }
  }

  Future<Map<String, String>> fetchCurrencies() async {
    var response = await http
        .get(Uri.parse('https://openexchangerates.org/api/currencies.json'));

    if (response.statusCode == 200) {
      final allCurrensies = allcurrencyFromJson(response.body);
      return allCurrensies;
    }else{
      throw Exception("Failed to load currencies");
    }
  }



   String convertCurrency(
    Map<String, double> exchangeRates,
    String amount,
    String currencybase,
    String currencyfinal,
  ) {
    if (!exchangeRates.containsKey(currencybase) ||
        !exchangeRates.containsKey(currencyfinal)) {
      return "Invalid currency selection";
    }

    String output = (double.parse(amount) /
            exchangeRates[currencybase]! *
            exchangeRates[currencyfinal]!)
        .toStringAsFixed(2)
        .toString();

    return output;
  }
}
// ignore_for_file: prefer_const_constructors

import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:currency_converter/components/money_converter.dart';
import 'package:currency_converter/controllers/home_controller.dart';
import 'package:currency_converter/controllers/money_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late StreamSubscription subscription;
  var isDeviceConnected = false;
  bool isAlertSet = false;
  @override
  void initState() {
    getConnectivity();
    super.initState();
  }

  getConnectivity() => subscription = Connectivity()
          .onConnectivityChanged
          .listen((ConnectivityResult result) async {
        isDeviceConnected = await InternetConnectionChecker().hasConnection;
        if (!isDeviceConnected && isAlertSet == false) {
          showDialogBox();
          setState(() => isAlertSet = true);
        }
      });

  @override
  void dispose() {
    subscription.cancel();
    super.dispose();
  }

  Widget build(BuildContext context) {
    Provider.of<moneyProvider>(context);
    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: Text(
          'Open Exchange App',
        ),
        centerTitle: true,
      ),
      body: Container(
        height: h,
        width: w,
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/currency.jpg"), fit: BoxFit.cover)),
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(20),
            child: Center(
              child: Form(child: Consumer<HomeProvider>(
                builder: (context, value, child) {
                  final currencyData = value.result;
                  final currenciesMap = value.allCurrencies;

                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      if (currencyData.rates.isNotEmpty)
                        MoneyConverter(
                            currencies: currenciesMap.cast(),
                            rates: currencyData.rates),
                      if (currencyData.rates.isEmpty)
                        const Center(
                          child: CircularProgressIndicator(
                              color: Color.fromARGB(255, 164, 36, 187)),
                        )
                    ],
                  );
                },
              )),
            ),
          ),
        ),
      ),
    );
  }

  showDialogBox() => showCupertinoDialog<String>(
      context: context,
      builder: (BuildContext context) => CupertinoAlertDialog(
            title: const Text("No Connection"),
            content: const Text('Please check Internet'),
            actions: <Widget>[
              TextButton(
                  onPressed: () async {
                    Navigator.pop(context, "Cancel");
                    setState(() => isAlertSet = false);
                    isDeviceConnected =
                        await InternetConnectionChecker().hasConnection;
                    if (!isDeviceConnected) {
                      showDialogBox();
                      setState(
                        () => isAlertSet = true,
                      );
                    }
                  },
                  child: Text("OK")),
            ],
          ));
}

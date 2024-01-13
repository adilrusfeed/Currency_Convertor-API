// ignore_for_file: prefer_const_constructors

import 'package:currency_converter/controllers/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
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
                      if(currencyData.rates.isNotEmpty)if(currencyData.rates.isEmpty)const Center(
                        child: CircularProgressIndicator(color: Colors.purple ),
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
}

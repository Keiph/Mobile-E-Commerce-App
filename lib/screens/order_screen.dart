import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class OrderScreen extends StatelessWidget {
  const OrderScreen({Key? key}) : super(key: key);
  static String routeName = '/orders';

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Orders'),
          bottom: TabBar(
            tabs: [
              Text('Pending Orders'),
              Text('Received Orders'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            Center(
              child: Container(
                width: double.infinity,
                height: double.infinity,
                  child: Lottie.asset(
                      'lotties/13892-earth-and-connections.json',
                      fit: BoxFit.fitWidth,
                  ),
              ),
            ),
            Center(
              child: Text('Work in progress'),
            ),
          ],
        ),
      ),
    );
  }
}

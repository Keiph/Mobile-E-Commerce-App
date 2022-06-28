import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

/// [OrderScreen] is not fully completed but this is roughly the design for the screen

class OrderScreen extends StatelessWidget {
  const OrderScreen({Key? key}) : super(key: key);
  static String routeName = '/orders';

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Orders'),
          bottom: const TabBar(
            tabs: [
              Text('Pending Orders'),
              Text('Received Orders'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            Center(
              child: SizedBox(
                width: double.infinity,
                height: double.infinity,
                child: Lottie.asset(
                  'lotties/13892-earth-and-connections.json',
                  fit: BoxFit.fitWidth,
                ),
              ),
            ),
            const Center(
              child: Text('Work in progress'),
            ),
          ],
        ),
      ),
    );
  }
}

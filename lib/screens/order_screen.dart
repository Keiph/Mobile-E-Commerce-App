import 'package:boogle_mobile/constants.dart';
import 'package:boogle_mobile/models/orders.dart';
import 'package:boogle_mobile/services/firestore_service.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:intl/intl.dart';


/// [OrderScreen] is not fully completed but this is roughly the design for the screen

class OrderScreen extends StatelessWidget {
  static String routeName = '/orders';

  @override
  Widget build(BuildContext context) {
    FirestoreService fsService = FirestoreService();
    return StreamBuilder<List<Orders>>(
        stream: fsService.getUsersOrders(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center (child: CircularProgressIndicator());
          }
          else{
            return Scaffold(
              appBar: AppBar(
                title: const Text('Orders'),
              ) ,
              body: ListView.separated(
                itemBuilder: (BuildContext context, int i) {
                  if(DateTime.now().isBefore(snapshot.data![i].deliveryDate)){
                    return ListTile(
                      leading: const CircleAvatar(child: Icon(Icons.delivery_dining, size: 30, color: Colors.white,),backgroundColor: Colors.grey,),
                      title: Text(snapshot.data![i].id, style: TextStyleConst.kSmallSemi,),
                      subtitle: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text('Purchased on: ' + DateFormat('dd/MM/yyyy').format(snapshot.data![i].purchasedBy)),
                          Text('Total Price: ' '\$${snapshot.data![i].amount.toStringAsFixed(2)}'),
                          Text('Total Items: ' '${snapshot.data![i].totalItem}'),
                          Text('To: ' + snapshot.data![i].address1)
                        ],
                      ),
                      trailing: Column(
                        children: [
                          const Text('Delivered By:'),
                          Text(DateFormat('dd/MM/yyyy').format(snapshot.data![i].deliveryDate)),
                        ],
                      ),
                      isThreeLine: true,
                      dense: true,
                    );
                  } else {
                    return ListTile(
                      leading: const CircleAvatar(child: Icon(Icons.done, size: 30, color: Colors.white,),backgroundColor: Colors.grey,),
                      title: Text(snapshot.data![i].id, style: TextStyleConst.kSmallSemi,),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Purchased on: ' + DateFormat('dd/MM/yyyy').format(snapshot.data![i].purchasedBy)),
                          Text('Total Price: ' '\$${snapshot.data![i].amount.toStringAsFixed(2)}'),
                          Text('Total Items: ' '${snapshot.data![i].totalItem}'),
                          Text('To: ' + snapshot.data![i].address1)
                        ],
                      ),
                      trailing: Column(
                        children: [
                          const Text('Delivered By:'),
                          Text(DateFormat('dd/MM/yyyy').format(snapshot.data![i].deliveryDate)),
                        ],
                      ),
                      isThreeLine: true,
                      dense: true,
                    );
                  }
                },
                separatorBuilder: (BuildContext context, int i) {
                  return const Divider( height: 3, color: Colors.blueGrey);
                },
                itemCount: snapshot.data!.length,
              ),
            );
          }
        }
    );
  }
}
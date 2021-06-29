import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_store/providers/orders.dart';

class PlacedOrders extends StatelessWidget {
  static const routeName = '/orders-placed';
  @override
  Widget build(BuildContext context) {
    final orderData = Provider.of<Order>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Orders'),
      ),
      body: ListView.builder(
        itemBuilder: (context, index) => Card(
          child: ListTile(
            leading: Text('\$${orderData.ordersList[index].total}'),
            title: Text(orderData.ordersList[index].dateTime.toString()),
            trailing: IconButton(
              icon: Icon(Icons.arrow_drop_down),
              onPressed: () => null,
            ),
          ),
        ),
        itemCount: orderData.ordersList.length,
      ),
    );
  }
}

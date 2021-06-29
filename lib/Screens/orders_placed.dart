import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_store/providers/orders.dart';

class PlacedOrders extends StatefulWidget {
  static const routeName = '/orders-placed';

  @override
  _PlacedOrdersState createState() => _PlacedOrdersState();
}

class _PlacedOrdersState extends State<PlacedOrders> {
  var expandMore = false;
  @override
  Widget build(BuildContext context) {
    final orderData = Provider.of<Order>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Orders'),
      ),
      body: ListView.builder(
        itemBuilder: (context, index) => Card(
          child: Column(
            children: [
              ListTile(
                title: Text('\$${orderData.ordersList[index].total}'),
                subtitle: Text(orderData.ordersList[index].dateTime
                    .toString()
                    .substring(0, 16)),
                trailing: IconButton(
                  icon: Icon(expandMore
                      ? Icons.arrow_drop_up_rounded
                      : Icons.arrow_drop_down_rounded),
                  onPressed: () {
                    setState(() {
                      expandMore = !expandMore;
                    });
                  },
                ),
              ),
              if (expandMore)
                Container(
                  height:
                      min(orderData.getOrderDetails(index).length * 22.5, 50),
                  child: ListView.builder(
                    itemBuilder: (ctx, i) => Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(orderData.getOrderDetails(index)[i].title),
                        Text('${orderData.getOrderDetails(index)[i].quantity}x')
                      ],
                    ),
                    itemCount: orderData.getOrderDetails(index).length,
                  ),
                ),
            ],
          ),
        ),
        itemCount: orderData.ordersList.length,
      ),
    );
  }
}

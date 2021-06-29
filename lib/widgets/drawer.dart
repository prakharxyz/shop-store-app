import 'package:flutter/material.dart';
import 'package:shop_store/Screens/orders_placed.dart';
import 'package:shop_store/providers/orders.dart';

class MainDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
            child: Center(
              child: Text(
                'Your store',
                style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.store),
            title: Text('Shop'),
            onTap: () => Navigator.of(context).pushReplacementNamed('/'),
          ),
          ListTile(
            leading: Icon(Icons.shopping_bag),
            title: Text('my orders'),
            onTap: () =>
                Navigator.of(context).pushNamed(PlacedOrders.routeName),
          ),
        ],
      ),
    );
  }
}

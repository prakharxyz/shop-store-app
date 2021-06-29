import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_store/Screens/Cart_overview.dart';
import 'package:shop_store/Screens/orders_placed.dart';
import 'package:shop_store/Screens/product_details.dart';
import 'package:shop_store/Screens/shop_overview.dart';
import 'package:shop_store/providers/cart.dart';
import 'package:shop_store/providers/orders.dart';
import 'package:shop_store/providers/products.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => Products(),
        ),
        ChangeNotifierProvider(
          create: (context) => Cart(),
        ),
        ChangeNotifierProvider(
          create: (context) => Order(),
        )
      ],
      child: MaterialApp(
        home: ShopOverview(),
        routes: {
          ProductDetails.routeName: (ctx) => ProductDetails(),
          CartOverview.routeName: (ctx) => CartOverview(),
          PlacedOrders.routeName: (ctx) => PlacedOrders(),
        },
      ),
    );
  }
}

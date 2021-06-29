import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_store/Screens/Cart_overview.dart';
import 'package:shop_store/Screens/orders_placed.dart';
import 'package:shop_store/providers/cart.dart';
import 'package:shop_store/widgets/badge.dart';
import 'package:shop_store/widgets/drawer.dart';
import 'package:shop_store/widgets/products_grid.dart';

class ShopOverview extends StatefulWidget {
  @override
  _ShopOverviewState createState() => _ShopOverviewState();
}

class _ShopOverviewState extends State<ShopOverview> {
  bool showFavOnly = false;
  @override
  Widget build(BuildContext context) {
    //provider must be set at highest widgets from where we wanna pass data to child, grandchild or supergrandchild ... widgets
    final cartItems = Provider.of<Cart>(context).cartList;

    return Scaffold(
      drawer: MainDrawer(),
      appBar: AppBar(
        title: Text('Shop overview'),
        actions: [
          IconButton(
              icon: Badge(
                  child: Icon(Icons.shopping_cart),
                  value: cartItems.length.toString()),
              onPressed: () =>
                  Navigator.of(context).pushNamed(CartOverview.routeName)),
          IconButton(
              icon: Icon(Icons.shopping_bag),
              onPressed: () =>
                  Navigator.of(context).pushNamed(PlacedOrders.routeName)),
          PopupMenuButton(
            itemBuilder: (ctx) => [
              PopupMenuItem(
                child: Text('only Favorites'),
                value: setFilter.favorites,
              ),
              PopupMenuItem(
                child: Text('all'),
                value: setFilter.all,
              )
            ],
            icon: Icon(Icons.more_vert),
            onSelected: (setFilter selectedValue) {
              setState(() {
                if (selectedValue == setFilter.favorites) {
                  showFavOnly = true;
                } else {
                  showFavOnly = false;
                }
              });
              //if enum is set to fav(by menu item) then set var showFavOnly to true or else false
            },
          ),
        ],
      ),
      body: ProductsGridList(showFavOnly),
      //pass showFavOnly to gridList to display list accordingly
    );
  }
}

enum setFilter { favorites, all }

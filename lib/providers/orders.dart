import 'package:shop_store/providers/cart.dart';

import 'package:flutter/material.dart';

class OrderModel {
  String id;
  double total;
  List<CartModel> cart;
  DateTime dateTime;

  OrderModel({this.id, this.cart, this.total, this.dateTime});
}

class Order with ChangeNotifier {
  List<OrderModel> _ordersList = [];

  List<OrderModel> get ordersList {
    return [..._ordersList];
  } //so that this class/provider can only be edited from inside this class & cant be edited from outside class

  void addOrder(List<CartModel> cL, double total) {
    _ordersList.insert(
        0,
        OrderModel(
            id: DateTime.now().toString().substring(6, 8),
            cart: cL,
            total: total,
            dateTime: DateTime.now()));

    notifyListeners();
  }

//we need to return a list of cart items when user calls this method on an orderList index
  List<CartModel> getOrderDetails(int i) {
    return _ordersList.elementAt(i).cart;
  }
}

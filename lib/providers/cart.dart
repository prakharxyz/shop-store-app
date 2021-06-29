import 'package:flutter/material.dart';

class CartModel {
  String id; //this id is different from product id
  String title;
  int quantity;
  double price;
  CartModel({this.id, this.title, this.price, this.quantity});
  double total() {
    return quantity * price;
  }
}

class Cart with ChangeNotifier {
  Map<String, CartModel> _cartMap =
      {}; //type map where key is product id and value is CartModel

  Map<String, CartModel> get cartMap {
    //copy of _cartList, getter
    return {..._cartMap};
  }

  void addToCart(String id, String title, double price) {
    //method to add to cart which takes product id,title,price as argument

    //if cartList already has id(as key) present then just update existing CartModel at key 'id' by incrementing quantity by 1
    if (_cartMap.containsKey(id)) {
      _cartMap.update(
        id,
        (existingModel) => CartModel(
            id: existingModel.id,
            title: existingModel.title,
            price: existingModel.price,
            quantity: existingModel.quantity + 1),
        //we keep id, title, price same as before but we add 1 to quantity
      );
    }
    //if cartList doesnt have that key already present, ie it is a new key(id) then it means we gotta add new CartModel to CartList
    else {
      _cartMap.putIfAbsent(
          //this func means insert value if key is absent
          id,
          () => CartModel(
              id: DateTime.now().toString().substring(6, 10),
              title: title,
              price: price,
              quantity: 1));
    }
    notifyListeners();
  }

  double get generateTotal {
    var total = 0.00;
    _cartMap.forEach((id, cartModel) {
      total += cartModel.price * cartModel.quantity;
    });
    return total;
  }

  List<CartModel> get cartList {
    return _cartMap.values.toList();
  }

  int get totalCartItems {
    int tot = 0;
    _cartMap.forEach((id, model) {
      tot += model.quantity;
    });
    return tot;
  }

  void removeItem(String id) {
    _cartMap.remove(id);
    notifyListeners();
  }

  void clearItems() {
    _cartMap = {};
    notifyListeners();
  }
}

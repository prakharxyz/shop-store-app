import 'package:flutter/material.dart';

class ProductModel with ChangeNotifier {
  final String id;
  final String title;
  final String description;
  final double price;
  final String imageUrl;
  bool isFavorite; //haven't set this final since we want this to be dynamic

  ProductModel(
      {this.id,
      this.title,
      this.price,
      this.imageUrl,
      this.description,
      this.isFavorite = false});

  void toggleFavorite() {
    isFavorite = !isFavorite;
    print('isFavorite $isFavorite');
    notifyListeners(); //to actually notify to the listeners that something is changed
  }
}

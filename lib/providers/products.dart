import 'package:flutter/material.dart';
import './models/product_model.dart';

class Products with ChangeNotifier {
  List<ProductModel> _productsList = [
    ProductModel(
      id: 'p1',
      title: 'Red Shirt',
      description: 'A red shirt - it is pretty red!',
      price: 29.99,
      imageUrl:
          'https://cdn.pixabay.com/photo/2016/10/02/22/17/red-t-shirt-1710578_1280.jpg',
    ),
    ProductModel(
      id: 'p2',
      title: 'Trousers',
      description: 'A nice pair of trousers.',
      price: 59.99,
      imageUrl:
          'https://upload.wikimedia.org/wikipedia/commons/thumb/e/e8/Trousers%2C_dress_%28AM_1960.022-8%29.jpg/512px-Trousers%2C_dress_%28AM_1960.022-8%29.jpg',
    ),
    ProductModel(
      id: 'p3',
      title: 'Yellow Scarf',
      description: 'Warm and cozy - exactly what you need for the winter.',
      price: 19.99,
      imageUrl:
          'https://live.staticflickr.com/4043/4438260868_cc79b3369d_z.jpg',
    ),
    ProductModel(
      id: 'p4',
      title: 'A Pan',
      description: 'Prepare any meal you want.',
      price: 49.99,
      imageUrl:
          'https://upload.wikimedia.org/wikipedia/commons/thumb/1/14/Cast-Iron-Pan.jpg/1024px-Cast-Iron-Pan.jpg',
    ),
  ];

//getter method to get list of all products
  List<ProductModel> get productsList {
    return [..._productsList];
  }

//getter method to get list of fav products
  List<ProductModel> get favProductsList {
    return _productsList.where((element) => element.isFavorite).toList();
    //returns a list of models where isfavourite is true
  }

  void addToList() {
    notifyListeners();
  }

  ProductModel findById(String id) {
    return productsList.firstWhere((element) => element.id == id);
    //returns productmodel where model id matches id passed in argument
  }
}

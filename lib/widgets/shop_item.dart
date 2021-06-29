import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../Screens/product_details.dart';
import '../providers/models/product_model.dart';
import '../providers/cart.dart';

class ShopItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final productItem = Provider.of<ProductModel>(context);
    final cartData = Provider.of<Cart>(context, listen: false);
    return ClipRRect(
      borderRadius: BorderRadius.all(Radius.circular(10)),
      child: GestureDetector(
        onTap: () => Navigator.of(context)
            .pushNamed(ProductDetails.routeName, arguments: productItem.id),
        child: GridTile(
          child: Image.network(productItem.imageUrl, fit: BoxFit.fill),
          footer: GridTileBar(
            backgroundColor: Colors.black38,
            title: Text(productItem.title),
            leading: IconButton(
              icon: Icon(!productItem.isFavorite
                  ? Icons.favorite_border
                  : Icons.favorite),
              onPressed: () => productItem.toggleFavorite(),
            ),
            trailing: IconButton(
              icon: Icon(Icons.shopping_cart),
              onPressed: () => cartData.addToCart(
                  productItem.id, productItem.title, productItem.price),
            ),
          ),
        ),
      ),
    );
  }
}

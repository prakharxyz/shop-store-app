import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/products.dart';
import './shop_item.dart';

class ProductsGridList extends StatelessWidget {
  final bool showFavOnly;
  ProductsGridList(this.showFavOnly);

  @override
  Widget build(BuildContext context) {
    //here we extract the data in provider & store it in  avariable to use in this class
    final productsData = Provider.of<Products>(context);
    final itemsList =
        showFavOnly ? productsData.favProductsList : productsData.productsList;

    return GridView.builder(
      padding: EdgeInsets.all(10),
      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
        childAspectRatio: 3 / 2,
        maxCrossAxisExtent: 200,
        mainAxisExtent: 200,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      itemBuilder: (context, index) {
        //here we set a contentProvider for product model bcoz we need to listen to changes in a single product(ie, whether its fav or not)
        //therefore unlike products provider where we needed only a single provider to provide with data of entire products list, we set it in main
        //here we need a productModel provider for every product(to listen to any changes in its model) so that we can listen & update changes in shop_item
        return ChangeNotifierProvider.value(
          //when cycling through a grid/list through builder use this alternative approach .value to avoid bugs
          value: itemsList[index],
          child: ShopItem(),
        );
      },
      itemCount: itemsList.length,
    );
  }
}

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_store/providers/products.dart';

class ProductDetails extends StatelessWidget {
  static const routeName = '/product-details';

  @override
  Widget build(BuildContext context) {
    final id = ModalRoute.of(context).settings.arguments as String;
    final pM = Provider.of<Products>(context,
            listen: false //just an optimisation which means whenever
            )
        .findById(id);
    print(id);
    print(pM.title);

    return Scaffold(
        appBar: AppBar(
          title: Text(pM.title),
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Image.network(
                pM.imageUrl,
                fit: BoxFit.fill,
                height: 250,
                width: double.infinity,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              margin: EdgeInsets.symmetric(
                horizontal: 12,
              ),
              alignment: Alignment.center,
              child: Text(pM.description),
            )
          ],
        ));
  }
}

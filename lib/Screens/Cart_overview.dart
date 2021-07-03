// import 'package:cashfree_pg/cashfree_pg.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
// import 'package:shop_store/orderId.dart';
import 'package:shop_store/providers/cart.dart';
import 'package:shop_store/providers/orders.dart';

class CartOverview extends StatefulWidget {
  static const routeName = '/cart-overview';

  @override
  _CartOverviewState createState() => _CartOverviewState();
}

class _CartOverviewState extends State<CartOverview> {
  Razorpay razorpay;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    razorpay = Razorpay();
    razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    print('payment successful');
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    print('payment error');
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    print('External wallet');
  }

  void openCheckout() {
    var options = {
      'key': 'rzp_test_SO4wFiwTvQksdT',
      'amount': 100,
      'name': 'Acme Corp.',
      'description': 'Fine T-Shirt',
      'prefill': {'contact': '8888888888', 'email': 'test@razorpay.com'}
    };
    try {
      razorpay.open(options);
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    final cartData = Provider.of<Cart>(context);
    final cartItems = cartData.cartList;
    final orderData = Provider.of<Order>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: Text('My Cart'),
      ),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            cartItems.isNotEmpty
                ? ListView.builder(
                    shrinkWrap: true,
                    itemCount: cartItems.length,
                    itemBuilder: (context, index) => Dismissible(
                      key: ValueKey(cartData.cartMap.keys.toList()[index]),
                      direction: DismissDirection.endToStart,
                      background: Container(
                        margin: EdgeInsets.symmetric(horizontal: 10),
                        alignment: Alignment.centerRight,
                        color: Colors.red,
                        child: Icon(Icons.delete),
                      ),
                      onDismissed: (direction) => cartData
                          .removeItem(cartData.cartMap.keys.toList()[index]),
                      child: Card(
                        margin: EdgeInsets.symmetric(horizontal: 4),
                        child: Padding(
                          padding: EdgeInsets.all(10),
                          child: ListTile(
                            title: Text(cartItems[index].title),
                            leading: CircleAvatar(
                              child: FittedBox(
                                  child: Text('\$${cartItems[index].price}')),
                            ),
                            trailing: Text(
                              '\$${cartItems[index].total()}',
                              style: TextStyle(
                                  fontWeight: FontWeight.w600, fontSize: 21),
                            ),
                            subtitle: Text('${cartItems[index].quantity}x'),
                          ),
                        ),
                      ),
                    ),
                  )
                : Center(
                    child: Text(
                    'you don\'t have any items in cart',
                    style: TextStyle(color: Colors.grey),
                  )),
            Card(
              elevation: 6,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Cart Total',
                        style: TextStyle(
                          fontSize: 22,
                        ),
                      ),
                      Row(
                        children: [
                          Chip(
                              label: Text(
                            '\$${cartData.generateTotal}',
                            style: TextStyle(fontSize: 20),
                          )),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            '${cartData.totalCartItems}x items',
                            style: TextStyle(
                                fontStyle: FontStyle.italic,
                                color: Colors.grey),
                          )
                        ],
                      ),
                    ],
                  ),
                  TextButton(
                      onPressed: () {
                        openCheckout();
                        orderData.addOrder(cartItems, cartData.generateTotal);
                        cartData.clearItems();
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text('Order placed successfully!')));
                      },
                      child: Text('ORDER NOW')),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

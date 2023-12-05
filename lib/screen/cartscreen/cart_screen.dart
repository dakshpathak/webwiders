import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:webwiders/services/shared_service/app_shared_preference.dart';

import '../../modal/product_modal.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  late List<Product> cartList;
  int amount = 0;

  @override
  void initState() {
    super.initState();
    cartList = AppPreference.getCartItems();
    for (var item in cartList) {
      log("Cart screen : ${item.title} : ${item.count}");
      amount += item.count.value * item.price!;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My cart"),
        backgroundColor: Colors.green,
        actions: [
          Text(
            "Rs. $amount",
            style: TextStyle(
                fontWeight: FontWeight.bold, fontSize: 20, height: 2.5),
          ),
          SizedBox(
            width: 20,
          ),
        ],
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 5,horizontal: 5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("${cartList.length} items"),
            SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                  itemExtent: 70,
                  itemCount: cartList.length,
                  itemBuilder: (context, index) => CartTile(product: cartList[index])),
            ),
          ],
        ),
      ),
    );
  }
}

class CartTile extends StatelessWidget {
  final Product product;

  const CartTile({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: Image.network(
          product.images![0],
          fit: BoxFit.fill,
          width: 70,
          height: 70,
        ),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Column(
                  children: [
                    Text(
                      "Quantity",
                      style: TextStyle(fontSize: 10),
                    ),
                    Text(
                      "Rs.${product.price}",
                      style: TextStyle(color: Colors.black),
                    )
                  ],
                ),
                SizedBox(
                  width: 15,
                ),
                Column(
                  children: [
                    Text(
                      "Per Unit",
                      style: TextStyle(fontSize: 10),
                    ),
                    Obx(
                      () => Text(
                        "${product.count.value}.00",
                        style: TextStyle(color: Colors.black),
                      ),
                    )
                  ],
                ),
                SizedBox(
                  width: 25,
                ),
                Column(
                  children: [
                    Text(
                      "Total",
                      style: TextStyle(fontSize: 10),
                    ),
                    Text(
                      "${product.count.value * product.price!}",
                      style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.bold),
                    )
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:number_inc_dec/number_inc_dec.dart';
import 'package:webwiders/modal/product_modal.dart';
import 'package:webwiders/screen/homescreen/controller.dart';
import 'package:webwiders/services/shared_service/app_shared_preference.dart';

import '../../api_util/api_service.dart';
import '../../widgets/product_tile.dart';
import '../cartscreen/cart_screen.dart';

class HomeScreen extends GetView<HomeScreenController> {
  HomeScreen({Key? key}) : super(key: key);

  TextEditingController textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Products"),
        backgroundColor: Colors.green,
      ),
      body: FutureBuilder(
          future: ApiService.getItems(),
          builder: (context, future) {
            if (future.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(
                  color: Colors.green,
                ),
              );
            }
            if (future.connectionState == ConnectionState.done) {
              if (future.data!.length > 0) {
                controller.mainList.value = future.data!;

                return ListView.builder(
                    itemCount: future.data!.length,
                    itemBuilder: (context, index) {
                      // return ProductTile(product: mainList[index],onAddClick: addItemToList(mainList[index], index),);
                      return Card(
                        margin: EdgeInsets.symmetric(vertical: 5),
                        child: Obx(
                          () => ListTile(
                            leading: Image.network(
                              controller.mainList[index].images![0],
                              fit: BoxFit.fill,
                              width: 70,
                              height: 70,
                            ),
                            title: Text(
                              "${controller.mainList[index].title}",
                              maxLines: 1,
                              style: TextStyle(overflow: TextOverflow.ellipsis),
                            ),
                            subtitle: Padding(
                              padding: const EdgeInsets.only(left: 70),
                              child: Row(
                                children: [
                                  Column(
                                    children: [
                                      Text(
                                        "Per unit",
                                        style: TextStyle(fontSize: 10),
                                      ),
                                      Text(
                                        "Rs.${controller.mainList[index].price}",
                                        style: TextStyle(color: Colors.black),
                                      )
                                    ],
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Column(
                                    children: [
                                      Text(
                                        "Total",
                                        style: TextStyle(fontSize: 10),
                                      ),
                                      Text(
                                        "Rs.${controller.mainList[index].price * controller.mainList[index].count.value}",
                                        style: TextStyle(color: Colors.black),
                                        maxLines: 1,
                                        overflow: TextOverflow.fade,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            trailing: controller.mainList[index].count == 0
                                ? ElevatedButton(
                                    onPressed: () {
                                      controller.addItemToList(
                                           index);
                                    },
                                    child: Text("Add"),
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.green,
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(20))))
                                : IncDecButton(
                                    index: index,
                                  ),
                          ),
                        ),
                      );
                    });
              }
            }
            return const Center(
                child: Center(
              child: Text("Something went wrong!"),
            ));
          }),
      bottomNavigationBar: InkWell(
        onTap: () {
          /// Here we will navigate to cart screen

          AppPreference.storeCartItems(controller.cartList);
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => CartScreen()));
        },
        child: Container(
          height: 60,
          color: Colors.yellow,
          child: Center(
            child: Text("VIEW CART"),
          ),
        ),
      ),
    );
  }
}

//NumberInputPrefabbed.squaredButtons(controller: textEditingController,  buttonArrangement: ButtonArrangement.incRightDecLeft)
class IncDecButton extends GetView<HomeScreenController> {
  /// you need to pas 2 function and one int variable
  final int index;

  const IncDecButton({Key? key, required this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        // IconButton(onPressed: (){}, icon: ),
        InkWell(onTap: (){
          controller.removeItemToList(index);
        },child: Icon(Icons.remove_circle)),
        SizedBox(
          width: 5,
        ),
        Obx(() => Text("${controller.mainList[index].count}")),
        SizedBox(
          width: 5,
        ),
        InkWell(
            onTap: () {
              controller.addItemToList(index);
            },
            child: Icon(Icons.add_circle)),

        // IconButton(onPressed: (){}, icon: ),
      ],
    );
  }
}

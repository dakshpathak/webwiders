import 'dart:developer';

import 'package:get/get.dart';
import 'package:webwiders/main.dart';

import '../../modal/product_modal.dart';

class HomeScreenController extends GetxController {
  late RxList<dynamic> mainList;
  late Rx<Product> product;
  Set<Product> cartList={};

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    mainList = [].obs;
  }

  addItemToList(int index) {
    mainList[index].count += 1;
    cartList.add(mainList[index]);
    for(var item in cartList)
      {
        log("${item.title} : ${item.count}");
      }
  }

  removeItemToList(int index) {

    if(mainList[index].count.value>0)
      {
        mainList[index].count -= 1;
        cartList.remove(mainList[index]);
      }
  }
//if i change a variable
}

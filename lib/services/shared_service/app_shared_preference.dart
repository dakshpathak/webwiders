import 'dart:convert';
import 'dart:developer';

import 'package:shared_preferences/shared_preferences.dart';

import '../../modal/product_modal.dart';

class AppPreference{
  static SharedPreferences? sharedPreferences ;

  static initializePreference()async{
    sharedPreferences = await SharedPreferences.getInstance();
  }

  static storeCartItems(Set<Product> cartList){

    List<Product> list = cartList.map((e){
      log("while mapping : ${e.title } : ${e.count.value}");
      return e;
    }).toList();
    //List<String> jsonStringList = myList.map((item) => json.encode(item.toJson())).toList();
    List<String>  finalList = list.map((e)=>json.encode(e.toJson())).toList();



    try {
      // var data = l;
      // log("After encode $data");
      sharedPreferences!.setStringList("cartList", finalList);
    } on Exception catch (e) {

      log("${e.toString()}");
    }

  }
  static List<Product> getCartItems(){
    List<Product> cartList=[];
    try {
      // List<dynamic> dynamicList = json.decode(sharedPreferences!.getString("cartList")!);
      // cartList = dynamicList.map((e){
      //   log("While decoding ${e}");
      //   return Product.fromPreference(e);
      // }).toList();

      // var response = sharedPreferences!.getString('cartList');
      // // return response;
      // log(response);

      List<String>? jsonStringList = sharedPreferences!.getStringList(
          "cartList");

      if (jsonStringList != null) {
        cartList = jsonStringList.map((jsonString) {
          Map<String, dynamic> jsonMap = json.decode(jsonString);
          return Product.fromJson(jsonMap);
        }).toList();
      }
    }on Exception catch (e) {
      log("${e.toString()}");
    }
    return cartList;
  }




}

import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:webwiders/modal/product_modal.dart';

import 'api_path.dart';

class ApiService {
  static Future<List<Product>> getItems() async {
    late http.Response response;
    List<Product> list=[];
    try {
      response = await http.get(Uri.parse(ApiPath.getItem));

      if (response.statusCode == 200) {
        /// status code =200 acknowledges response is ok
        Map<String, dynamic> data = json.decode(response.body);
        List<dynamic> productList = data['products'];
        list = parseResponse(productList);
      }
      else{
        log(name: "Api Service Response code ", "${response.statusCode}");
      }
    } on Exception catch (e) {
      log(name: "Api Service class", "${e.toString()}");
      log(name: "Api Service Response code ", "${response.statusCode}");
    }
    return list;
  }

  static List<Product> parseResponse(List<dynamic> list) {
    List<Product> productList = list.map((e) {
      return Product.fromJson(e);
    }).toList();
    log(name: "Product List", productList.toString());
    return productList;
  }
}

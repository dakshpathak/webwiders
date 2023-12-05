import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:webwiders/screen/homescreen/controller.dart';

import 'package:webwiders/screen/homescreen/home_screen.dart';
import 'package:webwiders/services/shared_service/app_shared_preference.dart';
void main()
{
  WidgetsFlutterBinding.ensureInitialized();
  AppPreference.initializePreference();
  Get.put(HomeScreenController());
  runApp(const ShoppingApp());
}
class ShoppingApp extends StatelessWidget {
  const ShoppingApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }
}

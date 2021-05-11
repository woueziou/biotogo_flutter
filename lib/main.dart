import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:ecom/screens/aboutuswidget.dart';
import 'package:ecom/screens/subProductWidget.dart';
import 'package:ecom/screens/homefragments/cartWidget.dart';
import 'package:ecom/screens/homefragments/categoryWidget.dart';
import 'package:ecom/screens/checkOutTabWidget.dart';
import 'package:ecom/screens/checkoutfragments/checkoutProfileWidget.dart';
import 'package:ecom/screens/homeWidget.dart';
import 'package:ecom/screens/introWidget.dart';
import 'package:ecom/screens/loginWidget.dart';
import 'package:ecom/screens/homeProductDetailWidget.dart';
import 'package:ecom/screens/orderhistoryWidget.dart';
import 'package:ecom/screens/updateWidget.dart';
import 'package:ecom/screens/userProfileWidget.dart';
import 'package:ecom/screens/splashWidget.dart';
import 'package:ecom/screens/wishListWidget.dart';
import 'package:shared_preferences/shared_preferences.dart';

//drawer UI Update ,set all strings in app for multilanguage .
SharedPreferences prefs;
void main() {
  WidgetsFlutterBinding.ensureInitialized();
  // SharedPreferences.setMockInitialValues({});

  return runApp(MaterialApp(
    initialRoute: '/',
    routes: {
      '/': (context) => SplashWidget(),
      '/intro': (context) => IntroScreen(),
      '/update': (context) => UpdateWidget(),
      '/login': (context) => LoginWidget(),
      '/home': (context) => HomeScreen(),
      '/subproduct': (context) => SubProductScreen(),
      '/homeproductdetail': (context) => HomeProdcutDetailScreen(),
      '/aboutus': (context) => AboutusScreen(),
      '/orders': (context) => OrdersScreen(),
      '/checkOutTab': (context) => CheckOutTabScreen(),
      '/wishlist': (context) => WishListScreen(),
      '/cart': (context) => CartScreen(false),
      '/userprofile': (context) => UserProfileScreen(),
    },
    debugShowCheckedModeBanner: false,
  ));
}

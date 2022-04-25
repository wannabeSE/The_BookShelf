import 'package:bookshelf/add_book.dart';

import 'package:bookshelf/cart_items.dart';
import 'package:bookshelf/create_account.dart';
import 'package:bookshelf/customer_signin.dart';
import 'package:bookshelf/customer_view.dart';
import 'package:bookshelf/order_confirmation.dart';
import 'package:flutter/material.dart';
import 'home.dart';
import 'seller_signin.dart';
import 'book_option.dart';
import 'cart_items.dart';
import 'package:firebase_core/firebase_core.dart';
import 'order_view.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    initialRoute: '/home',
    routes: {
      '/home':(context) => const Home(),
      '/seller_signin':(context) => const SellerSignIn(), 
      '/book_option':(context) => const SellerBook(),
      '/customer_view':((context) => const ViewPage()),
      '/customer_signin':((context) => const CustomerSignUp()),
      '/create_account':((context) => const CreateAccount()),
      '/order_confirmation':(context) => const Order(),
      '/add_book':(context) =>const AddBook(),
      '/cart_items':(context) =>const CartItems(),
      '/order_view':(context) => const Orders()
      
      
    },
  ));
}


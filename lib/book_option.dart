import 'package:flutter/material.dart';

class SellerBook extends StatefulWidget {
  const SellerBook({ Key? key }) : super(key: key);

  @override
  State<SellerBook> createState() => _SellerBookState();
}

class _SellerBookState extends State<SellerBook> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child:Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
          const SizedBox(height: 16),
          SizedBox(
            height: 100,
            width: 200,
          child:ElevatedButton(
          onPressed: (){
            Navigator.pushNamed(context, '/add_book');
          },
          child: const Text('Add New Book',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
          style: ElevatedButton.styleFrom(
            primary: Colors.blueAccent,
            onPrimary: Colors.white,
          ),
          ),
          ),
          const SizedBox(height: 16),
          SizedBox(
            height:100 ,
            width: 200,
          child:ElevatedButton(
            onPressed: (){
              Navigator.pushNamed(context,'/order_view');
            },
            child: const Text('Orders',style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
            style: ElevatedButton.styleFrom(
            primary: Colors.deepPurpleAccent,
            onPrimary: Colors.white,
            ),
          ),
          ),
          ],   
      ),
    ),
    );
  }
}
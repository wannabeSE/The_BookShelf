import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({ Key? key }) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text(
        'The Bookshelf',
        style: TextStyle(
        fontSize: 30,
        fontWeight: FontWeight.normal,
        color:Colors.white,
        fontFamily: 'Lobster'),
        ),
      
      backgroundColor: Colors.blueGrey,
      ),
      
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
            Navigator.pushNamed(context, '/seller_signin');
          },
          child: const Text('Seller',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
          style: ElevatedButton.styleFrom(
            primary: Colors.blueAccent,
            onPrimary: Colors.white,
          ),
          ),
          ),
          const SizedBox(height: 16),
          SizedBox(
            height: 100,
            width: 200,
          child:ElevatedButton(
            onPressed: (){
              Navigator.pushNamed(context, '/customer_signin');
            },
            child: const Text('Customer',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
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
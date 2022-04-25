import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Order extends StatefulWidget {
  const Order({ Key? key,  }) : super(key: key);
  
  @override
  State<Order> createState() => _OrderState();
}
final GlobalKey <FormState> _formkey= GlobalKey<FormState>();
final TextEditingController address = TextEditingController();
class _OrderState extends State<Order> {
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
      ),
        backgroundColor: Colors.white,
        body: Form(
          key:_formkey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
          children:[
             Padding(
              padding: const EdgeInsets.all(8),
              child: TextFormField(
                controller: address,
                decoration:const InputDecoration(
                  labelText: 'Please enter your address',
                ),           
              ),
            ),
            
            const SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                      onPressed: () {
                        confirm();
                        clear();
                        Fluttertoast.showToast(msg: 'Address was taken successfully and you will get your package within 3-5 business days');

                      },
                      child: const Text('Confirm')
                      ),
          ],
              ),
        ),
    );
  
  }
  void clear(){
    address.text='';
  }
  Future confirm()async{
    String adrs=address.text;
    final FirebaseAuth _auth = FirebaseAuth.instance;
    var currentUser = _auth.currentUser;
    var info=currentUser?.email;

    Map<String, dynamic> confirmedOrders={
      'address':adrs,
      'Ordered-by':info,
    };
    FirebaseFirestore.instance.collection('Confirmed-Orders').add(confirmedOrders);
  }
}
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';



class CartItems extends StatefulWidget {
  const CartItems({ Key? key }) : super(key: key);
  
  @override
  State<CartItems> createState() => _CartItemsState();
}

class _CartItemsState extends State<CartItems> {
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
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('users-cart-items').doc(FirebaseAuth.instance.currentUser!.email).collection('Ordered-items').snapshots(),
        builder: (BuildContext context, AsyncSnapshot <QuerySnapshot> snapshot){
          if(snapshot.hasError){
            return const Center(child: Text('Something went wrong'),);
          }
          return ListView.builder(
          itemCount:snapshot.data!.docs.length ,
          itemBuilder: (context,index){
            DocumentSnapshot snap=snapshot.data!.docs[index];
            return Card(
              elevation: 3,
              child: ListTile(
                leading: Text(snap['name'],style:const TextStyle(fontSize: 15),),
                title: Text('    ${snap['price']}' '  (${snap['quantity']} pcs)',style:const TextStyle(fontSize: 15),),
                trailing: GestureDetector(
                  child:const CircleAvatar(
                    child: Icon(Icons.remove_circle),
                    
                  ),
                  onTap: (){
                    FirebaseFirestore.instance.collection('users-cart-items').doc(FirebaseAuth.instance.currentUser!.email).collection('Ordered-items').doc(snap.id).delete();
                  },
                ),
              ),
              
            );
            
          }
          );

        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        icon:const Icon(Icons.check_circle,),
        backgroundColor: Colors.green,       
                onPressed: (){
                  Navigator.pushNamed(context,'/order_confirmation');
                  // Fluttertoast.showToast(msg: 'Your order has been confirmed. You will get your package withing 3-5 business days');
                }, 
                label:const Text('Confirm Order',style: TextStyle(fontSize: 17,fontFamily: 'Lobster'),),
      ),
      );
      
                      
  }
  
}
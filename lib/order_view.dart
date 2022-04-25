import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class Orders extends StatefulWidget {
  const Orders({ Key? key }) : super(key: key);

  @override
  State<Orders> createState() => _OrdersState();
}

class _OrdersState extends State<Orders> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text(
        'Order List',
        style: TextStyle(
        fontSize: 30,
        fontWeight: FontWeight.normal,
        color:Colors.white,
        fontFamily: 'Lobster'),
        ),
      centerTitle: true,
      backgroundColor: Colors.blueGrey,
      ),
      body:  StreamBuilder(
        stream: FirebaseFirestore.instance.collection('Confirmed-Orders').snapshots(),
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
                leading: Text(snap['address'],style:const TextStyle(fontSize: 15),),
                // title: Text('    ${snap['price']}' '  (${snap['quantity']} pcs)',style:const TextStyle(fontSize: 15),),
                trailing:Text(snap['Ordered-by']) ,
                 
              
              
            ),
            );
            
          }
          );

        },
      ),
    );
  }
}
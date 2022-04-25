import 'package:bookshelf/bookview.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Display extends StatefulWidget {
  final book;
  
  const Display({ Key? key, required this.book }) : super(key: key);

  @override
  State<Display> createState() => _DisplayState();
}

class _DisplayState extends State<Display> {
  int quantity=1;
  
  @override
  Widget build(BuildContext context) {
    Size size=MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(
            height: size.height,
            child:Stack(
              children: [
                Container(
                  margin: EdgeInsets.only(top:size.height*0.3),
                  height: 500,
                  decoration:const BoxDecoration(
                    color: Colors.white,
                  ),
                  child: Column(
                    children: [
                      const SizedBox(
                        height:150,
                      ),
                      SizedBox(
                        width: 500,
                        child:RichText(text: TextSpan(
                        children: [
                        TextSpan(
                          text: 'Description: ${widget.book['description']}',
                          style: Theme.of(context).
                          textTheme.
                          headline6?.
                          copyWith(color: Colors.black,
                        fontWeight: FontWeight.normal),
                         
                        ),
                            
                          ],
                        ),
                      ),
                      
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Row(
                      children: [
                        
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ElevatedButton(onPressed: (){
                            if(quantity>1){
                              setState(() {
                              quantity--;
                            });
                          }
                          }, 
                          child:const Icon(Icons.remove,color: Colors.black,),
                          style:  ButtonStyle(
                          shape: MaterialStateProperty.all(
                                 RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                                side: const BorderSide(color: Colors.black)
                                ),
                              ),
                              backgroundColor: MaterialStateProperty.all(Colors.white),
                          ),
                          ),
                        ),
                        Text(
                          ' $quantity'' Pcs  ',
                        style: const TextStyle(fontSize: 20,fontWeight: FontWeight.bold),
                        ),
                        ElevatedButton(onPressed: (){
                          setState(() {
                            quantity++;
                          });
                          
                        }, 
                        // child:Text('+',style: TextStyle(fontSize:35,color: Colors.black),),
                        child:const Icon(Icons.add,color: Colors.black,),
                        style:  ButtonStyle(
                          shape: MaterialStateProperty.all(
                                 RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                                side: const BorderSide(color: Colors.black)
                                )
                                
                              ),
                              backgroundColor: MaterialStateProperty.all(Colors.white),
                        ),
                        
                        ),
                      ],
                    ),
                      const SizedBox(
                        height: 30,
                      ),
                      SizedBox(
                        height: 50,
                        width: 200,
                        
                        child: ElevatedButton.icon(onPressed: (){
                          addToCart();
                        }, 
                        icon:const Icon(Icons.shopping_cart), 
                        label: const Text('Add to Cart',
                              style: TextStyle(fontSize: 20),
                        ),
                        
                        ),
                      ),
                      
                    ],
                  ),
                ),
                
                BookView(book: widget.book),
                
              ],
            ),
          ),
            
        ],
      ),
    );
  }

  Future addToCart() async {
    
    final FirebaseAuth _auth = FirebaseAuth.instance;
    var currentUser = _auth.currentUser;
    var info=currentUser?.email;
    CollectionReference _collectionRef =
        FirebaseFirestore.instance.collection("users-cart-items");
    _collectionRef
        .doc(currentUser!.email)
        .collection("Ordered-items")
        .doc()
        .set({
      "name": widget.book["name"],
      "price": widget.book["price"],
      "image": widget.book["image"],
      'quantity':quantity,
      'Ordered-by':info,
    
    }).then((value) => Fluttertoast.showToast(msg: 'This Book has been added to your Cart'));
    
    
  }
  
  
}


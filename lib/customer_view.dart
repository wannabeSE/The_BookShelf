import 'package:bookshelf/details_screen.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ViewPage extends StatefulWidget {
  const ViewPage({ Key? key }) : super(key: key);

  @override
  State<ViewPage> createState() => _ViewPageState();
}
const int k=0;
List books=[];
class _ViewPageState extends State<ViewPage> {

  fetchBooks()async{
    QuerySnapshot snap= await FirebaseFirestore.instance.collection('Books').get();
    setState(() {
      for( int i =0;i<snap.docs.length;i++){
        books.add(
          {
            'name':snap.docs[i]['name'],
            'image':snap.docs[i]['image'],
            'genre':snap.docs[i]['genre'],
            'description':snap.docs[i]['description'],
            'price':snap.docs[i]['price'],
            'quantity':snap.docs[i]['quantity'],
          }
        );
      }
    });
    return snap.docs;
  }
  @override
  void initState(){
    fetchBooks();
    super.initState();
  }
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
      centerTitle: true,
      backgroundColor: Colors.black,
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
        
        child: Column(
        children: [
         const SizedBox(
            height: 20,
          ),
          Expanded(
            child:GridView.builder(
              scrollDirection: Axis.vertical,
              itemCount: books.length,
              gridDelegate:const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 20,
                crossAxisSpacing: 10,
                childAspectRatio: 0.75,
                
                ),
              itemBuilder: (context,index){
              return GestureDetector(
                onTap: () => Navigator.push(context, MaterialPageRoute(builder: ((context) => DetailsScreen(book:books[index] ,)))),
                child: Card(
              
                  elevation: 4,
                  child: Column(
                    children: [
                      AspectRatio(
                        aspectRatio: 1,
                        child: Container(
                          color:Colors.white,
                          child: Image.network(books[index]['image'])
                          )
                        ),
                      Text('${books[index]['name']}'),
                      Text('Price: ${books[index]['price']}'),
                      Text('Quantity: ${books[index]['quantity']} pcs')
                      
                    ],
                  ),
                ),
              );
            }) ,
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              children: [
              FloatingActionButton.extended(
                icon:const Icon(Icons.shopping_cart),
                backgroundColor: Colors.pinkAccent,
                onPressed: (){
                  Navigator.pushNamed(context,'/cart_items');
                }, 
                label:const Text('Cart',style: TextStyle(fontSize: 17,fontFamily: 'Lobster'),),
                ),
            ],
            ),
          ),
        ],
      )
      ),
    );
  }
  
}
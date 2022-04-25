import 'package:bookshelf/display.dart';
import 'package:flutter/material.dart';

class DetailsScreen extends StatefulWidget {
  final book;

  const DetailsScreen({ Key? key,required this.book }) : super(key: key);

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title:Text(
        widget.book['name'],
        style: const TextStyle(
        fontSize: 30,
        fontWeight: FontWeight.normal,
        color:Colors.white,
        fontFamily: 'Lobster'),
        ),
        centerTitle: true,
        backgroundColor: Colors.blueGrey,
      ),
      backgroundColor: Colors.black,

      body:Display(book: widget.book,) 
          
    );
  }
}
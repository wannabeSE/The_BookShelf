import 'package:flutter/material.dart';
class BookView extends StatelessWidget {
  const BookView({
    Key? key,
    required this.book,
  }) : super(key: key);

  final book;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Text(product.genre,
            // style:const TextStyle(color: Colors.deepPurpleAccent),
            // ),
            
            Text('Genre: ${book['genre']}',
            style: Theme.of(context).
            textTheme.
            headline6?.
            copyWith(
              color:Colors.white,
              fontWeight: FontWeight.bold),
            ),
            // const SizedBox(
            //   height: 20,
            // ),
            Row(
              children: [
                RichText(text: TextSpan(
                  children: [
                    // const TextSpan( 
                    //   text: 'Price',
                      
                    // ),
                    TextSpan(
                      text: 'Price: ${book['price']}',
                      style: Theme.of(context).
                      textTheme.
                      headlineSmall?.
                      copyWith(color: Colors.white,
                    fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Image.network(
                    book['image'],
                    fit: BoxFit.fill,
                    ),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
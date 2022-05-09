import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttertoast/fluttertoast.dart';



class AddBook extends StatefulWidget {
  
  const AddBook({ Key? key, }) : super(key: key);
  
  @override
  State<AddBook> createState() => _AddBookState();
}
final _form= GlobalKey<FormState>();

CollectionReference _ref=FirebaseFirestore.instance.collection('Books');

final TextEditingController title =  TextEditingController();
final TextEditingController genre =  TextEditingController();
final TextEditingController description =  TextEditingController();
final TextEditingController price=  TextEditingController();
final TextEditingController picname=  TextEditingController();
final TextEditingController qty=  TextEditingController();
bool isLoading=false;
File? file;
UploadTask? task;
String? imageUrl;

class _AddBookState extends State<AddBook> {
  


  
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(title: const Text(
        'Add New Book',
        style: TextStyle(
        fontSize: 30,
        fontWeight: FontWeight.normal,
        color:Colors.black,
        fontFamily: 'Lobster'),
        ),
        backgroundColor: Colors.grey[700],
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _form,
          child: Column(
          children: [
            Padding(padding: const EdgeInsets.all(6),
            child: TextFormField(
              controller: title,
              validator: (value){
                if(value!.isEmpty){
                  return 'Please Enter book name';
                }else{
                  return null;
                }
              },
              
              decoration: const InputDecoration(
                labelText: 'Name of the Book',
              ),
            ),
            ),
             Padding(padding: const EdgeInsets.all(6),
            child: TextFormField(
              controller: genre,
              validator: ((value){
                if(value!.isEmpty){
                  return 'Please Enter genre';
                }else{
                  return null;
                }
              }),
              decoration: const InputDecoration(
                labelText: 'Genre of the Book',
              ),
            ),
            ),
             Padding(padding: const EdgeInsets.all(6),
            child: TextFormField(
              controller: description,
              validator: ((value){
                if(value!.isEmpty){
                  return 'Please Enter description';
                }else{
                  return null;
                }
              }),
              decoration: const InputDecoration(
                labelText: 'Description of the Book',
              ),
            ),
            ),
             Padding(padding: const EdgeInsets.all(6),
            child: TextFormField(
              controller: price,
              validator: ((value){
                if(value!.isEmpty){
                  return 'Please Enter price';
                }else{
                  return null;
                }
              }),
              decoration: const InputDecoration(
                labelText: 'Price of the Book',
              ),
            ),
            ),
            Padding(padding: const EdgeInsets.all(6),
            child: TextFormField(
              controller: qty,
              keyboardType: TextInputType.number,
              validator: ((value){
                if(value!.isEmpty){
                  return 'Please Enter quantity';
                }else{
                  return null;
                }
              }),
              decoration: const InputDecoration(
                labelText: 'Quantity',
              ),
            ),
            ),
            Padding(padding: const EdgeInsets.all(6),
            child: TextFormField(
              controller: picname,
              validator: ((value){
                if(value!.isEmpty){
                  return 'Please Enter name';
                }else{
                  return null;
                }
              }),
              decoration: const InputDecoration(
                labelText: 'Picture name',
              ),
            ),
            ),
            
              const SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Padding(
                  padding:  EdgeInsets.only(left: 90),
                  child: ElevatedButton(
                    
                    onPressed: (){
                      
                      pickImg();
                      
                      // Fluttertoast.showToast(msg: 'Image has been uploaded');
                    }, 
                    child: const Text('Select Photo')
                    ),
                ),
                  Text('        '),
                  SizedBox(
                    height: 40,
                    width: 80,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                      primary:Colors.green,
                      
                    ),
              onPressed: (){
                setState(() {
                    isLoading=true;
                });
                Future.delayed(Duration(seconds: 3),(){
                    setState(() {
                      isLoading=false;
                      Fluttertoast.showToast(msg: "Image has been successfully uploaded");
                    });
                });
                
              }, 
              child:isLoading? CircularProgressIndicator(color: Colors.white,): Text('Upload')
              ),
                  )
              ],
            ),
             
             
               const SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: (){
                
                saveData();
                clear();
                Fluttertoast.showToast(msg: 'Info submitted');
              }, 
              child: const Text('Submit')
              ),
          ],
          ),
        ),
      ),
    );
  }
  Future pickImg() async{
    var pickedImage = await ImagePicker().pickImage(
      source: ImageSource.gallery, 
      maxWidth: 1920,
      maxHeight: 1200,   
      imageQuality: 80); 
      uploadPhoto(pickedImage);
  }
  Future uploadPhoto (var img) async{    
  //upload and download url
  Reference ref = FirebaseStorage.instance.ref().child(picname.text);
  await ref.putFile(File(img!.path));
  
  imageUrl = await ref.getDownloadURL();
  
  }

  void clear(){

    title.text=description.text=genre.text=price.text=picname.text=qty.text='';  
  }
 
  Future saveData()async {
    String name=title.text;
    String gnr=genre.text;
    String desc =description.text;
    String prc=price.text+'Tk';
    String quantity=qty.text;


    
    
    Map<String, dynamic> books={
      'name':name,
      'genre':gnr,
      'description':desc,
      'price':prc,
      'quantity':quantity,
      'image':imageUrl,
      };
    _ref.add(books);
 

  }
}

// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttertoast/fluttertoast.dart';

class CreateAccount extends StatefulWidget {
  const CreateAccount({ Key? key }) : super(key: key);

  @override
  State<CreateAccount> createState() => _CreateAccountState();
}
final _formkey2= GlobalKey<FormState>();
// final _auth=FirebaseAuth.instance;
String p = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
CollectionReference ref = FirebaseFirestore.instance.collection('users');
final TextEditingController passwordController = TextEditingController();
final TextEditingController confirmpassController =  TextEditingController();
final TextEditingController name =  TextEditingController();
final TextEditingController emailController = TextEditingController();

RegExp regExp =RegExp(p);
String temp='';

class _CreateAccountState extends State<CreateAccount> {
  void validation(String email,String pass) async{
    final FormState? _form = _formkey2.currentState;
    if(_form!.validate()){
      try{
        await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: pass);
        Navigator.pushNamed(context, '/customer_signin');
        
        
      }on FirebaseAuthException catch(e){
        
        if (e.code == 'weak-password') {
         Fluttertoast.showToast(msg: 'Weak password');
          
        } 
        
      }catch (e){print(e);}
    }
    const CircularProgressIndicator();
  }
  bool observeText=true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(title: const Text(
        'Sign Up',
        style: TextStyle(
        fontSize: 30,
        fontWeight: FontWeight.normal,
        color:Colors.white,
        fontFamily: 'Lobster'),
        ),
      ),
        backgroundColor: Colors.white,
        body: Form(
          key: _formkey2,
          child: Column(
          children:[
            Padding(
              padding: const EdgeInsets.all(6),
              child: TextFormField(
                validator: ((value) {
                  if(value!.isEmpty){
                    return 'Please Enter Name';
                  }else{
                    return null;
                  }
                }),
                decoration:const InputDecoration(
                  labelText: 'Name',
                ),           
              ),
            ),
             Padding(
              padding: const EdgeInsets.all(6),
              child: TextFormField(
                controller: emailController,
                
                validator: (value){
                  if(value!.isEmpty){
                    return 'Please enter your E-mail';
                  }else if(!regExp.hasMatch(value)){
                    return 'E-mail is invalid';
                  }
                  return null;
                },
                onChanged:(value) {},
                decoration:const InputDecoration(
                  labelText: 'E-mail',
                ),           
              ),
            ),
            Padding(padding: const EdgeInsets.all(6),
            child: TextFormField(
              obscureText: observeText,
              controller: passwordController,
              validator: ((value) {
                if(value!.isEmpty){
                  return 'Please enter a password';
                }else if(value.length<8){
                  return 'The password is too short';
                }else{
                  temp=value;
                  return null;
                }
                
              }),
              onChanged: (value){},
                decoration: InputDecoration(
                  hintText: 'Password',
                  suffixIcon: GestureDetector(
                    onTap: () {
                      
                      setState(() {
                        observeText=!observeText;
                      });
                    },
                    child: Icon(
                      observeText==true?
                      Icons.visibility:
                      Icons.visibility_off,
                      color: Colors.black,),
                  ),
                ),  
              ),
            ),
            Padding(padding: const EdgeInsets.all(6),
            child: TextFormField(
              obscureText: observeText,
              validator: (value) {
                if(value!=temp){
                  return 'The password does not match';
                }
                return null;
              },
                decoration:InputDecoration(
                  hintText: 'Re-enter Password',
                  suffixIcon: GestureDetector(
                    onTap: () {
                      
                      setState(() {
                        observeText=!observeText;
                      });
                    },
                    child:  Icon(
                      observeText==true?
                      Icons.visibility:
                      Icons.visibility_off
                      ,color: Colors.black,
                      ),
                  ),
                ),  
              ),
            ),
          
             const SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                      onPressed: () {
                        if(emailController.text.isNotEmpty && passwordController.text.isNotEmpty)
                        {
                          validation(emailController.text,passwordController.text);
                          
                        }
                        
                      },
                      child: const Text('Sign Up')
                      ),
          ],      
              ),
        ),
    );
  }
}
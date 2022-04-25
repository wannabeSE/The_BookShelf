import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
class SellerSignIn extends StatefulWidget {
  const SellerSignIn({ Key? key }) : super(key: key);

  @override
  State<SellerSignIn> createState() => _SellerSignInState();
}
String s = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
RegExp regExp = RegExp(s);
bool observeText=true;
final GlobalKey <FormState> _formkey= GlobalKey<FormState>();
final TextEditingController emailController = TextEditingController();
final TextEditingController passwordController = TextEditingController();
class _SellerSignInState extends State<SellerSignIn> {
void validation(String email, String pass) async {
    final FormState? _form = _formkey.currentState;
    if(_form!.validate()){
      try{
        await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: pass);
        Navigator.pushNamed(context,'/book_option');
      }
      on FirebaseAuthException catch(e){        
        if (e.code == 'user-not-found') {
          Fluttertoast.showToast(msg: 'User not Found');            
        }
                
         else if (e.code == 'wrong-password') {
          
          Fluttertoast.showToast(msg: 'Invalid Password');
        }
      }
    }
    
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text(
        'Seller Sign In',
        style: TextStyle(
        fontSize: 30,
        fontWeight: FontWeight.normal,
        color:Colors.black,
        fontFamily: 'Lobster'),
        ),
        backgroundColor: Colors.grey[700],
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
                controller: emailController,
                validator: (value){
                    if(value!.isEmpty){
                      return 'Please enter your E-mail';
                    }else if(!regExp.hasMatch(value)){
                      return 'E-mail is invalid';
                    }
                    return null;
                  },
                  
                decoration:const InputDecoration(
                  labelText: 'E-mail',
                ),           
              ),
            ),
            Padding(padding: const EdgeInsets.all(8),
            child: TextFormField(
              obscureText: observeText,
              controller: passwordController,
              validator: ((value) {
                  if(value!.isEmpty){
                    return 'Please Enter Your Password';
                  }else{
                    return null;
                  }
                }),
                decoration:InputDecoration(
                  
                  labelText: 'Password',
                  suffixIcon: GestureDetector(
                        onTap: () {
                         
                          setState(() {
                            observeText=! observeText;
                          });
                        },
                        child: Icon(
                          observeText==true?
                           Icons.visibility:
                           Icons.visibility_off,
                           color: Colors.black,
                          ),
                      ),
                ),  
              ),
            ),
             const SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                      onPressed: ()async {
                        if(emailController.text.isNotEmpty && passwordController.text.isNotEmpty){
                          validation(emailController.text,passwordController.text);
                        }
                      },
                      child: const Text('Sign In')
                      ),
          ],      
              ),
        ),
    );
  }
}
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:fluttertoast/fluttertoast.dart';

class CustomerSignUp extends StatefulWidget {
  const CustomerSignUp({ Key? key }) : super(key: key);

  @override
  State<CustomerSignUp> createState() => _CustomerSignUpState();
}
final GlobalKey <FormState> _formkey= GlobalKey<FormState>();
//final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
String p = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
bool observeText=true;
final TextEditingController emailController = TextEditingController();
final TextEditingController passwordController = TextEditingController();
RegExp regExp = RegExp(p);

class _CustomerSignUpState extends State<CustomerSignUp> {
  void validation(String email, String pass) async {
    final FormState? _form = _formkey.currentState;
    if(_form!.validate()){
      try{
        await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: pass);
        Navigator.pushNamed(context, '/customer_view');
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
        'Sign In',
        style: TextStyle(
        fontSize: 30,
        fontWeight: FontWeight.normal,
        color:Colors.white,
        fontFamily: 'Lobster'),
        ),
      ),
        backgroundColor: Colors.white,
        body: Form(
          key: _formkey,
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
                decoration: InputDecoration(
                  labelText: 'Password',
                  suffixIcon: GestureDetector(
                      onTap: () {
                        FocusScope.of(context).unfocus();
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
                        validation(emailController.text, passwordController.text);
                        
                        }
                      },
                      child: const Text('Log In')
                      ),
            const SizedBox(height: 20),
            const Text("Don't have an account?",style: TextStyle(fontSize: 15),),
            const SizedBox(height: 10),
             ElevatedButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/create_account');
                        
                      },
                      child: const Text('Create An Account'),
                      ),
          ],      
              ),
        ),
    );
  }
}
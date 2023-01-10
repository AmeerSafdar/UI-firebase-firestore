// ignore_for_file: use_build_context_synchronously, curly_braces_in_flow_control_structures

import 'package:flutter/material.dart';
import 'package:task2/resources/firebase_methods.dart';
import 'package:task2/screens/main_screen.dart';
import 'package:task2/screens/signup_screen.dart';
import 'package:task2/widgets/input_fields.dart';
import 'package:task2/widgets/snackbar.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailControler = TextEditingController();
  final TextEditingController _passwordControler = TextEditingController();
final _form=GlobalKey<FormState>();
    String pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
 @override
  void dispose() {
    super.dispose();
    _emailControler.dispose();
    _passwordControler.dispose();
  }
   loginUser() async {
   if (_form.currentState!.validate()) {
     
    String result = await FirebaseMethods().userSigIn( _emailControler.text, _passwordControler.text).then((value) {
                                   return value;
                                });
    if (result == 'successful') {
     Navigator.pushReplacement(context, 
                MaterialPageRoute(builder: (context)=>const HomeScreen()));
    }
    else{
      showSnackbar(context, result.toString().replaceAll('-', ' '));
    }
    }
  }

  @override
  Widget build(BuildContext context) {
    RegExp regex = RegExp(pattern);
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(14.0),
            child: Form(
              key: _form,
              child: Column(
                children: [
                  TextFieldWidget(
                    hintText: 'Email',
                    textEditingController: _emailControler,
                   validator: ((value) {
                          if (!regex.hasMatch(value!))
                             return 'Enter Valid Email'; 
                          else
                           return null;
                          
                  }
                   )
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  
                  TextFieldWidget(
                    hintText: 'Password',
                    textEditingController: _passwordControler,
                    validator: ((value) {
                          if (value.toString().length<6)
                             
                              return 'password must contain 6 letters';
                            
                           else
                              return null;
                              
                  }
                  )
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  
                  ElevatedButton(
                     
                    onPressed:loginUser, 
                    child: const Text('Login')
                    ),
            
                    Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextButton
                      (
                        onPressed: (){

                          Navigator.push(context, MaterialPageRoute(builder: (context)=>const SignUpScreen()));
                        }, child:const Text('Sign Up?'))
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
// ignore_for_file: use_build_context_synchronously, curly_braces_in_flow_control_structures

import 'package:flutter/material.dart';
import 'package:task2/resources/firebase_methods.dart';
import 'package:task2/screens/main_screen.dart';
import 'package:task2/widgets/input_fields.dart';
import 'package:task2/widgets/snackbar.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _emailControler = TextEditingController();
  final TextEditingController _firstNameControler = TextEditingController();
  final TextEditingController _lastNameControler = TextEditingController();
  final TextEditingController _passwordControler = TextEditingController();
final _form=GlobalKey<FormState>();

    String pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';


  accountCreation() async {
    if (_form.currentState!.validate()) {
    String result = await FirebaseMethods().signUpUser(
      _emailControler.text,
      _firstNameControler.text,
      _lastNameControler.text,
      _passwordControler.text
    );
    if (result == 'successful') {
       Navigator.pushReplacement(context, MaterialPageRoute(
        builder: (context) => const HomeScreen()));
    } 
    else{
      showSnackbar(context, result.toString().replaceAll('-', ' '));
    }
    }
  }

  @override
  void dispose() {
    super.dispose();
    _emailControler.dispose();
    _passwordControler.dispose();
    _firstNameControler.dispose();
    _lastNameControler.dispose();
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
                    hintText: 'First Name',
                    textEditingController: _firstNameControler,
                    validator: ((value) {
                        if (value!.isNotEmpty) 
                          return null;
                        else
                          return 'Name must contain a value';
                      }),
                  ),
                  TextFieldWidget(
                    hintText: 'Last',
                    textEditingController: _lastNameControler,
                    validator: ((value) {
                        if (value!.isNotEmpty) 
                          return null;
                        else
                          return 'Name must contain a value';
                        
                      }),
                  ),
                  TextFieldWidget(
                    hintText: 'Email',
                    textEditingController: _emailControler,
                   validator: ((value) {
                          if (!regex.hasMatch(value!))
                            return 'Enter Valid Email';
                          else
                            return null;
              })),
                    
                    
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
                    onPressed: accountCreation, 
                    child:const Text('Signup')
                    ),
                    
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
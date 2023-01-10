// ignore_for_file: use_build_context_synchronously

import 'package:task2/providers/user_provider.dart';
import 'package:task2/widgets/text_field.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task2/utils/extension_validator.dart';

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
  final _formGlobalKey=GlobalKey<FormState>();

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
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(14.0),
            child: Form(
              key: _formGlobalKey,
              child: Column(
                children: [
                  TextFieldWidget(
                    hintText: 'First Name',
                    textEditingController: _firstNameControler,
                    validator:(v) => '$v'.isRequired() ? null : '*First Name required' 
                    
                  ),
                  TextFieldWidget(
                    hintText: 'Last',
                    textEditingController: _lastNameControler,
                    validator: (v) => '$v'.isRequired() ? null : '*Last Name required'
                   
                  ),
                  TextFieldWidget(
                    hintText: 'Email',
                    textEditingController: _emailControler,
                   validator: (v)=> '$v'.isEmail() ? null : '*Enter correct Email' 
                   
                  ),
                    
                    
                  TextFieldWidget(
                    hintText: 'Password',
                    textEditingController: _passwordControler,
                    validator: (v) => '$v'.lengthRange() ? null : '*Password must be between 6-12 characters'
                  ),
            
                  const SizedBox(
                    height: 15,
                  ),

                  Consumer<UserProvider>(
                    builder: (context, val, child){
                      return ElevatedButton(
                    onPressed:(){
                      if (_formGlobalKey.currentState!.validate()){
                        val.setUserData(_firstNameControler.text, _lastNameControler.text, _emailControler.text, _passwordControler.text,context);

                       } }, 
                    child:val.onLoading == false ? Text('Signup') : CircularProgressIndicator(color: Colors.white,)
                    );

                    } )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
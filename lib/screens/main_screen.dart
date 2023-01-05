// ignore_for_file: non_constant_identifier_names, prefer_typing_uninitialized_variables

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:task2/resources/firebase_methods.dart';
import 'package:task2/widgets/input_fields.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _emailControler=TextEditingController();
  final TextEditingController _firstNameControler=TextEditingController();
  final TextEditingController _lastNameControler=TextEditingController();
   bool read_only =true;
   String? firsName =' ', lastName= ' ', email=' ';
   
   final _form=GlobalKey<FormState>();
 String pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

@override
  void initState() {
    super.initState();
    getUser();
  }

 getUser() async {
    DocumentSnapshot snap = await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();
    setState(() {
     firsName= (snap.data() as Map<String, dynamic>)['firstName'];
     lastName= (snap.data() as Map<String, dynamic>)['lastName'];
     email= (snap.data() as Map<String, dynamic>)['email'];
 });

  }

    editableTextField() {
    setState(() {
      read_only=false;
    });

  }
   non_editableTextField() {
    setState(() {
      read_only=true;
    });

  }
    void _submit(String email , String firsName, String lastName,String uid) async{
    if (_form.currentState!.validate()) {
      FirebaseMethods().updateUserData(email,firsName,lastName,uid);
      getUser();
      non_editableTextField();
     
    }
  }
  @override
  Widget build(BuildContext context) {
    
    RegExp regex = RegExp(pattern);
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
             actions: [
          TextButton(
            onPressed: (){
               showDialog(
                context: context,
                builder: (ctx) => AlertDialog(
                  title: const Text("Logout"),
                  content: const Text("Do you want to logout?"),
                  actions: <Widget>[
                    TextButton(
                      onPressed: () async{
                        FirebaseMethods().signOut(context);
                        },
                      child: Container(
                        color: Colors.blue,
                        padding: const EdgeInsets.all(14),
                        child: const Text("Yes",style: TextStyle(color: Colors.white),),
                      ),
                    ),
                     TextButton(
                      onPressed: () {
                        Navigator.of(ctx).pop();
                      },
                      child: Container(
                        color: Colors.white,
                        padding: const EdgeInsets.all(14),
                        child: const Text("No"),
                      ),
                    ),
                  ],
                ),
              );
          }, child: const Text(
            'Logout',style: TextStyle(color: Colors.white),
          ))
        ],
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(14.0),
            child: Form(
              key: _form,
              child: Column(
                children: [
                TextFieldWidget(
                  read_only: read_only,
                  hintText: 'First Name', 
                  textEditingController: _firstNameControler..text=firsName ??'', 
                  validator: ((value) {
                            if (value!.isNotEmpty) {
                              return null;
                            }
                            else{
                              return 'Name must contain a value';
                            }
                          }),),
                    
                  TextFieldWidget(
                  hintText: 'Last Name', 
                  read_only: read_only,
                  textEditingController: _lastNameControler..text=lastName??'', 
                  validator: ((value) {
                            if (value!.isNotEmpty) {
                              return null;
                            }
                            else{
                              return 'Name must contain a value';
                            }
                          }),),
                            TextFieldWidget(
                              read_only: read_only,
                        hintText: 'Email',
                        textEditingController: _emailControler..text=email ??'',
                       validator: ((value) {
                              if (!regex.hasMatch(value!))
                                { 
                                  return 'Enter Valid Email';
                                  }
                              else{
                               return null;
                              }
                  }
                       )
                      ),
            
                   const SizedBox(
                  height: 10,
                ),
            
                Visibility(
                  visible: read_only,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextButton(
                    onPressed: (){
                      editableTextField();
                    }, 
                    child: const Text('Edit')),
                  ),
                ),
            
                  const SizedBox(
                  height: 10,
                ),
            
                Visibility(
                  visible: !read_only,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextButton(
                    onPressed: (){
                      _submit(
                        _emailControler.text,
                       _firstNameControler.text, _lastNameControler.text,
                        FirebaseMethods().userId!.uid
                       );
                    }, 
                    child: const Text('Done')),
                  ),
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
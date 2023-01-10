
import 'package:flutter/material.dart';
String pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';


  void buildErrorSnackbar(BuildContext context,String meessage) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('$meessage'.replaceAll('-', ' ')),
      ),
    );
  }

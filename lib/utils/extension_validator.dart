
import 'package:task2/utils/const.dart';

extension Validate on String{

  bool isEmail(){
    return RegExp(pattern)
        .hasMatch(this);
  }
 bool isRequired(){
    return this.isNotEmpty ;
  }
   bool lengthRange(){
    return this.length>5 && this.length<12  ;
  }

}
/**
 * Created by Sylva Lee
 */

import 'package:fluttertoast/fluttertoast.dart';
abstract class ToastUtil{
  static showToast(String message){
    if(message != null)
      Fluttertoast.showToast(msg: message, toastLength: Toast.LENGTH_SHORT);
  }
}
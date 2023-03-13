import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ToastShow {
  static Message(String message) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        fontSize: 17,
        textColor: Colors.white,
        backgroundColor: Colors.amber);
  }
}

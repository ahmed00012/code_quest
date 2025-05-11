import 'package:flutter/material.dart';


extension Validator on String {

  String? noValidate() {
    return null;
  }

  String? validateEmpty(BuildContext context,{String? message}) {
    if (trim().isEmpty) {
      return message ??  'Please fill this field';
    }
    return null;
  }
  bool hasDigits() {
    return RegExp(r'\d').hasMatch(this);
  }

  String? validateName(BuildContext context,{String? message}) {
    // static final validCharacters = RegExp(r'^[a-zA-Z0-9&%=]+$');
    if (trim().isEmpty) {
      return message ??  "Please fill this field";
    } else if (length < 3 || length > 20) {
      return message ?? "Please enter username correctly";
    }
    else  if (RegExp(r'[0-9!@#%^&*(),.?":{}|<>]').hasMatch(this)) {
      return message ?? "Please enter username correctly";
    }
    
    return null;
  }

  

  String? validatePhoneNumber(BuildContext context,{String? message}) {
    if (trim().isEmpty) {
      return 'Please enter your phone number';
    } else if (this.length < 10 || this.length > 20) {
      return 'Please enter valid phone number';
    }
    return null;
  }
  String? validatePrice(BuildContext context,{String? message}) {
    if (trim().isEmpty) {
      return message ??  'Please fill this field';
    }
   else if(double.tryParse(this)==null){
      return message ??  'Please fill this field';
    }
    else if(double.parse(this) <= 0){
      return message ??  'Enter Valid Amount';
    }
    return null;
  }
  String? validateWithoutSpecialChar(BuildContext context,{String? message}) {
    if (trim().isEmpty) {
      return message ??  'Please fill this field';
    }
    if (!RegExp(r'^[a-zA-Z0-9]+$').hasMatch(this)) {
      return message ??  'Please fill this field';
    }
    return null;
  }



  String? validatePassword(BuildContext context,{String? message}) {
    if (trim().isEmpty) {
      return message ??  'Please fill this field';
    }
    // else if (!RegExp(r'^(?=.*?[A-Z])(?=.*?[0-9]).{8,}$')
    //     .hasMatch(this)) {
    //   return message ?? 'Enter at least 8 characters containing numbers and capital letters';
    // }
    else if (this.length < 6 || this.length > 16) {
      return message ?? 'Password must be between 6 and 16 characters';
    }
    return null;
  }

  String? validateEmail(BuildContext context,{String? message}) {
    if (trim().isEmpty) {
      return message ??  'Please fill this field';
    } else if (!RegExp(
        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(this)) {
      return message ?? "Please enter a valid email";
    }
    return null;
  }
  String? validatePasswordConfirm(BuildContext context,{required String pass, String? message}) {
    if (trim().isEmpty) {
      return message ??  'Please fill this field';
    } else if (this != pass) {
      return message ?? "Please enter the password identical";
    }
    return null;
  }

  String? validateEmailORNull(BuildContext context,{String? message}) {
    String p = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regExp = RegExp(p);
    if (trim().isNotEmpty) {
      // if (!RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
      if (!regExp.hasMatch(this)) {
        return message ?? "Please enter a valid email";
      }
    }
    return null;
  }



  String? validateDateTime(BuildContext context,{String? message,bool isOPtional=false}) {
    if (trim().isEmpty&&isOPtional) {
      return null;
    }
    if (trim().isEmpty) {
      return message ??  'Please fill this field';
    }
    print(DateTime.now());
    if(DateTime.tryParse(this)==null){
      return message ??'Enter the date correctly';
    }
    return null;
  }
}





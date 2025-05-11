import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'color_manager.dart';

TextStyle _getTextStyle(double fontSize, FontWeight fontWeight, Color color,
    {TextDecoration? textDecoration}) {
  return TextStyle(
    color: color,
    decoration: textDecoration,
    decorationThickness: 2,
    fontSize: fontSize,
    fontWeight: fontWeight,
    // overflow: TextOverflow.ellipsis,
  );
}

//regular style
TextStyle getRegularStyle(
    {double fontSize = 16, Color color = ColorManager.textColor,TextDecoration? textDecoration}) {
  return _getTextStyle(fontSize, FontWeight.normal, color,textDecoration: textDecoration);
}

//medium style
TextStyle getMediumStyle(
    {double fontSize = 16, Color color = ColorManager.textColor,TextDecoration? textDecoration,
      FontWeight fontWeight = FontWeight.w500}) {
  return _getTextStyle(fontSize, fontWeight, color);
}

//light style
TextStyle getLightStyle(
    {double fontSize = 16, Color color = ColorManager.textColor,TextDecoration? textDecoration}) {
  return _getTextStyle(fontSize, FontWeight.w400, color,textDecoration: textDecoration);
}

//bold style
TextStyle getBoldStyle(
    {double fontSize = 16, Color color = ColorManager.textColor,TextDecoration? textDecoration}) {
  return _getTextStyle(fontSize, FontWeight.bold, color,textDecoration: textDecoration);
}

//Black style
TextStyle getBlackStyle(
    {double fontSize = 16, Color color = ColorManager.textColor,TextDecoration? textDecoration}) {
  return _getTextStyle(fontSize, FontWeight.normal, color,textDecoration: textDecoration);
}

//semiBold style
TextStyle getSemiBoldStyle(
    {double fontSize = 16, Color color = ColorManager.textColor,TextDecoration? textDecoration}) {
  return _getTextStyle(fontSize, FontWeight.w500, color,textDecoration: textDecoration);
}

//textField hint style
TextStyle getHintStyle(
    {double fontSize = 14, Color color = ColorManager.inActive}) {
  return _getTextStyle(fontSize, FontWeight.w400, color);
}

//textField error style
TextStyle getErrorTextStyle(
    {double fontSize = 15, Color color = ColorManager.danger}) {
  return _getTextStyle(fontSize, FontWeight.normal, color);
}

//app bar text title style
TextStyle getAppBarTitleStyle(
    {double fontSize = 24,
    Color color = ColorManager.textHeaderColor}) {
  return _getTextStyle(fontSize, FontWeight.normal, color);
}

//regular style
TextStyle getReceiptStyle(
    {double fontSize = 16,
    Color color = ColorManager.textColor,
    FontWeight fontWeight = FontWeight.normal}) {
  return _getTextStyle(fontSize, fontWeight, color);
}

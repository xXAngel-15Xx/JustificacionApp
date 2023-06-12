import 'package:flutter/material.dart';

// Colors
const blue = Color(0xFF0249fe);
const gray = Color(0xFF6A7799);
const black = Color(0xFF000D54);
const white = Color(0xFFffffff);
const purple = Color(0xFF6750A4);

// Texts
TextStyle hedding1() {
  return const TextStyle(
    color: black,
    fontSize: 48.0,
    fontWeight: FontWeight.bold
  );
}

// Inputs
InputDecoration inputWithBorder(String textLabel, {IconData? iconData}) {
  return InputDecoration(
    label: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        if(iconData != null)
        Icon(iconData, color: gray,),
        if(iconData != null)
        const SizedBox(width: 10.0,),
        Text(textLabel, style: const TextStyle(color: gray),)
      ],
    ),
    border: const OutlineInputBorder(),
    focusColor: blue,
    fillColor: gray,
  );
}

// Bottons
ButtonStyle btnPurple() {
  return ElevatedButton.styleFrom(
    backgroundColor: purple,
    foregroundColor: white,
    padding: const EdgeInsets.symmetric(vertical: 16.0),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(5.0)
    )
  );
}
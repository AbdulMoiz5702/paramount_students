import 'package:flutter/material.dart';


Widget customContainer({
  required  double radius,
  required  double padding,
  required Widget child,
  required Color color,


}){
  return Container(
    margin: EdgeInsets.only(left: 8),
    padding: EdgeInsets.all(padding),
  decoration: BoxDecoration(
  borderRadius: BorderRadius.circular(radius),
      color: color
  ),
child: child,
  );
}
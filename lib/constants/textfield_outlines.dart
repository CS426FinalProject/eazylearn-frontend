import 'package:final_cs426/constants/color.dart';
import 'package:flutter/material.dart';

OutlineInputBorder outline = OutlineInputBorder(
  borderRadius: BorderRadius.circular(25.0),
  borderSide: BorderSide(color: Colors.black, width: 1.5),
);

OutlineInputBorder outlineBlue = OutlineInputBorder(
  borderRadius: BorderRadius.circular(25.0),
  borderSide: BorderSide(color: primaryColor, width: 1.5),
);

OutlineInputBorder errorOutline = OutlineInputBorder(
  borderRadius: BorderRadius.circular(25.0),
  borderSide: BorderSide(color: Colors.red, width: 1.5),
);

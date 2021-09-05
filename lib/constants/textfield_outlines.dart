import 'package:final_cs426/constants/color.dart';
import 'package:final_cs426/constants/colors.dart';
import 'package:flutter/material.dart';

OutlineInputBorder outline = OutlineInputBorder(
  borderRadius: BorderRadius.circular(20.0),
  borderSide: BorderSide(color: kEzLearnBlack, width: 2),
);

OutlineInputBorder outlineBlue = OutlineInputBorder(
  borderRadius: BorderRadius.circular(20.0),
  borderSide: BorderSide(color: kEzLearnBlue600, width: 2),
);

OutlineInputBorder errorOutline = OutlineInputBorder(
  borderRadius: BorderRadius.circular(20.0),
  borderSide: BorderSide(color: kEzLearnErrorRed, width: 2),
);

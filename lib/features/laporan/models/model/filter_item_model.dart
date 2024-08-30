import 'package:flutter/material.dart';

class FilterItem {
  final String text;
  final Color color;
  bool isSelected;

  FilterItem(this.text, this.color, {this.isSelected = false});
}

import 'package:flutter/material.dart';
import 'package:mobileapp_roadreport/dependency_injection.dart';
import 'package:mobileapp_roadreport/my_app.dart';

void main() {
  runApp(const MyApp());
  DependencyInjection.init();
}

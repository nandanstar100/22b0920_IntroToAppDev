import 'package:flutter/material.dart';
import './pages/home.dart';
import './pages/loading.dart';
import './pages/expense.dart';

void main() => runApp(MaterialApp(
  initialRoute: '/home',
  routes: {
    '/': (context) => Loading(),
    '/home': (context) => Home()
  }
));
import 'package:flutter/material.dart';

class Category {

  late String name;
  late int total = 0;
  late Map<String, int> expenses = {};

  Category(this.name); //constructor

  void addItem(String expenseName, int amount){ // to add an expense
    expenses[expenseName] = amount;
  }

  void calculateTotal(){
    total = 0;
    List<String> expenseNames = expenses.keys.toList();
    for(int i = 0; i < expenses.length; i++) {
      total += expenses[expenseNames[i]]!;
    }
  }

}
import 'package:flutter/material.dart';
import '../classes/category.dart';

class Expenses extends StatefulWidget {

  final Category instance;
  final Function() updateTotalCallback;

  Expenses({required this.instance, required this.updateTotalCallback});

  @override
  _ExpenseState createState() => _ExpenseState();
}

class _ExpenseState extends State<Expenses> {

  TextEditingController expenseNameController = TextEditingController();
  TextEditingController expenseValueController = TextEditingController();

  void _addExpense() {
    String expenseName = expenseNameController.text;
    int expenseValue = int.tryParse(expenseValueController.text) ?? 0;

    // Add the expense to the Category instance
    widget.instance.addItem(expenseName, expenseValue);

    // Clear the text fields
    expenseNameController.clear();
    expenseValueController.clear();

    // Call the callback function to update the total
    widget.updateTotalCallback();
  }

  @override
  void initState() {
    super.initState();
    // Category instance = widget.instance;
    // instance.addItem('For me', 1000);
    // Map expenses = instance.expenses;
  }

  Widget build(BuildContext context) {
    Category instance = widget.instance;
    // instance.addItem('For me', 1000);
    // instance.calculateTotal();
    Map expenses = instance.expenses;
    return Scaffold(
      backgroundColor: Colors.redAccent,
      appBar: AppBar(
        backgroundColor: Colors.orangeAccent,
        title: Text(
          'Budget Tracker',
          style: TextStyle(
            fontSize: 30.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(0.0, 60.0, 0.0, 0.0),
         child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.blueGrey,
                  border: Border.all(
                    color: Colors.black,
                    width: 1.0,
                  ),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                padding: EdgeInsets.all(10.0),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: TextField(
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: '${instance.name} :',
                          contentPadding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
                        ),
                        style: TextStyle(
                          fontSize: 30.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Text(
                      '${instance.total}',
                      style: TextStyle(
                        fontSize: 30.0,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            Expanded(
              child: ListView.builder(
                itemCount: expenses.length,
                itemBuilder: (context, index) {
                  String key = expenses.keys.elementAt(index);
                  int value = expenses[key]!;

                  return Padding(
                    padding: const EdgeInsets.fromLTRB(40.0, 10.0, 40.0, 10.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.blueGrey,
                        border: Border.all(
                          color: Colors.pinkAccent,
                          width: 1.0,
                        ),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      padding: EdgeInsets.all(10.0),
                    child: Row(
                      children: <Widget>[
                      Expanded(
                        child: TextField(
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: '${key} :',
                          contentPadding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
                        ),
                        style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                        ),
                        ),
                      ),
                      Text(
                        '${value}',
                        style: TextStyle(
                          fontSize: 20.0,
                        ),
                      ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              // Remove the expense when the delete icon is tapped
                              expenses.remove(key);
                              instance.calculateTotal();
                              widget.updateTotalCallback();
                            });
                          },
                          child: Icon(Icons.delete),
                        ),
                    ],
                  ),
                  ),
                );
                }
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text('New Item'),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(
                      controller: expenseNameController,
                      decoration: InputDecoration(labelText: 'Item_Name'),
                    ),
                    SizedBox(height: 20),
                    TextField(
                      controller: expenseValueController,
                      decoration: InputDecoration(labelText: 'Value'),
                      keyboardType: TextInputType.number,
                    ),
                  ],
                ),
                actions: <Widget>[
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text('Cancel'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      // Save the entered values here
                      String expenseName = expenseNameController.text;
                      int expenseValue = int.tryParse(expenseValueController.text) ?? 0;

                      // Clear the text fields
                      expenseNameController.clear();
                      expenseValueController.clear();

                      // You can now use the entered values as needed
                      instance.addItem('$expenseName', expenseValue);
                      //print(instance.expenses);
                      instance.calculateTotal();
                      widget.updateTotalCallback();
                      // print('Expense Name: $expenseName, Expense Value: $expenseValue');

                      // Close the dialog
                      Navigator.of(context).pop(instance);

                      // Refresh the page to update the expense list
                      setState(() {});
                    },
                    child: Text('Add'),
                  ),
                ],
              );
            },
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:week2_submission/pages/expense.dart';
import '../classes/category.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  void removeCategory(int index) {
    setState(() {
      if (categories.length > index) {
        categories.removeAt(index);
      }
    });
  }

  void addCategory() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        TextEditingController categoryNameController = TextEditingController();

        return AlertDialog(
          title: Text('Add_Category'),
          content: TextField(
            controller: categoryNameController,
            decoration: InputDecoration(labelText: 'Category_Name'),
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
                // Add the new category to the list and close the dialog
                String categoryName = categoryNameController.text;
                setState(() {
                  categories.add(Category(categoryName));
                });
                Navigator.of(context).pop();
              },
              child: Text('Add'),
            ),
          ],
        );
      },
    );
  }

  int Total = 0;

  List<Category> categories = [
    Category('Salary'),
    Category('Loan'),
    Category('Tax'),
    Category('groceries'),
    Category('Household_items'),
  ];

  void updateTotal() {
    setState(() {
      Total = 0;
      for (var category in categories) {
        category.calculateTotal();
        Total += category.total;
      }
    });
  }

  @override
  void initState() {
    super.initState();
  }

  Widget build(BuildContext context) {

    setState(() {
      ListView.builder(
        itemCount: categories.length,
        itemBuilder: (context, index) {
        }
      );
    });

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

            const CircleAvatar(
              radius: 50,
              backgroundImage: AssetImage(
                  'assets/profile.jpeg'),
            ),

            const Text(
              'Welcome Back',
              style: TextStyle(fontSize: 50),
            ),
            const SizedBox(height: 16),
            // ElevatedButton(
            //   onPressed: () {
            //     Navigator.pushReplacementNamed(context, '/expenses');
            //   },
            //   child: Text('Total'),
            // ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
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
                          hintText: 'Total :',
                          contentPadding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
                        ),
                        style: TextStyle(
                          fontSize: 30.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Text(
                      '${Total}',
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
                itemCount: categories.length,
                itemBuilder: (context, index) {
                  categories[index].calculateTotal();
                  return GestureDetector(
                    onTap: () async {
                      // Navigate to the Expenses page and wait for the result
                      Category updatedCategory = await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Expenses(
                              instance: categories[index],
                            updateTotalCallback: updateTotal,
                          ),
                        ),
                      );

                      // Check if the result is not null (i.e., a change was made in Expenses page)
                      if (updatedCategory != null) {
                        // Update the categories list with the updated category
                        updateTotal();

                        // Recalculate the total after updating
                        Total = 0;
                        for (var category in categories) {
                          category.calculateTotal();
                          Total += category.total;
                        }
                      }
                    },
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(40.0, 10.0, 40.0, 10.0),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(
                            color: Colors.pinkAccent,
                            width: 1.0,
                          ),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        padding: EdgeInsets.all(10.0),
                        child: Row(
                          children: <Widget>[
                            IconButton(
                              icon: Icon(Icons.delete),
                              onPressed: () {
                                // Call the removeCategory method with the current index
                                removeCategory(index);
                                updateTotal();
                              },
                            ),
                            Expanded(
                              child: TextField(
                                readOnly: true, // Prevents editing the text
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: '${categories[index].name} :',
                                  contentPadding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
                                ),
                                style: TextStyle(
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Text(
                              '${categories[index].total}',
                              style: TextStyle(
                                fontSize: 20.0,
                              ),
                            ),
                            Icon(Icons.add_circle_outline),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: addCategory,
        child: Icon(Icons.add),
      ),
    );
  }
}
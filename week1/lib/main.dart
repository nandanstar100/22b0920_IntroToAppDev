import 'package:flutter/material.dart';
void main() {
  runApp(CounterApp());
}

class CounterApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CounterApp',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: CounterPage(),
    );
  }
}

class CounterPage extends StatefulWidget {
  @override
  _CounterPageState createState() => _CounterPageState();
}

class _CounterPageState extends State<CounterPage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }
  void _decrementCounter(){
    setState(() {
      _counter--;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: Text('Counter App',style: TextStyle(fontSize: 40,),),
        backgroundColor: Colors.black,

      ),
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Counter Value:',
              style: TextStyle(fontSize: 80),
            ),
            Text(
              '$_counter',
              style: TextStyle(fontSize: 80, fontWeight: FontWeight.bold, ),
            ),
          ],
        ),
      ),
      floatingActionButton:Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(onPressed: _incrementCounter,tooltip: 'Increment',child: Icon(Icons.add,color: Colors.red,),backgroundColor: Colors.black,),
        FloatingActionButton(
          onPressed: _decrementCounter,
          tooltip: 'Decrement',
          child: Icon(Icons.remove,color: Colors.red,),
        backgroundColor: Colors.black,)

        ],
      )
      );

  }
}
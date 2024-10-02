import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Simple Form',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Simple Form'),
        ),
        body: FoodDeliveryForm(),
      ),
    );
  }
}

class FoodDeliveryForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
        onPressed: () {
          print('Form submitted');
        },
        child: Text('Submit'),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:food_delivery/view/on_boarding/on_boarding_view.dart';

void main() {
  runApp(SignupApp());
}

class SignupApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Signup',
      theme: ThemeData(
        primaryColor: Colors.orange, // Set primary color to orange
      ),
      home: SignupPage(),
      routes: {
        '/home': (context) => OnBoardingView(), // Define route for onboarding page
      },
    );
  }
}

class SignupPage extends StatelessWidget {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _mobileController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Signup Page'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Image.asset(
              'assets/img/app_logo.png', // Replace 'assets/logo.png' with your logo path
              width: 150,
              height: 150,
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: _nameController,
              decoration: InputDecoration(
                labelText: 'Name',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                labelText: 'Email',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: _mobileController,
              keyboardType: TextInputType.phone,
              decoration: InputDecoration(
                labelText: 'Mobile Number',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: _passwordController,
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Password',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                _signup(context);
              },
              child: Text('Signup'),
            ),
          ],
        ),
      ),
    );
  }

  void _signup(BuildContext context) {
    String name = _nameController.text;
    String email = _emailController.text;
    String mobile = _mobileController.text;
    String password = _passwordController.text;

    // Here you can implement your signup logic
    // For simplicity, we'll just print the entered values
    print('Name: $name');
    print('Email: $email');
    print('Mobile: $mobile');
    print('Password: $password');

    // You can navigate to the next page after successful signup
    Navigator.pushReplacementNamed(context, '/home');
  }
}

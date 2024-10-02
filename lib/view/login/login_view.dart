import 'package:flutter/material.dart';
import 'package:food_delivery/view/on_boarding/on_boarding_view.dart';
import 'package:food_delivery/view/login/admin_view.dart';

void main() {
  runApp(LoginApp());
}

class LoginApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Login Demo',
      theme: ThemeData(
        primaryColor: Colors.orange, // Set primary color to orange
      ),
      home: LoginPage(),
      routes: {
        '/home': (context) => OnBoardingView(), // Define route for onboarding page
        '/admin': (context) => AdminView(), // Define route for admin page
      },
    );
  }
}

class LoginPage extends StatelessWidget {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login Page'),
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
              controller: _usernameController,
              decoration: InputDecoration(
                labelText: 'Username',
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
                _login(context);
              },
              child: Text('Login'),
            ),
          ],
        ),
      ),
    );
  }

  void _login(BuildContext context) {
    // Check login credentials
    String username = _usernameController.text.trim();
    String password = _passwordController.text.trim();

    // Check if credentials match for admin
    if (username == 'admin@gmail.com' && password == 'admin7') {
      // Navigate to the admin page
      Navigator.pushReplacementNamed(context, '/admin');
      return;
    }

    // Check if credentials match for other users
    if ((username == 'jesica7@gmail.com' && password == 'jesica7') ||
        (username == 'shruti@gmail.com' && password == 'shruti7') ||
        (username == 'priya@gmail.com' && password == 'priya7') ||
        (username == 'simran@gmail.com' && password == 'simran7')) {
      // Navigate to the onboarding page for other users
      Navigator.pushReplacementNamed(context, '/home');
      return;
    }

    // Show invalid alert if credentials don't match
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Invalid Credentials'),
          content: Text('Please enter valid username and password.'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }
}

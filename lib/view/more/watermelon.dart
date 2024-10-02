import 'package:flutter/material.dart';

class WatermelonPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Watermelon Lemonade'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/watermelon-lemonade.jpg',
              width: 200,
              height: 200,
              fit: BoxFit.cover,
            ),
            SizedBox(height: 20),
            Text(
              'Ingredients',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Text(
              '1/4 cup (2 ounces) fresh-squeezed lemon juice\n'
                  '1/2 cup (4 ounces) fresh watermelon puree, strained through a coarse strainer to remove seeds\n'
                  '3 tablespoons (1 1/2 ounces) simple syrup*\n'
                  '3/4 cup (6 ounces) cold water',
              style: TextStyle(
                fontSize: 16,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

class AdminView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Admin Dashboard'),
      ),
      body: ListView.builder(
        itemCount: 5, // Assuming there are 5 stocks
        itemBuilder: (context, index) {
          return StockCard(
            stockNumber: index + 1,
            food: _generateRandomFood(),
            deliverer: _generateRandomDeliverer(),
            moreInformation: 'Tap for More Information',
          );
        },
      ),
    );
  }

  String _generateRandomFood() {
    List<String> foodItems = [
      'Biryani',
      'Butter Chicken',
      'Paneer Tikka',
      'Masala Dosa',
      'Pani Puri',
      'Samosa',
      'Chole Bhature',
      'Idli Sambhar',
      'Tandoori Chicken',
      'Vada Pav',
    ];
    return foodItems[DateTime.now().millisecondsSinceEpoch % foodItems.length];
  }

  String _generateRandomDeliverer() {
    List<String> deliverers = [
      'Rajesh Kumar',
      'Suresh Singh',
      'Amit Patel',
      'Anjali Gupta',
      'Priya Sharma',
      'Vijay Kumar',
      'Deepak Tiwari',
      'Neha Singh',
      'Sandeep Yadav',
      'Ankit Sharma',
    ];
    return deliverers[DateTime.now().millisecondsSinceEpoch % deliverers.length];
  }
}

class StockCard extends StatelessWidget {
  final int stockNumber;
  final String food;
  final String deliverer;
  final String moreInformation;

  StockCard({
    required this.stockNumber,
    required this.food,
    required this.deliverer,
    required this.moreInformation,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(8.0),
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Stock Number: $stockNumber',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8.0),
            Text('Food: $food'),
            Text('Deliverer: $deliverer'),
            GestureDetector(
              onTap: () {
                // Handle tapping for more information
                _showMoreInformation(context);
              },
              child: Text(
                moreInformation,
                style: TextStyle(
                  color: Colors.blue,
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showMoreInformation(BuildContext context) {
    // Replace this with your logic to show more information
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('More Information'),
          content: Text('Additional details about the stock.'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Close'),
            ),
          ],
        );
      },
    );
  }
}

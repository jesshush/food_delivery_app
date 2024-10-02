import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:webview_flutter/webview_flutter.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: RecipeSelectionPage(recipes: []),
  ));
}

class RecipeSelectionPage extends StatefulWidget {
  const RecipeSelectionPage({Key? key, required List<String> recipes}) : super(key: key);

  @override
  _RecipeSelectionPageState createState() => _RecipeSelectionPageState();
}

class _RecipeSelectionPageState extends State<RecipeSelectionPage> {
  List<String> recipes = [
    'Watermelon Lemonade',
    'Pink Lemonade',
    'DIY Sour Mix',
  ];

  String? selectedRecipe;
  String? recipeUrl;

  Future<void> fetchRecipe() async {
    final response = await http.get(Uri.parse('https://www.themealdb.com/api/json/v1/1/random.php'));
    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      final recipe = jsonData['meals'][0];
      setState(() {
        recipeUrl = recipe['strSource']; // Adjust this according to the API response structure
      });
    } else {
      throw Exception('Failed to fetch recipe');
    }
  }

  Future<void> postRecipe() async {
    if (selectedRecipe != null) {
      final response = await http.post(
        Uri.parse('https://www.example.com/postRecipe'),
        body: json.encode({"selectedRecipe": selectedRecipe}),
        headers: {'Content-Type': 'application/json'},
      );
      if (response.statusCode == 200) {
        // Handle success
      } else {
        throw Exception('Failed to post recipe');
      }
    } else {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Error'),
            content: Text('Please select a recipe before viewing'),
            actions: [
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

  void onViewRecipePressed() {
    switch (selectedRecipe) {
      case 'Watermelon Lemonade':
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => WatermelonPage()),
        );
        break;
      case 'Pink Lemonade':
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => PinkLemonadePage()),
        );
        break;
      case 'DIY Sour Mix':
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => DiySourMixPage()),
        );
        break;
      default:
        fetchRecipe();
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('View Recipe from TheMealdb'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: recipes.length,
              itemBuilder: (context, index) {
                final recipe = recipes[index];
                return ListTile(
                  title: Text(recipe),
                  leading: Radio<String>(
                    value: recipe,
                    groupValue: selectedRecipe,
                    onChanged: (value) {
                      setState(() {
                        selectedRecipe = value;
                      });
                    },
                  ),
                );
              },
            ),
          ),
          ElevatedButton(
            onPressed: () {
              onViewRecipePressed();
              postRecipe(); // Call post method when viewing recipe
            },
            child: Text('View the Recipe'),
          ),
        ],
      ),
    );
  }
}










class WatermelonPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Watermelon Lemonade'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [

          SizedBox(height: 20),
          Text(
            'Ingredients\n'
                '1/4 cup (2 ounces) fresh-squeezed lemon juice\n'
                '1/2 cup (4 ounces) fresh watermelon puree, strained through a coarse strainer to remove seeds\n'
                '3 tablespoons (1 1/2 ounces) simple syrup*\n'
                '3/4 cup (6 ounces) cold water',
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

class PinkLemonadePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pink Lemonade'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'assets/img/pink-lemonade1.jpg',
            width: 200,
            height: 200,
          ),
          SizedBox(height: 20),
          Text(
            ' 4 Ingredients\n'
                '3 cups cold water\n'
                '1/4 cup plus 1 tablespoon granulated sugar, divided\n'
                '1 cup (about 5 ounces) fresh raspberries,\n'
                'blackberries or sliced strawberries\n'
                '1 cup lemon juice (from 4 to 6 lemons, depending,\n'
                'on size and juicer efficiency)\n',
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}


















class DiySourMixPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('DIY Sour Mix'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'assets/img/diy-sour-image.jpg',
            width: 200,
            height: 200,
          ),
          SizedBox(height: 20),
          Text(
            'Ingredients\n'
                '1 cup (200g) sugar\n'
                '1 cup (8 ounces) water\n'
                '1 cup (8 ounces) freshly squeezed lemon juice\n'
                '1/2 cup (4 ounces) freshly squeezed lime juice',
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

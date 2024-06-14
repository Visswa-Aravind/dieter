import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:dieter/fapi/constant_function.dart';

import '../auth.dart';
import 'nutrient_data.dart';

class FoodView extends StatefulWidget {
  const FoodView({Key? key}) : super(key: key);

  @override
  _FoodViewState createState() => _FoodViewState();
}

class _FoodViewState extends State<FoodView> {
  Future<List<Map<String, dynamic>>>? recipeFuture;
  final TextEditingController _searchController = TextEditingController();
  final Map<int, TextEditingController> _weightControllers = {};
  final User? user = Auth().currentUser;

  @override
  void initState() {
    super.initState();
    recipeFuture =
        ConstantFunction.getResponse("chicken"); // Default search term
  }

  void _searchRecipes() {
    setState(() {
      recipeFuture = ConstantFunction.getResponse(_searchController.text);
      _weightControllers
          .clear(); // Clear previous controllers when new search is performed
    });
  }

  void _calculateNutrition(Map<String, dynamic> recipe, int index) async {
    final enteredWeight = double.tryParse(_weightControllers[index]!.text);
    if (enteredWeight != null) {
      final originalWeight = recipe['totalWeight'];
      final calories = ((recipe['calories'] / originalWeight) * enteredWeight)
          .toStringAsFixed(2);
      final protein =
          ((recipe['totalNutrients']['PROCNT']['quantity'] / originalWeight) *
                  enteredWeight)
              .toStringAsFixed(2);
      final fat =
          ((recipe['totalNutrients']['FAT']['quantity'] / originalWeight) *
                  enteredWeight)
              .toStringAsFixed(2);
      final carbs =
          ((recipe['totalNutrients']['CHOCDF']['quantity'] / originalWeight) *
                  enteredWeight)
              .toStringAsFixed(2);
      final fiber =
          ((recipe['totalNutrients']['FIBTG']['quantity'] / originalWeight) *
                  enteredWeight)
              .toStringAsFixed(2);
      final sugar =
          ((recipe['totalNutrients']['SUGAR']['quantity'] / originalWeight) *
                  enteredWeight)
              .toStringAsFixed(2);
      final sodium =
          ((recipe['totalNutrients']['NA']['quantity'] / originalWeight) *
                  enteredWeight)
              .toStringAsFixed(2);

      // Store the calculated values in Firebase Firestore
      final userUid = user?.uid;
      final userRef =
          FirebaseFirestore.instance.collection('Personals').doc(userUid);
      final mealTrackerRef = userRef.collection('Mealtracker');

      try {
        await mealTrackerRef.add({
          'recipeName': recipe['label'] ?? 'Unknown Recipe',
          'calories': calories,
          'protein': protein,
          'fat': fat,
          'carbs': carbs,
          'fiber': fiber,
          'sugar': sugar,
          'sodium': sodium,
          'timestamp': FieldValue.serverTimestamp(),
        });

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
                'Calculated Values Saved:\nCalories: $calories\nProtein: $protein g\nFat: $fat g\nCarbs: $carbs g\nFiber: $fiber g\nSugar: $sugar g\nSodium: $sodium g'),
            duration: Duration(seconds: 5),
          ),
        );
      } catch (error) {
        print('Error saving calculated values: $error');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content:
                Text('Error saving calculated values. Please try again later.'),
            duration: Duration(seconds: 5),
          ),
        );
      }
    }
  }

  String _formatNutrientValue(dynamic value) {
    return value != null
        ? value.toStringAsFixed(2)
        : 'N/A'; // Format the value to two decimal places
  }

  void _showNutrientsDialog(Map<String, dynamic> recipe) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(recipe['label'] ?? 'No Title'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Calories: ${_formatNutrientValue(recipe['calories'])}'),
              Text(
                  'Protein: ${_formatNutrientValue(recipe['totalNutrients']['PROCNT']['quantity'])}g'),
              Text(
                  'Fat: ${_formatNutrientValue(recipe['totalNutrients']['FAT']['quantity'])}g'),
              Text(
                  'Carbs: ${_formatNutrientValue(recipe['totalNutrients']['CHOCDF']['quantity'])}g'),
              Text(
                  'Fiber: ${_formatNutrientValue(recipe['totalNutrients']['FIBTG']['quantity'])}g'),
              Text(
                  'Sugar: ${_formatNutrientValue(recipe['totalNutrients']['SUGAR']['quantity'])}g'),
              Text(
                  'Sodium: ${_formatNutrientValue(recipe['totalNutrients']['NA']['quantity'])}g'),
              Text('Weight: ${_formatNutrientValue(recipe['totalWeight'])}g'),
            ],
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Close'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Recipes'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SavedDataPage()),
              );
            },
            icon: Icon(Icons.arrow_circle_right),
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _searchController,
                    decoration: InputDecoration(
                      hintText: 'Search for recipes',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.search),
                  onPressed: _searchRecipes,
                ),
              ],
            ),
          ),
          Expanded(
            child: FutureBuilder<List<Map<String, dynamic>>>(
              future: recipeFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return Center(child: Text('No recipes found'));
                } else {
                  return ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      final recipe = snapshot.data![index];
                      _weightControllers[index] ??=
                          TextEditingController(); // Initialize controller if not already

                      return Card(
                        margin: const EdgeInsets.all(8.0),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: ListTile(
                                      leading: recipe['image'] != null
                                          ? Image.network(
                                              recipe['image'],
                                              width: 50,
                                              height: 50,
                                              fit: BoxFit.cover,
                                            )
                                          : null,
                                      title:
                                          Text(recipe['label'] ?? 'No Title'),
                                    ),
                                  ),
                                  Container(
                                    width: 150,
                                    height: 40,
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: TextField(
                                            controller:
                                                _weightControllers[index],
                                            decoration: InputDecoration(
                                              labelText: 'Weight (g)',
                                              border: OutlineInputBorder(),
                                            ),
                                            keyboardType: TextInputType.number,
                                          ),
                                        ),
                                        IconButton(
                                          icon: Icon(Icons.add),
                                          onPressed: () => _calculateNutrition(
                                              recipe, index),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              ElevatedButton(
                                onPressed: () => _showNutrientsDialog(recipe),
                                child: Text('Show Nutrients'),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}

import 'dart:convert';
import 'package:http/http.dart' as http;

class RecipeFunction {
  static Future<List<Map<String, dynamic>>> getRespon(
      String findrecipe, String filter) async {
    String id = 'a5f8e5f6';
    String key = 'bd0682b03769c566127c7559c6eb617a';
    String healthFilter = '';

    // Set the health filter based on the selected filter
    switch (filter) {
      case 'Vegetarian':
        healthFilter = '&health=vegetarian';
        break;
      case 'Gluten-Free':
        healthFilter = '&health=gluten-free';
        break;
      case 'Vegan':
        healthFilter = '&health=vegan';
        break;
      case 'Low Carb':
        healthFilter = '&diet=low-carb';
        break;
      default:
        healthFilter = '&health=alcohol-free';
    }

    String api =
        'https://api.edamam.com/search?q=$findrecipe&app_id=$id&app_key=$key$healthFilter';
    final response = await http.get(Uri.parse(api));
    List<Map<String, dynamic>> recipes = [];

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);

      if (data['hits'] != null) {
        for (var hit in data['hits']) {
          if (hit['recipe'] != null) {
            recipes.add(hit['recipe']);
          }
        }
      }
    } else {
      print('Failed to load recipes: ${response.statusCode}');
    }
    return recipes;
  }
}

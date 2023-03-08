import 'dart:convert';
import 'package:grocerygo/constants.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../models/products_model.dart';

// class ProductsRepository {
//   Future<Products> getProducts() async {
//     final response = await http.get(Uri.parse('$baseUrl/products'));
//     if (response.statusCode == 200) {
//       final List<dynamic> productsJson = json.decode(response.body);
//       final Products products =productsFromJson
//       return products;
//     } else {
//       throw Exception('Failed to load products');
//     }
//   }
// }

class ProductsRepository {
  Future<Products> getProducts() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');
    final response = await http.get(
      Uri.parse('$baseUrl/products'),
      headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );
    //final response = await http.get(Uri.parse('http://192.168.8.199:8000/api/products'));
    if (response.statusCode == 200) {
      final result = productsFromJson(response.body);
      return result;
    } else {
      throw "Something went wrong code ${response.statusCode}";
    }
  }
}

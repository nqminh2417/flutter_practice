import 'dart:convert';
import 'package:flutter_practice/models/album.dart';
import 'package:http/http.dart' as http;

class ApiService {
  static const String apiUrl = 'https://jsonplaceholder.typicode.com';

  static Future<List<dynamic>> getPosts() async {
    final response = await http.get(Uri.parse('$apiUrl/posts'));
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load posts');
    }
  }

  static Future<List<dynamic>> getUsers() async {
    final response = await http.get(Uri.parse('$apiUrl/users'));
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load users');
    }
  }

  static Future<List<Album>> getAlbums() async {
    final response = await http.get(Uri.parse('$apiUrl/albums'));
    if (response.statusCode == 200) {
      // return json.decode(response.body);
      final List<dynamic> json = jsonDecode(response.body);
      return json.map((e) => Album.fromMap(e)).toList();
    } else {
      throw Exception('Failed to load albums');
    }
  }
}

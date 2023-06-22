import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:xml2json/xml2json.dart';

class TestScreen extends StatefulWidget {
  const TestScreen({Key? key}) : super(key: key);

  @override
  State<TestScreen> createState() => _TestScreenState();
}

class _TestScreenState extends State<TestScreen> {
  List<String> suggestions = [];
  @override
  void initState() {
    super.initState();
    get();
  }

  get() async {
    suggestions = await fetchSuggestions();
  }

  Future<List<String>> fetchSuggestions() async {
    String baseUrl =
        'https://google.com/complete/search?output=toolbar&ds=yt&q=phephim';

    try {
      final response = await http.get(Uri.parse(baseUrl));
      if (response.statusCode == 200) {
        final transformer = Xml2Json();
        transformer.parse(response.body);
        var json = transformer.toGData();
        List suggestionsData =
            jsonDecode(json)['toplevel']['CompleteSuggestion'];
        for (var suggestion in suggestionsData) {
          suggestions.add(suggestion['suggestion']['data'].toString());
        }
        return suggestions;
      } else {
        throw Exception('Failed to fetch suggestions');
      }
    } catch (e) {
      throw Exception('Failed to connect to the server');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Test Screen',
          style: TextStyle(fontWeight: FontWeight.bold, fontFamily: 'Neonsign'),
        ),
      ),
      body: Center(
          child: Column(
        children: [
          ElevatedButton(
            onPressed: () {},
            child: const Text('Login'),
          ),
        ],
      )),
    );
  }
}

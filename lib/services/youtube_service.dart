import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:xml2json/xml2json.dart';

class YoutubeService {
  static const String apiKey = 'AIzaSyANE2nolzSZH0s41ekJS1sHBqflZBevSfY';

  static Future<List<dynamic>> searchAll(String query) async {
    final url = Uri.https('www.googleapis.com', '/youtube/v3/search', {
      'key': apiKey,
      'part': 'snippet',
      'q': query,
      'type': 'video,channel,playlist',
    });

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final items = data['items'] as List<dynamic>;
      return items;
    } else {
      throw Exception('Failed to load videos');
    }
  }

  static Future<List<String>> getSuggestions(String query) async {
    // Make your API call here and return the results as a List<String>

    String baseUrl =
        'https://google.com/complete/search?output=toolbar&ds=yt&q=$query';

    List<String> suggestions = [];
    if (query.isEmpty) {
      return suggestions;
    }
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
}

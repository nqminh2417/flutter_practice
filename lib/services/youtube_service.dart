import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:xml2json/xml2json.dart';

class YoutubeService {
  static const String apiKey = 'AIzaSyANE2nolzSZH0s41ekJS1sHBqflZBevSfY';

  static Future<List<dynamic>> searchAll(String query) async {
    final url = Uri.https('www.googleapis.com', '/youtube/v3/search', {
      'key': apiKey,
      'maxResults': '20',
      'part': 'snippet',
      'q': query,
      'type': 'channel',//video,channel,playlist
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
    final baseUrl = Uri.https('www.google.com', '/complete/search', {
      'output': 'toolbar',
      'ds': 'yt',
      'xssi': 't',
      'hl': 'vi',
      'authuser': '0',
      'dpr': '1',
      'q': query
    });
    //'https://google.com/complete/search?output=toolbar&ds=yt&cp=$cp&xssi=t&hl=vi&authuser=0&dpr=1.25&q=$query';

    List<String> suggestions = [];
    if (query.isEmpty) {
      return suggestions;
    }
    try {
      final response = await http.get(baseUrl);
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

  static Future<List<dynamic>> getListChannels(String ids) async {
    final url = Uri.https('www.googleapis.com', '/youtube/v3/channels', {
      'key': apiKey,
      'part': 'brandingSettings,id,localizations,snippet,statistics,contentDetails,contentOwnerDetails,status,topicDetails',
      'id': ids
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
}

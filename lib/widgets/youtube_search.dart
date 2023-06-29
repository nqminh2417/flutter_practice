import 'package:flutter/material.dart';

import '../services/youtube_service.dart';
import '../utils/shared_preferences_service.dart';

class YoutubeSearch extends SearchDelegate {
  final List<String> searchHistory;
  final List<String> combinedSuggestions;

  YoutubeSearch(
      {required this.searchHistory, required this.combinedSuggestions});

  void saveSearchHistory() async {
    await SharedPreferencesService.saveSearchHistory(searchHistory);
  }

  @override
  List<Widget>? buildActions(BuildContext context) {
    // Actions for the AppBar (e.g., clear query button)
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          if (query.isNotEmpty) {
            query = '';
            showSuggestions(context);
          } else {
            close(context, null);
          }
        },
      ),
      IconButton(
        icon: const Icon(Icons.more_vert),
        onPressed: () {},
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    // Leading icon (e.g., back button)
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // Build the search results based on the query
    // This is where you would display the search results
    return FutureBuilder<List<dynamic>>(
      future: YoutubeService.searchAll(query),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else if (snapshot.hasData) {
          final results = snapshot.data!;
          // Display the search results in your desired widget
          return ListView.builder(
            itemCount: results.length,
            itemBuilder: (context, index) {
              final result = results[index];
              return Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: SizedBox(
                  width: 100,
                  height: 100,
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.network(
                          result['snippet']['thumbnails']['medium']['url'],
                          width: 120,
                          height: 90,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Expanded(
                          child: Padding(
                        padding:
                            const EdgeInsetsDirectional.fromSTEB(6, 4, 0, 4),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              result['snippet']['title'],
                              maxLines: 2,
                              softWrap: false,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                            Text(result['snippet']['channelTitle']),
                            Text(result['snippet']['publishTime']),
                          ],
                        ),
                      ))
                    ],
                  ),
                ),
              );
            },
          );
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // Suggestions that appear when typing in the search bar
    // This is where you would display suggested search terms
    return FutureBuilder(
        future: YoutubeService.getSuggestions(query),
        builder: (context, snapshot) {
          // if (snapshot.connectionState == ConnectionState.waiting) {
          //   return const Center(child: CircularProgressIndicator());
          // }

          if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          }

          final apiResults = snapshot.data ?? [];

          final filteredResults = filterDuplicates(apiResults);
          final combinedSuggestions = [...searchHistory, ...filteredResults]
              .where((search) => search.startsWith(query))
              .toList();

          return ListView.builder(
            itemCount: combinedSuggestions.length,
            itemBuilder: (context, index) {
              final suggestion = combinedSuggestions[index];

              return ListTile(
                leading: searchHistory.contains(suggestion)
                    ? const Icon(Icons.history)
                    : const Icon(Icons.search),
                title: Text(suggestion),
                trailing: const Icon(Icons.north_west),
                onTap: () {
                  // Handle suggestion selection
                  query = suggestion;
                  showResults(context);
                },
                onLongPress: () {
                  if (searchHistory.contains(suggestion)) {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text(suggestion),
                            content: const Text(
                                'Do you want to delete this item from search history?'),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context); // Close the dialog
                                },
                                child: const Text('Cancel'),
                              ),
                              TextButton(
                                onPressed: () {
                                  if (searchHistory.contains(suggestion)) {
                                    searchHistory.remove(suggestion);
                                    saveSearchHistory();
                                    // Rebuild buildSuggestions with updated suggestions
                                    showSuggestions(context);
                                  }
                                  Navigator.pop(context); // Close the dialog
                                },
                                child: const Text('Delete'),
                              ),
                            ],
                          );
                        });
                  }
                },
              );
            },
          );
        });
  }

  List<String> filterDuplicates(List<String> apiResults) {
    return apiResults
        .where((result) => !searchHistory.contains(result))
        .toList();
  }

  @override
  void showResults(BuildContext context) {
    super.showResults(context);
    // Update the search history
    if (query.isNotEmpty && !searchHistory.contains(query)) {
      searchHistory.insert(0, query);
      // Save the search query to history
      saveSearchHistory();
    }
  }
}

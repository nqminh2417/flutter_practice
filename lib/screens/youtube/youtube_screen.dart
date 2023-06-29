import 'package:flutter/material.dart';
import 'package:flutter_practice/screens/youtube/youtube_channel_list.dart';
import 'package:provider/provider.dart';

import '../../providers/data_provider.dart';
import '../../services/firebase_service.dart';
import '../../utils/shared_preferences_service.dart';
import '../../widgets/youtube_search.dart';

class YoutubeScreen extends StatefulWidget {
  const YoutubeScreen({super.key});

  @override
  State<YoutubeScreen> createState() => _YoutubeScreenState();
}

class _YoutubeScreenState extends State<YoutubeScreen>
    with TickerProviderStateMixin {
  late final TabController _tabController;
  late List<String> searchHistory;
  late List<String> combinedSuggestions;
  late DataProvider dataProvider;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    loadSearchHistory();
    fetchData();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void loadSearchHistory() async {
    searchHistory = await SharedPreferencesService.loadSearchHistory();
    updateCombinedSuggestions();
  }

  void updateCombinedSuggestions() {
    combinedSuggestions = [...searchHistory].toList();
    setState(
        () {}); // Notify the widget to rebuild with the updated combined suggestions
  }

  void deleteSearchHistoryItem(String item) async {
    if (searchHistory.contains(item)) {
      searchHistory.remove(item);
      await SharedPreferencesService.saveSearchHistory(searchHistory);
      updateCombinedSuggestions();
    }
  }

  fetchData() async {
    try {
      final ytBlockedChannels = await FirebaseService.getYtBlockedChannels();
      final ytSubscribedChannels = await FirebaseService.getYtSubscribedChannels();
      setState(() {
        Provider.of<DataProvider>(context, listen: false)
            .setYtBlockedChannels(ytBlockedChannels);

        Provider.of<DataProvider>(context, listen: false)
            .setYtSubscribedChannel(ytSubscribedChannels);
      });
    } catch (e) {
      // Handle error
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xffe53935),
        elevation: 1,
        title: const Text('Youtube Screen'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              showSearch(
                context: context,
                delegate: YoutubeSearch(
                    searchHistory: searchHistory,
                    combinedSuggestions: combinedSuggestions),
              );
            },
          )
        ],
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: Colors.white,
          tabs: const [
            Tab(
              icon: Icon(Icons.subscriptions),
            ),
            Tab(
              icon: Icon(Icons.list),
            ),
            Tab(
              icon: Icon(Icons.brightness_5_sharp),
            ),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: const [
          Center(
            child: Text("It's cloudy here"),
          ),
          Center(
            child: YoutubeChannelList(),
          ),
          Center(
            child: Text("It's sunny here"),
          ),
        ],
      ),
    );
  }
}

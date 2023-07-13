import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/data_provider.dart';
import '../../services/youtube_service.dart';
import 'youtube_channel_info.dart';

class YoutubeSubscriptions extends StatefulWidget {
  const YoutubeSubscriptions({super.key});

  @override
  State<YoutubeSubscriptions> createState() => _YoutubeSubscriptionsState();
}

class _YoutubeSubscriptionsState extends State<YoutubeSubscriptions> {
  late DataProvider dataProvider;
  bool isDataLoaded = false; // Add a flag to track if the data is loaded

  @override
  void initState() {
    super.initState();
    dataProvider = Provider.of<DataProvider>(context, listen: false);
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await _initializeChannels(); // Wait for channels to be initialized
      setState(() {
        isDataLoaded = true; // Mark data as loaded after initialization
      });
    });
  }

  Future<void> _initializeChannels() async {
    await dataProvider.initializeChannels();
  }

  @override
  Widget build(BuildContext context) {
    if (!isDataLoaded) {
      // Show loading indicator while data is being fetched
      return const Center(child: CircularProgressIndicator());
    }

    final channelList = dataProvider.channelList;
    final channelIds = channelList
        .where((channel) => !channel.isBlocked)
        .map((channel) => channel.channelId)
        .join(',');

    return FutureBuilder<List<dynamic>>(
        future: YoutubeService.getListChannels(channelIds),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else if (snapshot.hasData) {
            final items = snapshot.data!;
            return ListView.builder(
              itemCount: items.length,
              itemBuilder: (context, index) {
                final item = items[index];
                return ListTile(
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(
                        item['snippet']['thumbnails']['default']['url']),
                  ),
                  title: Text(item['snippet']['title']),
                  trailing: IconButton(
                    icon: const Icon(Icons.more_horiz),
                    onPressed: () {},
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => YoutubeChannelInfo(
                          channelId: item['id'],
                        ),
                      ),
                    );
                  },
                );
              },
            );
          } else {
            return const Center(child: Text('No data available'));
          }
        });
  }
}

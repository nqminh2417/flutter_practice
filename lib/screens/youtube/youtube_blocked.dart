import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/data_provider.dart';
import '../../services/youtube_service.dart';

class YoutubeBlocked extends StatefulWidget {
  const YoutubeBlocked({super.key});

  @override
  State<YoutubeBlocked> createState() => _YoutubeBlockedState();
}

class _YoutubeBlockedState extends State<YoutubeBlocked> {
  late DataProvider dataProvider;
  
  @override
  void initState() {
    super.initState();
    dataProvider = Provider.of<DataProvider>(context, listen: false);
  }
  
  @override
  Widget build(BuildContext context) {
    final channelIds =
        dataProvider.ytBlockedChannels.map((e) => e.channelId).join(',');
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
                  onTap: () {},
                );
              },
            );
          } else {
            return const Center(child: Text('No data available'));
          }
        });
  }
}
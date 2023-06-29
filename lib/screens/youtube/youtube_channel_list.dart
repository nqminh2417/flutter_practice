import 'package:flutter/material.dart';
import 'package:flutter_practice/screens/youtube/youtube_blocked.dart';
import 'package:flutter_practice/services/youtube_service.dart';
import 'package:provider/provider.dart';

import '../../models/youtube_channel.dart';
import '../../providers/data_provider.dart';
import 'youtube_subscriptions.dart';

class YoutubeChannelList extends StatefulWidget {
  const YoutubeChannelList({super.key});

  @override
  State<YoutubeChannelList> createState() => _YoutubeChannelListState();
}

class _YoutubeChannelListState extends State<YoutubeChannelList>
    with TickerProviderStateMixin {
  late TabController _tabController;
  late DataProvider dataProvider;
  final List<String> tabs = ['Subsciptions', 'Blocked'];
  late List<YoutubeChannel> ytBlockedChannels = [];
  late List<YoutubeChannel> ytSubscribedChannels = [];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: tabs.length, vsync: this);
    dataProvider = Provider.of<DataProvider>(context, listen: false);
    // fetchData();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  // Future<void> fetchData() async {
  //   setState(() {
  //     _isLoading = true;
  //   });
  //   try {
  //     ytBlockedChannels = await FirebaseService.getYtBlockedChannels();
  //     ytSubscribedChannels = await FirebaseService.getYtSubscribedChannels();
  //   } catch (e) {
  //     // Handle error
  //   }
  //   setState(() {
  //     _isLoading = false;
  //   });
  // }

  // Future<void> _refreshData() async {
  //   await fetchData();
  // }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Container(
            width: MediaQuery.of(context).size.width * 0.7,
            height: 45,
            decoration: BoxDecoration(
              color: const Color(0xffe5e5e5),
              borderRadius: BorderRadius.circular(
                25.0,
              ),
            ),
            child: TabBar(
              controller: _tabController,
              // give the indicator a decoration (color and border radius)
              indicator: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.15),
                    spreadRadius: 1,
                    blurRadius: 5,
                    offset: const Offset(0, 3),
                  )
                ],
                borderRadius: BorderRadius.circular(
                  25.0,
                ),
                color: Colors.white,
              ),
              splashBorderRadius: BorderRadius.circular(
                25.0,
              ),
              labelColor: Colors.black,
              unselectedLabelColor: Colors.grey,
              tabs: const [
                // first tab [you can add an icon using the icon property]
                Tab(
                  text: 'Subscriptions',
                ),

                // second tab [you can add an icon using the icon property]
                Tab(
                  text: 'Blocked',
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              physics: const NeverScrollableScrollPhysics(),
              children: const [
                YoutubeSubscriptions(),
                YoutubeBlocked(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildSubscriptions() {
    // final ytSubscribedChannels = dataProvider.ytSubscribedChannels;
    final channelIds = dataProvider.ytSubscribedChannels.map((e) => e.channelId).join(',');
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
                        backgroundImage: NetworkImage(item['snippet']
                            ['thumbnails']['default']['url']),
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

  Widget buildBlocked() {
    // final ytSubscribedChannels = dataProvider.ytSubscribedChannels;
    return const Text("ASd");
  }

  // return ListView.builder(
  //     itemCount: items.length,
  //     itemBuilder: (context, index) {
  //       final item = items[index];
  //       return ListTile(
  //         title: Text(item.title),
  //         trailing: const Icon(Icons.clear),
  //       );
  //     });
}

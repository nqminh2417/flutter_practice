import 'package:flutter/material.dart';
import 'package:flutter_practice/services/youtube_service.dart';
import 'package:flutter_practice/utils/constants.dart';
import 'package:flutter_practice/utils/string_utils.dart';
import 'package:flutter_practice/widgets/qm_button.dart';
import 'package:provider/provider.dart';

import '../../models/youtube_channel.dart';
import '../../providers/data_provider.dart';
import '../test_screen.dart';

class YoutubeChannelInfo extends StatefulWidget {
  final String channelId;
  const YoutubeChannelInfo({super.key, required this.channelId});

  @override
  State<YoutubeChannelInfo> createState() => _YoutubeChannelInfoState();
}

class _YoutubeChannelInfoState extends State<YoutubeChannelInfo> {
  late DataProvider dataProvider;
  late bool isLoading = true;
  late String title = '';
  late String statistics = '';
  late String banner = '';
  late String thumbnails = '';

  @override
  void initState() {
    super.initState();
    dataProvider = Provider.of<DataProvider>(context, listen: false);
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      dataProvider.initializeChannels();
      await _fetchChannelInfo();
    });
  }

  Future<void> _fetchChannelInfo() async {
    try {
      final fetchedData =
          await YoutubeService.getListChannels(widget.channelId);
      if (fetchedData.isNotEmpty) {
        final item = fetchedData[0];
        setState(() {
          title = item['snippet']['title'] ?? 'No Title';
          statistics = item['snippet']['customUrl'] +
              ' ∙ ' +
              StringUtils.formatNumberToShort(
                  item['statistics']['subscriberCount']) +
              ' subscribers ∙ ' +
              item['statistics']['videoCount'] +
              ' videos';
          banner = item['brandingSettings']['image'] != null
              ? item['brandingSettings']['image']['bannerExternalUrl'] ?? ''
              : '';
          thumbnails = item['snippet']['thumbnails']['default']['url'] ?? '';
          isLoading = false;
        });
      } else {
        setState(() {
          title = 'Channel Info';
          isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        title = 'Error';
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      // Show loading indicator or placeholder
      return const Center(child: CircularProgressIndicator());
    }

    final channelList = dataProvider.channelList;
    YoutubeChannel? yc;
    try {
      yc = channelList.firstWhere(
        (channel) => channel.channelId == widget.channelId,
      );
    } catch (_) {
      yc = null;
    }

    // final yc = channelList.firstWhere(
    //   (channel) => channel.channelId == widget.channelId,orElse: () => null,
    // );

    return Scaffold(
      appBar: AppBar(
        title: Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          banner.isEmpty
              ? Image.asset(
                  'assets/images/banner.jpg',
                  width: MediaQuery.of(context).size.width,
                  height: 70,
                  fit: BoxFit.cover,
                )
              : Image.network(
                  banner,
                  width: MediaQuery.of(context).size.width,
                  height: 70,
                  fit: BoxFit.cover,
                ),
          Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(0, 16, 0, 14),
            child: Container(
              width: MediaQuery.of(context).size.width / 5,
              height: MediaQuery.of(context).size.width / 5,
              clipBehavior: Clip.antiAlias,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
              ),
              child: thumbnails.isEmpty
                  ? Image.asset('assets/images/user.png')
                  : Image.network(
                      thumbnails,
                      fit: BoxFit.cover,
                    ),
            ),
          ),
          Text(
            title,
            style: const TextStyle(fontSize: 28, fontWeight: FontWeight.w600),
          ),
          Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(0, 8, 0, 8),
            child: Text(
              statistics,
              style: const TextStyle(fontSize: 12),
            ),
          ),
          GestureDetector(
            onTap: () {
              // Navigate to the new screen when the Row is clicked
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      const TestScreen(), // Replace 'NewScreen' with the desired screen to navigate to
                ),
              );
            },
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              child: const Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'More about this channel',
                    style: TextStyle(fontSize: 12),
                  ),
                  Icon(
                    Icons.arrow_forward_ios_outlined,
                    size: 18,
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(0, 16, 0, 16),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: yc == null
                  ? [
                      QMButton(
                        text: "Subscribe",
                        leadingIcon: Icons.notifications_outlined,
                        onPressed: () {
                          // Subscribe to a new channel
                          actionSubscribe();
                        },
                      ),
                      QMButton(
                        text: "Block",
                        trailingIcon: Icons.block_outlined,
                        onPressed: () {
                          // Block a new channel
                          actionBlock();
                        },
                      ),
                    ]
                  : [
                      if (!yc.isBlocked) ...[
                        QMButton(
                            text: "Unsubscribe",
                            leadingIcon: Icons.notifications_off_outlined,
                            onPressed: () {
                              // Add a new channel
                              actionUnsubscribe();
                            }),
                        QMButton(
                            text: "Block",
                            leadingIcon: Icons.block_outlined,
                            onPressed: () {
                              // Block a channel
                              actionBlock();
                            }),
                      ],
                      if (yc.isBlocked) ...[
                        QMButton(
                          text: 'Subscribe',
                          leadingIcon: Icons.notifications_outlined,
                          onPressed: () {
                            // Subscribe to a new channel
                            actionSubscribe();
                          },
                        ),
                        QMButton(
                          text: 'Unblock',
                          leadingIcon: Icons.priority_high_outlined,
                          onPressed: () {
                            // Unblock a channel
                            actionUnblock();
                          },
                        )
                      ],
                    ],
            ),
          ),
        ],
      ),
    );
  }

  void actionSubscribe() {
    final newChannel = YoutubeChannel(
      channelId: widget.channelId,
      title: title,
      isBlocked: false,
    );
    dataProvider.channelAction(newChannel, YtAction.subscribe);
  }

  void actionUnsubscribe() {
    final newChannel = YoutubeChannel(
      channelId: widget.channelId,
      title: title,
      isBlocked: false,
    );
    dataProvider.channelAction(newChannel, YtAction.unsubscribe);
  }

  void actionBlock() {
    final newChannel = YoutubeChannel(
      channelId: widget.channelId,
      title: title,
      isBlocked: true,
    );
    dataProvider.channelAction(newChannel, YtAction.block);
  }

  void actionUnblock() {
    final newChannel = YoutubeChannel(
      channelId: widget.channelId,
      title: title,
      isBlocked: false,
    );
    dataProvider.channelAction(newChannel, YtAction.unblock);
  }
}

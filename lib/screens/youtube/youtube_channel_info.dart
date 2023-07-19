import 'package:flutter/material.dart';
import 'package:flutter_practice/services/youtube_service.dart';
import 'package:flutter_practice/utils/constants.dart';
import 'package:flutter_practice/utils/string_utils.dart';
import 'package:flutter_practice/widgets/loading_indicators/wave_indicator.dart';
import 'package:flutter_practice/widgets/qm_button.dart';
import 'package:provider/provider.dart';

import '../../models/youtube_channel.dart';
import '../../providers/data_provider.dart';
import '../../utils/datetime_utils.dart';
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
  late YoutubeChannel? yc;

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
        final data = fetchedData[0];
        setState(() {
          title = data['snippet']['title'] ?? 'No Title';
          statistics = data['snippet']['customUrl'] +
              ' ∙ ' +
              StringUtils.formatNumberToShort(
                  data['statistics']['subscriberCount']) +
              ' subscribers ∙ ' +
              data['statistics']['videoCount'] +
              ' videos';
          banner = data['brandingSettings']['image'] != null
              ? data['brandingSettings']['image']['bannerExternalUrl'] ?? ''
              : '';
          thumbnails = data['snippet']['thumbnails']['default']['url'] ?? '';
          isLoading = false;
          yc = _getYoutubeChannel();
        });
      } else {
        setState(() {
          title = 'Channel Info';
          isLoading = false;
          yc = _getYoutubeChannel();
        });
      }
    } catch (e) {
      setState(() {
        title = 'Error';
        isLoading = false;
        yc = _getYoutubeChannel();
      });
    }
  }

  YoutubeChannel? _getYoutubeChannel() {
    final channelList = dataProvider.channelList;
    try {
      return channelList.firstWhere(
        (channel) => channel.channelId == widget.channelId,
      );
    } catch (_) {
      return YoutubeChannel(
          channelId: widget.channelId,
          title: title,
          isSubscribed: false,
          isBlocked: false);
    }
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }

  Future<void> _performChannelAction(
      YoutubeChannel channel, YtAction ytAction) async {
    try {
      bool success = await dataProvider.performChannelAction(channel, ytAction);
      if (success) {
        String actionMessage;
        switch (ytAction) {
          case YtAction.subscribe:
            actionMessage = 'Successfully subscribed';
            break;
          case YtAction.unsubscribe:
            actionMessage = 'Successfully unsubscribed';
            break;
          case YtAction.block:
            actionMessage = 'Successfully blocked';
            break;
          case YtAction.unblock:
            actionMessage = 'Successfully unblocked';
            break;
        }
        _showSnackBar(actionMessage);
      } else {
        _showSnackBar('Action failed');
      }
    } catch (e) {
      _showSnackBar('Action failed: $e');
    }
  }

  Widget _buildSubscribeButton() {
    return QMButton(
      text: 'Subscribe',
      onPressed: () async {
        setState(() {
          yc!.isBlocked = false;
          yc!.isSubscribed = true;
        });
        await _performChannelAction(yc!, YtAction.subscribe);
      },
    );
  }

  Widget _buildUnsubscribeButton() {
    return QMButton(
      text: 'Unsubscribe',
      onPressed: () async {
        await _performChannelAction(yc!, YtAction.unsubscribe);
      },
    );
  }

  Widget _buildBlockButton() {
    return QMButton(
      text: 'Block',
      onPressed: () async {
        setState(() {
          yc!.isBlocked = true;
          yc!.isSubscribed = false;
        });
        await _performChannelAction(yc!, YtAction.block);
      },
    );
  }

  Widget _buildUnblockButton() {
    return QMButton(
      text: 'Unblock',
      onPressed: () async {
        await _performChannelAction(yc!, YtAction.unblock);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      // Show loading indicator or placeholder
      return const Center(child: CircularProgressIndicator());
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xffe53935),
        title: Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
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
            if (yc!.isSubscribed == false && yc!.isBlocked == false)
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(0, 16, 0, 16),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _buildSubscribeButton(),
                    _buildBlockButton(),
                  ],
                ),
              ),
            if (yc!.isSubscribed == true && yc!.isBlocked == false)
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(0, 16, 0, 16),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _buildUnsubscribeButton(),
                    _buildBlockButton(),
                  ],
                ),
              ),
            if (yc!.isSubscribed == false && yc!.isBlocked == true)
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(0, 16, 0, 16),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _buildSubscribeButton(),
                    _buildUnblockButton(),
                  ],
                ),
              ),
            FutureBuilder<List<dynamic>>(
              future: YoutubeService.getChannelVideos(widget.channelId),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: WaveIndicator());
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else if (snapshot.hasData) {
                  final items = snapshot.data!;
                  return ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: items.length,
                    itemBuilder: (context, index) {
                      final item = items[index];
                      return GestureDetector(
                        onTap: () {},
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 6),
                          child: SizedBox(
                            width: 100,
                            height: 80,
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(4),
                                  child: Image.network(
                                    item['snippet']['thumbnails']['medium']
                                        ['url'],
                                    width: 125,
                                    height: 70,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                Expanded(
                                    child: Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                      8, 4, 0, 4),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        item['snippet']['title'],
                                        maxLines: 2,
                                        softWrap: false,
                                        overflow: TextOverflow.ellipsis,
                                        style: const TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.w500),
                                      ),
                                      Text(
                                        item['snippet']['channelTitle'],
                                        style: const TextStyle(
                                            fontSize: 11,
                                            fontWeight: FontWeight.w300),
                                      ),
                                      Text(
                                        DateTimeUtils.timeFromNow(
                                            item['snippet']['publishTime']),
                                        style: const TextStyle(
                                            fontSize: 11,
                                            fontWeight: FontWeight.w300),
                                      ),
                                    ],
                                  ),
                                ))
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  );
                } else {
                  return const Center(child: Text('No data available'));
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}

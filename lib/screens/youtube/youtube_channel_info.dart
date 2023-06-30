import 'package:flutter/material.dart';
import 'package:flutter_practice/services/youtube_service.dart';
import 'package:flutter_practice/utils/string_utils.dart';
import 'package:flutter_practice/widgets/qm_button.dart';

class YoutubeChannelInfo extends StatefulWidget {
  final String channelId;
  const YoutubeChannelInfo({super.key, required this.channelId});

  @override
  State<YoutubeChannelInfo> createState() => _YoutubeChannelInfoState();
}

class _YoutubeChannelInfoState extends State<YoutubeChannelInfo> {
  late String title = '';
  late String bannerExternalUrl =
      'https://cdn.pixabay.com/photo/2016/08/03/09/03/universe-1566159_1280.jpg';
  late String thumbnails = 'https://picsum.photos/seed/211/600';
  late String customUrl = '';
  late String subscriberCount = '';
  late String videoCount = '';

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  fetchData() async {
    try {
      final data =
          await YoutubeService.getListChannels('UCWu91J5KWEj1bQhCBuGeJxw');
      setState(() {
        title = data[0]['snippet']['title'];
        bannerExternalUrl =
            data[0]['brandingSettings']['image']['bannerExternalUrl'];
        thumbnails = data[0]['snippet']['thumbnails']['default']['url'];
        customUrl = data[0]['snippet']['customUrl'];
        subscriberCount = StringUtils.formatNumberToShort(
            data[0]['statistics']['subscriberCount']);
        videoCount = data[0]['statistics']['videoCount'];
      });
    } catch (e) {
      // Handle the error
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          title,
          style: const TextStyle(
              fontWeight: FontWeight.bold, fontFamily: 'Neonsign'),
        ),
      ),
      body: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Image.network(
            bannerExternalUrl,
            width: double.infinity,
            height: 100,
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
              child: Image.network(
                thumbnails,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Text(
            title,
            style: const TextStyle(fontSize: 32, fontWeight: FontWeight.w600),
          ),
          Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(0, 8, 0, 8),
            child: Text(
              '$customUrl ∙ $subscriberCount subscribers ∙ $videoCount videos',
              style: const TextStyle(fontSize: 12),
            ),
          ),
          const Row(
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
          Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(0, 16, 0, 16),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                QMButton(
                    text: "Subscribe",
                    leadingIcon: Icons.notifications_outlined,
                    borderRadius: 20,
                    onPressed: () {}),
                QMButton(
                    text: "Block",
                    trailingIcon: Icons.block_outlined,
                    borderStyle: BorderStyle.solid,
                    borderColor: Colors.pink,
                    borderRadius: 20,
                    onPressed: () {})
              ],
            ),
          ),
        ],
      ),
    );
  }
}

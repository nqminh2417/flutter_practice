import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class YoutubePlayScreen extends StatefulWidget {
  const YoutubePlayScreen({super.key});

  @override
  State<YoutubePlayScreen> createState() => _YoutubePlayScreenState();
}

class _YoutubePlayScreenState extends State<YoutubePlayScreen> {
  final videoURL = "https://www.youtube.com/watch?v=ukHK1GVyr0I";

  late YoutubePlayerController _controller;

  @override
  void initState() {
    final videoID = YoutubePlayer.convertUrlToId(videoURL);

    _controller = YoutubePlayerController(
        initialVideoId: videoID!,
        flags: const YoutubePlayerFlags(loop: true));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Youtube Play Screen'),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            YoutubePlayer(
              controller: _controller,
              showVideoProgressIndicator: true,
              onReady: () => debugPrint('ready'),
              bottomActions: [
                CurrentPosition(),
                ProgressBar(
                  isExpanded: true,
                  colors: const ProgressBarColors(
                      playedColor: Colors.amber,
                      handleColor: Colors.amberAccent),
                ),
                const PlaybackSpeedButton()
              ],
            )
          ],
        ));
  }
}

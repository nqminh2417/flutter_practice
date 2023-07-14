import 'package:flutter/material.dart';
import 'package:flutter_practice/utils/constants.dart';

import '../models/youtube_channel.dart';
import '../services/firebase_service.dart';

class DataProvider extends ChangeNotifier {
  List<YoutubeChannel> _channelList = [];

  List<YoutubeChannel> get channelList => _channelList;

  Future<void> initializeChannels() async {
    List<YoutubeChannel> channels = await FirebaseService.getYtChannels();
    _channelList = channels;
    notifyListeners();
  }

  void channelAction(YoutubeChannel channel, YtAction ytAction) async {
    switch (ytAction) {
      case YtAction.subscribe:
      case YtAction.block:
        // Check if the channel already exists
        final existingChannel = channelList.firstWhere(
          (c) => c.channelId == channel.channelId,
          orElse: () =>
              YoutubeChannel(channelId: '', title: '', isBlocked: false),
        );

        if (existingChannel.channelId.isEmpty) {
          // Channel does not exist, add a new one
          await FirebaseService.addYtChannel(channel);
        } else if (existingChannel.isBlocked != channel.isBlocked) {
          // Channel exists, but 'isBlocked' value is different, update it
          await FirebaseService.updateYtChannel(channel);
        }
        break;
      case YtAction.unsubscribe:
      case YtAction.unblock:
        await FirebaseService.removeYtChannel(channel);
        break;
      default:
    }

    // Optionally, you can update the channelList immediately after adding a channel
    List<YoutubeChannel> updatedChannels = await FirebaseService.getYtChannels();
    _channelList = updatedChannels;
    notifyListeners();
  }

  String getChannelIdsSeparatedByComma() {
    return channelList.map((channel) => channel.channelId).join(',');
  }
}

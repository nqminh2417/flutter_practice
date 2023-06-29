import 'package:flutter/material.dart';

import '../models/youtube_channel.dart';

class DataProvider extends ChangeNotifier {
  List<YoutubeChannel> _ytBlockedChannel = [];

  List<YoutubeChannel> get ytBlockedChannels => _ytBlockedChannel;

  void setYtBlockedChannels(List<YoutubeChannel> items) {
    _ytBlockedChannel = items;
    notifyListeners();
  }

  List<YoutubeChannel> _ytSubscribedChannel = [];

  List<YoutubeChannel> get ytSubscribedChannels => _ytSubscribedChannel;

  void setYtSubscribedChannel(List<YoutubeChannel> items) {
    _ytSubscribedChannel = items;
    notifyListeners();
  }
}

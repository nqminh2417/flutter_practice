// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class YoutubeChannel {
  String channelId;
  String title;
  YoutubeChannel({
    required this.channelId,
    required this.title,
  });

  YoutubeChannel copyWith({
    String? channelId,
    String? title,
  }) {
    return YoutubeChannel(
      channelId: channelId ?? this.channelId,
      title: title ?? this.title,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'channelId': channelId,
      'title': title,
    };
  }

  factory YoutubeChannel.fromMap(Map<String, dynamic> map) {
    return YoutubeChannel(
      channelId: map['channelId'] as String,
      title: map['title'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory YoutubeChannel.fromJson(String source) => YoutubeChannel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'YoutubeChannel(channelId: $channelId, title: $title)';

  @override
  bool operator ==(covariant YoutubeChannel other) {
    if (identical(this, other)) return true;
  
    return 
      other.channelId == channelId &&
      other.title == title;
  }

  @override
  int get hashCode => channelId.hashCode ^ title.hashCode;
}

// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class YoutubeChannel {
  String channelId;
  String title;
  bool isSubscribed;
  bool isBlocked;
  YoutubeChannel({
    required this.channelId,
    required this.title,
    required this.isSubscribed,
    required this.isBlocked,
  });

  YoutubeChannel copyWith({
    String? channelId,
    String? title,
    bool? isSubscribed,
    bool? isBlocked,
  }) {
    return YoutubeChannel(
      channelId: channelId ?? this.channelId,
      title: title ?? this.title,
      isSubscribed: isSubscribed ?? this.isSubscribed,
      isBlocked: isBlocked ?? this.isBlocked,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'channelId': channelId,
      'title': title,
      'isSubscribed': isSubscribed,
      'isBlocked': isBlocked,
    };
  }

  factory YoutubeChannel.fromMap(Map<String, dynamic> map) {
    return YoutubeChannel(
      channelId: map['channelId'] as String,
      title: map['title'] as String,
      isSubscribed: map['isSubscribed'] as bool,
      isBlocked: map['isBlocked'] as bool,
    );
  }

  String toJson() => json.encode(toMap());

  factory YoutubeChannel.fromJson(String source) => YoutubeChannel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'YoutubeChannel(channelId: $channelId, title: $title, isSubscribed: $isSubscribed, isBlocked: $isBlocked)';
  }

  @override
  bool operator ==(covariant YoutubeChannel other) {
    if (identical(this, other)) return true;
  
    return 
      other.channelId == channelId &&
      other.title == title &&
      other.isSubscribed == isSubscribed &&
      other.isBlocked == isBlocked;
  }

  @override
  int get hashCode {
    return channelId.hashCode ^
      title.hashCode ^
      isSubscribed.hashCode ^
      isBlocked.hashCode;
  }
}

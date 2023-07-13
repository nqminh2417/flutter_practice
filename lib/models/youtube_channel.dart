// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class YoutubeChannel {
  final String channelId;
  final String title;
  final bool isBlocked;
  YoutubeChannel({
    required this.channelId,
    required this.title,
    required this.isBlocked,
  });

  factory YoutubeChannel.fromFirestore(Map<String, dynamic> data) {
    return YoutubeChannel(
      channelId: data['channelId'],
      title: data['title'],
      isBlocked: data['isBlocked'],
    );
  }

  YoutubeChannel copyWith({
    String? channelId,
    String? title,
    bool? isBlocked,
  }) {
    return YoutubeChannel(
      channelId: channelId ?? this.channelId,
      title: title ?? this.title,
      isBlocked: isBlocked ?? this.isBlocked,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'channelId': channelId,
      'title': title,
      'isBlocked': isBlocked,
    };
  }

  factory YoutubeChannel.fromMap(Map<String, dynamic> map) {
    return YoutubeChannel(
      channelId: map['channelId'] as String,
      title: map['title'] as String,
      isBlocked: map['isBlocked'] as bool,
    );
  }

  String toJson() => json.encode(toMap());

  factory YoutubeChannel.fromJson(String source) => YoutubeChannel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'YoutubeChannel(channelId: $channelId, title: $title, isBlocked: $isBlocked)';

  @override
  bool operator ==(covariant YoutubeChannel other) {
    if (identical(this, other)) return true;
  
    return 
      other.channelId == channelId &&
      other.title == title &&
      other.isBlocked == isBlocked;
  }

  @override
  int get hashCode => channelId.hashCode ^ title.hashCode ^ isBlocked.hashCode;
}

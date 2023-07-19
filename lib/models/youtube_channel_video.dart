// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class ChannelVideo {
  String channelId;
  String channelTitle;
  String description;
  String thumbnailDefaultUrl;
  String thumbnailMediumUrl;
  String thumbnailHighUrl;
  String title;
  String videoId;
  DateTime publishedAt;

  ChannelVideo({
    required this.channelId,
    required this.channelTitle,
    required this.description,
    required this.thumbnailDefaultUrl,
    required this.thumbnailMediumUrl,
    required this.thumbnailHighUrl,
    required this.title,
    required this.videoId,
    required this.publishedAt,
  });

  ChannelVideo copyWith({
    String? channelId,
    String? channelTitle,
    String? description,
    String? thumbnailDefaultUrl,
    String? thumbnailMediumUrl,
    String? thumbnailHighUrl,
    String? title,
    String? videoId,
    DateTime? publishedAt,
  }) {
    return ChannelVideo(
      channelId: channelId ?? this.channelId,
      channelTitle: channelTitle ?? this.channelTitle,
      description: description ?? this.description,
      thumbnailDefaultUrl: thumbnailDefaultUrl ?? this.thumbnailDefaultUrl,
      thumbnailMediumUrl: thumbnailMediumUrl ?? this.thumbnailMediumUrl,
      thumbnailHighUrl: thumbnailHighUrl ?? this.thumbnailHighUrl,
      title: title ?? this.title,
      videoId: videoId ?? this.videoId,
      publishedAt: publishedAt ?? this.publishedAt,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'channelId': channelId,
      'channelTitle': channelTitle,
      'description': description,
      'thumbnailDefaultUrl': thumbnailDefaultUrl,
      'thumbnailMediumUrl': thumbnailMediumUrl,
      'thumbnailHighUrl': thumbnailHighUrl,
      'title': title,
      'videoId': videoId,
      'publishedAt': publishedAt.millisecondsSinceEpoch,
    };
  }

  factory ChannelVideo.fromMap(Map<String, dynamic> map) {
    return ChannelVideo(
      channelId: map['channelId'] as String,
      channelTitle: map['channelTitle'] as String,
      description: map['description'] as String,
      thumbnailDefaultUrl: map['thumbnailDefaultUrl'] as String,
      thumbnailMediumUrl: map['thumbnailMediumUrl'] as String,
      thumbnailHighUrl: map['thumbnailHighUrl'] as String,
      title: map['title'] as String,
      videoId: map['videoId'] as String,
      publishedAt:
          DateTime.fromMillisecondsSinceEpoch(map['publishedAt'] as int),
    );
  }

  String toJson() => json.encode(toMap());

  factory ChannelVideo.fromJson(String source) =>
      ChannelVideo.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'ChannelVideo(channelId: $channelId, channelTitle: $channelTitle, description: $description, thumbnailDefaultUrl: $thumbnailDefaultUrl, thumbnailMediumUrl: $thumbnailMediumUrl, thumbnailHighUrl: $thumbnailHighUrl, title: $title, videoId: $videoId, publishedAt: $publishedAt)';
  }

  @override
  bool operator ==(covariant ChannelVideo other) {
    if (identical(this, other)) return true;

    return other.channelId == channelId &&
        other.channelTitle == channelTitle &&
        other.description == description &&
        other.thumbnailDefaultUrl == thumbnailDefaultUrl &&
        other.thumbnailMediumUrl == thumbnailMediumUrl &&
        other.thumbnailHighUrl == thumbnailHighUrl &&
        other.title == title &&
        other.videoId == videoId &&
        other.publishedAt == publishedAt;
  }

  @override
  int get hashCode {
    return channelId.hashCode ^
        channelTitle.hashCode ^
        description.hashCode ^
        thumbnailDefaultUrl.hashCode ^
        thumbnailMediumUrl.hashCode ^
        thumbnailHighUrl.hashCode ^
        title.hashCode ^
        videoId.hashCode ^
        publishedAt.hashCode;
  }
}

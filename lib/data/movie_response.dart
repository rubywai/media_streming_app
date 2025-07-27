class MovieResponse {
  MovieResponse({
    this.name,
    this.videoLink,
    this.thumbnail,
    this.type,
    this.resolutions,
  });

  MovieResponse.fromJson(dynamic json) {
    name = json['name'];
    videoLink = json['video_link'];
    thumbnail = json['thumbnail'];
    type = json['type'];
    resolutions = json['resolutions'] != null
        ? Resolutions.fromJson(json['resolutions'])
        : null;
  }
  String? name;
  String? videoLink;
  String? thumbnail;
  String? type;
  Resolutions? resolutions;
  MovieResponse copyWith({
    String? name,
    String? videoLink,
    String? thumbnail,
    String? type,
    Resolutions? resolutions,
  }) =>
      MovieResponse(
        name: name ?? this.name,
        videoLink: videoLink ?? this.videoLink,
        thumbnail: thumbnail ?? this.thumbnail,
        type: type ?? this.type,
        resolutions: resolutions ?? this.resolutions,
      );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = name;
    map['video_link'] = videoLink;
    map['thumbnail'] = thumbnail;
    map['type'] = type;
    if (resolutions != null) {
      map['resolutions'] = resolutions?.toJson();
    }
    return map;
  }
}

class Resolutions {
  Resolutions({
    this.low,
    this.medium,
    this.large,
  });

  Resolutions.fromJson(dynamic json) {
    low = json['LOW'];
    medium = json['MEDIUM'];
    large = json['LARGE'];
  }
  String? low;
  String? medium;
  String? large;
  Resolutions copyWith({
    String? low,
    String? medium,
    String? large,
  }) =>
      Resolutions(
        low: low ?? this.low,
        medium: medium ?? this.medium,
        large: large ?? this.large,
      );
  Map<String, String> toJson() {
    final map = <String, String>{};
    map['LOW'] = low.toString();
    map['MEDIUM'] = medium.toString();
    map['LARGE'] = large.toString();
    return map;
  }
}

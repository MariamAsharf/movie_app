class ImagesResponse {
  ImagesResponse({
    this.backdrops,
    this.id,
    this.logos,
    this.posters,});

  ImagesResponse.fromJson(dynamic json) {
    if (json['backdrops'] != null) {
      backdrops = [];
      json['backdrops'].forEach((v) {
        backdrops?.add(Backdrops.fromJson(v));
      });
    }
    id = json['id'];
    if (json['logos'] != null) {
      logos = [];
      json['logos'].forEach((v) {
        logos?.add(Logos.fromJson(v));
      });
    }
    if (json['posters'] != null) {
      posters = [];
      json['posters'].forEach((v) {
        posters?.add(Posters.fromJson(v));
      });
    }
  }
  List<Backdrops>? backdrops;
  int? id;
  List<Logos>? logos;
  List<Posters>? posters;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (backdrops != null) {
      map['backdrops'] = backdrops?.map((v) => v.toJson()).toList();
    }
    map['id'] = id;
    if (logos != null) {
      map['logos'] = logos?.map((v) => v.toJson()).toList();
    }
    if (posters != null) {
      map['posters'] = posters?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

class Posters {
  Posters({
    this.aspectRatio,
    this.height,
    this.iso6391,
    this.filePath,
    this.voteAverage,
    this.voteCount,
    this.width,});

  Posters.fromJson(dynamic json) {
    aspectRatio = json['aspect_ratio'];
    height = json['height'];
    iso6391 = json['iso_639_1'];
    filePath = json['file_path'];
    voteAverage = json['vote_average'];
    voteCount = json['vote_count'];
    width = json['width'];
  }
  double? aspectRatio;
  int? height;
  String? iso6391;
  String? filePath;
  double? voteAverage;
  int? voteCount;
  int? width;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['aspect_ratio'] = aspectRatio;
    map['height'] = height;
    map['iso_639_1'] = iso6391;
    map['file_path'] = filePath;
    map['vote_average'] = voteAverage;
    map['vote_count'] = voteCount;
    map['width'] = width;
    return map;
  }

}

class Logos {
  Logos({
    this.aspectRatio,
    this.height,
    this.iso6391,
    this.filePath,
    this.voteAverage,
    this.voteCount,
    this.width,});

  Logos.fromJson(dynamic json) {
    aspectRatio = json['aspect_ratio'];
    height = json['height'];
    iso6391 = json['iso_639_1'];
    filePath = json['file_path'];
    voteAverage = json['vote_average'];
    voteCount = json['vote_count'];
    width = json['width'];
  }
  double? aspectRatio;
  int? height;
  String? iso6391;
  String? filePath;
  double? voteAverage;
  int? voteCount;
  int? width;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['aspect_ratio'] = aspectRatio;
    map['height'] = height;
    map['iso_639_1'] = iso6391;
    map['file_path'] = filePath;
    map['vote_average'] = voteAverage;
    map['vote_count'] = voteCount;
    map['width'] = width;
    return map;
  }

}

class Backdrops {
  Backdrops({
    this.aspectRatio,
    this.height,
    this.iso6391,
    this.filePath,
    this.voteAverage,
    this.voteCount,
    this.width,});

  Backdrops.fromJson(dynamic json) {
    aspectRatio = json['aspect_ratio'];
    height = json['height'];
    iso6391 = json['iso_639_1'];
    filePath = json['file_path'];
    voteAverage = json['vote_average'];
    voteCount = json['vote_count'];
    width = json['width'];
  }
  double? aspectRatio;
  int? height;
  dynamic iso6391;
  String? filePath;
  double? voteAverage;
  int? voteCount;
  int? width;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['aspect_ratio'] = aspectRatio;
    map['height'] = height;
    map['iso_639_1'] = iso6391;
    map['file_path'] = filePath;
    map['vote_average'] = voteAverage;
    map['vote_count'] = voteCount;
    map['width'] = width;
    return map;
  }

}
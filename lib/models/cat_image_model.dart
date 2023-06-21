class CatImageModel {
  CatImageModel({
    required this.id,
    required this.url,
    required this.width,
    required this.height,
  });

  factory CatImageModel.fromJson(Map<String, dynamic> json) => CatImageModel(
        id: json['id'] as String,
        url: json['url'] as String,
        width: json['width'] as int,
        height: json['height'] as int,
      );

  final String id;
  final String url;
  final int width;
  final int height;

  Map<String, dynamic> toJson() => {
        'id': id,
        'url': url,
        'width': width,
        'height': height,
      };
}

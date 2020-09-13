class Image {
  double aspectRatio;
  String filePath;
  int height;
  int width;

  Image(this.aspectRatio, this.filePath, this.height, this.width);

  factory Image.fromJson(dynamic json) {
    return Image(
        json['aspect_ratio'] as double, json['file_path'] as String, json['height'] as int, json['width'] as int);
  }
}

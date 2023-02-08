class FeaturedImage {
  String? file;
  String? mimeType;
  int? width;
  String? sourceUrl = "";
  int? height;

  FeaturedImage(
      {this.file, this.mimeType, this.width, this.sourceUrl, this.height});

  FeaturedImage.fromJson(Map<String, dynamic> json) {
    if (json['media_details'] == null) return;

    json = json['media_details']['sizes']['full'];

    file = json['file'];
    mimeType = json['mime_type'];
    width = json['width'];
    sourceUrl = json['source_url'];
    height = json['height'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['file'] = file;
    data['mime_type'] = mimeType;
    data['width'] = width;
    data['source_url'] = sourceUrl;
    data['height'] = height;
    return data;
  }
}

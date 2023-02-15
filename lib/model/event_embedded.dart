import 'featured_image.dart';

class EventEmbedded {
  late List<FeaturedImage> image;

  EventEmbedded({required this.image});

  EventEmbedded.fromJson(Map<String, dynamic> json) {
    if (json['image'] != null) {
      image = <FeaturedImage>[];
      for (var v in (json['wp:featuredmedia'] as List)) {
        image.add(FeaturedImage.fromJson(v));
      }
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['wp:featuredmedia'] = image.map((v) => v.toJson()).toList();
    return data;
  }
}

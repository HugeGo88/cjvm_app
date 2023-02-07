import 'package:cjvm_app/model/post_category.dart';
import 'package:cjvm_app/model/post_embedded_author.dart';

import 'featured_image.dart';

class PostEmbedded {
  List<PostEmbeddedAuthor>? author;
  List<PostCategory>? categories;
  List<FeaturedImage>? image;

  PostEmbedded({this.author, this.categories, this.image});

  PostEmbedded.fromJson(Map<String, dynamic> json) {
    if (json['author'] != null) {
      author = <PostEmbeddedAuthor>[];
      (json['author'] as List).forEach((v) {
        author?.add(PostEmbeddedAuthor.fromJson(v));
      });
    }
    if (json['wp:term'] != null) {
      categories = <PostCategory>[];
      (json['wp:term'][0] as List).forEach((v) {
        categories?.add(PostCategory.fromJson(v));
      });
    }
    if (json['wp:featuredmedia'] != null) {
      image = <FeaturedImage>[];
      (json['wp:featuredmedia'] as List).forEach((v) {
        image?.add(FeaturedImage.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (author != null) {
      data['author'] = author?.map((v) => v.toJson()).toList();
    }
    if (categories != null) {
      data['wp:term'] = categories?.map((v) => v.toJson()).toList();
    }
    if (image != null) {
      data['wp:featuredmedia'] = image?.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

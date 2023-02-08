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
      for (var v in (json['author'] as List)) {
        author?.add(PostEmbeddedAuthor.fromJson(v));
      }
    }
    if (json['wp:term'] != null) {
      categories = <PostCategory>[];
      for (var v in (json['wp:term'][0] as List)) {
        categories?.add(PostCategory.fromJson(v));
      }
    }
    if (json['wp:featuredmedia'] != null) {
      image = <FeaturedImage>[];
      for (var v in (json['wp:featuredmedia'] as List)) {
        image?.add(FeaturedImage.fromJson(v));
      }
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

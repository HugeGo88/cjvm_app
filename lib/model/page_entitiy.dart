import 'package:cjvm_app/model/post_embedded.dart';
import 'package:html/parser.dart';
import 'package:intl/intl.dart';

class PageEntity {
  late String modifiedGmt;
  late PostEmbedded extra = PostEmbedded();
  late String link;
  late int id;
  late String? pictureUrl;
  late String title;
  late String content;

  String _parseHtmlString(String htmlString) {
    final document = parse(htmlString);
    final String parsedString =
        parse(document.body?.text).documentElement!.text;

    return parsedString;
  }

  /// featured image getter with checks for no image
  String get image =>
      extra.image != null ? extra.image![0].sourceUrl ?? '' : '';

  String get category =>
      extra.categories != null ? extra.categories![0].name ?? '' : '';

  String get date => DateFormat('MMM. dd - h:mm a')
      .format(DateTime.parse(modifiedGmt))
      .toString();

  bool isDetailCard = false;

  PageEntity(
      {required this.modifiedGmt,
      required this.extra,
      required this.link,
      required this.id,
      required this.pictureUrl,
      required this.title,
      required this.content});

  PageEntity.fromJson(Map<String, dynamic> json) {
    modifiedGmt = json['modified_gmt'];
    if (json['_embedded'] != null) {
      extra = PostEmbedded.fromJson(json['_embedded']);
    }
    link = json['link'];
    id = json['id'];
    title = json['title'].toString() != "" ? json['title']['rendered'] : null;
    title = _parseHtmlString(title);
    content = json['content'] != null ? json['content']['rendered'] : null;
    pictureUrl = json["yoast_head_json"]?["og_image"]?[0]?["url"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['modified_gmt'] = modifiedGmt;
    data['_embedded'] = extra.toJson();
    data['link'] = link;
    data['id'] = id;
    data['title'] = title;
    data['content'] = content;
    return data;
  }
}

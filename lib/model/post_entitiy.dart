import 'package:cjvm_app/model/post_embedded.dart';
import 'package:html/parser.dart';
import 'package:intl/intl.dart';

class PostEntity {
  late String modifiedGmt;
  late PostEmbedded extra = PostEmbedded();
  late String link;
  late int id;
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

  PostEntity(
      {required this.modifiedGmt,
      required this.extra,
      required this.link,
      required this.id,
      required this.title,
      required this.content});

  PostEntity.fromJson(Map<String, dynamic> json) {
/*     modifiedGmt = json['modified_gmt'];
    extra = json['_embedded'] != null
        ? PostEmbedded.fromJson(json['_embedded'])
        : null; */
    link = json['link'];
    id = json['id'];
    title = json['title'].toString() != null ? json['title']['rendered'] : null;
    title = _parseHtmlString(title);
    content = json['content'] != null ? json['content']['rendered'] : null;
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

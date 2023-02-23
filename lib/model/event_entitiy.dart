import 'package:html/parser.dart';

class EventEntity {
  late int id;
  late String title;
  late String description;
  late DateTime startDate;
  late DateTime endDate;
  late String image;
  late bool allDay;
  late String venue = "";
  late String address = "";
  //EventEmbedded extra;

  String _parseHtmlString(String htmlString) {
    final document = parse(htmlString);
    final String parsedString =
        parse(document.body?.text).documentElement!.text;

    return parsedString;
  }

  EventEntity(
      {required this.id,
      required this.title,
      required this.description,
      required this.startDate,
      required this.endDate});

  EventEntity.fromJson(Map<String, dynamic> json) {
    try {
      id = json['id'];
      title = json['title'].toString() != "" ? json['title'] : "";

      title = _parseHtmlString(title);
      description = json['description'] != "" ? json['description'] : "";
      startDate = DateTime.parse(json['start_date']);
      endDate = DateTime.parse(json['end_date']);
      allDay = json['all_day'];
      image = json['image'].toString() != 'false' ? json['image']['url'] : '';

      var venueData = json['venue'];
      print(venueData.runtimeType.toString());
      if (venueData.runtimeType.toString() == '_Map<String, dynamic>') {
        venue = json['venue']['venue'];
        if (venue == 'Keine Angaben') {
          venue = "";
        } else {
          String street = "";
          String city = "";
          String zip = "";
          if (json['venue'] != null) {
            if (json['venue']['address'] != null) {
              street = json['venue']['address'].toString();
              street = "$street, ";
            }
            if (json['venue']['city'] != null) {
              city = json['venue']['city'].toString();
            }
            if (json['venue']['zip'] != null) {
              zip = json['venue']['zip'].toString();
            }
          }
          address = "$street$zip $city ";
        }
      }
    } catch (e) {
      //TODO Handle No Internet Response
      print(e);
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['description'] = description;
    return data;
  }
}
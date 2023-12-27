import 'package:cjvm_app/model/ticket_entitiy.dart';
import 'package:html/parser.dart';

class EventEntity {
  late int id;
  late String title;
  late String description;
  late DateTime startDate;
  late DateTime endDate;
  late String image;
  late int imageWidth;
  late int imageHeight;
  late bool allDay;
  late String url;
  late String venue = "";
  late String address = "";
  TicketEntity? ticket;
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
      required this.endDate,
      required this.url});

  EventEntity.fromJson(Map<String, dynamic> json) {
    try {
      id = json['id'];
      title = json['title'].toString() != "" ? json['title'] : "";
      url = json['url'].toString() != "" ? json['url'] : "";
      title = _parseHtmlString(title);
      description = json['description'] != "" ? json['description'] : "";
      startDate = DateTime.parse(json['start_date']);
      endDate = DateTime.parse(json['end_date']);
      allDay = json['all_day'];
      image = json['image'].toString() != 'false' ? json['image']['url'] : '';
      imageWidth =
          json['image'].toString() != 'false' ? json['image']['width'] : '';
      imageHeight =
          json['image'].toString() != 'false' ? json['image']['height'] : '';

      var venueData = json['venue'];
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

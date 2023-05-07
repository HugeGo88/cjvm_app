import 'dart:convert';
import 'package:cjvm_app/model/navigation_item_entitiy.dart';

import '../model/event_entitiy.dart';
import '../model/post_entitiy.dart';
import '../utils/constants.dart';
import 'package:http/http.dart' as http;

class WpApi {
  static const String baseUrl = '$url$restUrlPrefix/wp/v2/';

  static Future<List<PostEntity>> getPostsList(
      {int category = 0, int page = 1}) async {
    List<PostEntity> posts = [];
    try {
      String extra = category != 0 ? '&categories=$category' : '';
      dynamic response =
          await http.get(Uri.parse('${baseUrl}posts?_embed&page=$page$extra'));
      dynamic json = jsonDecode(response.body);

      for (var v in (json as List)) {
        posts.add(PostEntity.fromJson(v));
      }
    } catch (e) {
      //TODO Handle No Internet Response
    }
    return posts;
  }

  static Future<List<EventEntity>> getEventList(
      {int category = 0, int page = 1}) async {
    List<EventEntity> events = [];
    try {
      String extra = category != 0 ? '&categories=$category' : '';
      var urll = '${url}wp-json/tribe/events/v1/events?_embed&page=$page$extra';
      dynamic response = await http.get(Uri.parse(urll));
      Map<String, dynamic> map = json.decode(response.body);
      dynamic data = map["events"];
      if (data != null) {
        for (var v in (data as List)) {
          events.add(EventEntity.fromJson(v));
        }
      }
    } catch (e) {
      //TODO Handle No Internet Response
    }
    return events;
  }

  static Future<List<NavigationItemEntitiy>> getNavigationItemList() async {
    List<NavigationItemEntitiy> navigationItmes = [];
    try {
      dynamic response = await http
          .get(Uri.parse('${url}wp-json/menus/v1/locations/main_nav/'));
      Map<String, dynamic> map = json.decode(response.body);
      dynamic data = map["items"];

      if (data != null) {
        for (var v in (data as List)) {
          navigationItmes.add(NavigationItemEntitiy.fromJson(v));
        }
      }
    } catch (e) {
      //TODO do something
    }
    return navigationItmes;
  }
}

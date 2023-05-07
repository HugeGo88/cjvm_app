class NavigationItemEntitiy {
  late int id;
  late String title;
  late String guid;
  late String url;
  late List<NavigationItemEntitiy> childItems;

  NavigationItemEntitiy(
      {required this.id,
      required this.title,
      required this.guid,
      required this.url,
      required this.childItems});

  NavigationItemEntitiy.fromJson(Map<String, dynamic> json) {
    try {
      id = json['ID'];
      title = json['title'];
      guid = json['guid'];
      url = json['url'];
    } catch (e) {
      //TODO do something
    }
  }
}

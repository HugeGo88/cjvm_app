class NavigationItemEntitiy {
  late int id;
  late String title;
  late String guid;
  late String url;
  late String slug;
  late List<NavigationItemEntitiy> childItems;

  NavigationItemEntitiy(
      {required this.id,
      required this.title,
      required this.guid,
      required this.url,
      required this.slug,
      required this.childItems});

  NavigationItemEntitiy.fromJson(Map<String, dynamic> json) {
    try {
      id = json['ID'];
      title = json['title'];
      guid = json['guid'];
      url = json['url'];
      slug = json['slug'] ?? "";
    } catch (e) {
      //TODO do something
    }
  }
}

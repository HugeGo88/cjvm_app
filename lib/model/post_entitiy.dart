class PostEntity {
  String modifiedGmt;
  String link;
  int id;
  String title;
  String content;

  String image = "";

  PostEntity(
      {required this.modifiedGmt,
      required this.link,
      required this.id,
      required this.title,
      required this.content});
}

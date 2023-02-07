class PostEmbeddedAuthor {
  String? avatar;
  String? name;
  String? link;
  int? id;

  PostEmbeddedAuthor({this.avatar, this.name, this.link, this.id});

  PostEmbeddedAuthor.fromJson(Map<String, dynamic> json) {
    avatar = json['avatar_urls'] != null ? json['avatar_urls']['96'] : null;
    name = json['name'];
    link = json['link'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (avatar != null) {
      data['avatar_urls']['96'] = avatar;
    }
    data['name'] = name;
    data['link'] = link;
    data['id'] = id;
    return data;
  }
}

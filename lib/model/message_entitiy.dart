class MessageEntitiy {
  final String id;
  final String title;
  final String body;
  final DateTime receivedAt;
  final bool isRead;
  final Map<String, dynamic> data;

  const MessageEntitiy({
    required this.id,
    required this.title,
    required this.body,
    required this.receivedAt,
    this.isRead = false,
    this.data = const {},
  });

  MessageEntitiy copyWith({
    String? id,
    String? title,
    String? body,
    DateTime? receivedAt,
    bool? isRead,
    Map<String, dynamic>? data,
  }) {
    return MessageEntitiy(
      id: id ?? this.id,
      title: title ?? this.title,
      body: body ?? this.body,
      receivedAt: receivedAt ?? this.receivedAt,
      isRead: isRead ?? this.isRead,
      data: data ?? this.data,
    );
  }

  factory MessageEntitiy.fromJson(Map<String, dynamic> json) {
    return MessageEntitiy(
      id: json['id'] ?? '',
      title: json['title'] ?? '',
      body: json['body'] ?? '',
      receivedAt: DateTime.tryParse(json['receivedAt'] ?? '') ?? DateTime.now(),
      isRead: json['isRead'] ?? false,
      data: Map<String, dynamic>.from(json['data'] ?? {}),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'body': body,
      'receivedAt': receivedAt.toIso8601String(),
      'isRead': isRead,
      'data': data,
    };
  }
}

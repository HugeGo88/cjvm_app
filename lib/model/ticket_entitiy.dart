class TicketEntity {
  late int id;
  late String stock;
  late String capacity;
  late String eventId;
  late DateTime startDate;
  //EventEmbedded extra;

  TicketEntity(
      {required this.id,
      required this.stock,
      required this.capacity,
      required this.eventId,
      required this.startDate});

  TicketEntity.fromJson(Map<String, dynamic> json) {
    // Defensive parsing: ensure all late fields are initialized with
    // sensible defaults even when JSON is missing or malformed.
    try {
      // id may be int or string
      final rawId = json['id'];
      if (rawId is int) {
        id = rawId;
      } else {
        id = int.tryParse(rawId?.toString() ?? '') ?? 0;
      }

      final meta = (json['meta'] is Map) ? json['meta'] as Map<String, dynamic> : <String, dynamic>{};

      stock = meta['_stock']?.toString() ?? '';

      final startRaw = meta['_ticket_start_date'] ?? meta['_start_date'] ?? '';
      DateTime parsedStart;
      try {
        parsedStart = DateTime.parse(startRaw.toString());
      } catch (_) {
        parsedStart = DateTime.fromMillisecondsSinceEpoch(0);
      }
      startDate = parsedStart;

      capacity = meta['_tribe_ticket_capacity']?.toString() ?? '';
      eventId = meta['_tribe_rsvp_for_event']?.toString() ?? '';
    } catch (e, st) {
      // Ensure fields are always initialized to avoid LateInitializationError
      id = json['id'] is int ? json['id'] as int : int.tryParse(json['id']?.toString() ?? '') ?? 0;
      stock = '';
      startDate = DateTime.fromMillisecondsSinceEpoch(0);
      capacity = '';
      eventId = '';
      // Log the error so it's visible during development
      // ignore: avoid_print
      print('TicketEntity.fromJson parsing error: $e\n$st');
    }
  }
}

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
    try {
      id = json['id'];
      stock = json['meta']['_stock'];
      startDate = DateTime.parse(json['meta']['_ticket_start_date']);
      capacity = json['meta']['_tribe_ticket_capacity'];
      eventId = json['meta']['_tribe_rsvp_for_event'];
    } catch (e) {
      //TODO Handle No Internet Response
    }
  }
}

class Shipment {
  final int id;
  final String customerName;
  final String origin;
  final String destination;
  final String status;

  Shipment({
    required this.id,
    required this.customerName,
    required this.origin,
    required this.destination,
    required this.status,
  });

  Shipment copyWith({
    int? id,
    String? customerName,
    String? origin,
    String? destination,
    String? status,
  }) {
    return Shipment(
      id: id ?? this.id,
      customerName: customerName ?? this.customerName,
      origin: origin ?? this.origin,
      destination: destination ?? this.destination,
      status: status ?? this.status,
    );
  }
}
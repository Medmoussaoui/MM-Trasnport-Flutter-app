class TruckEntity {
  final int id;
  final String truckNumber;
  final String truckName;
  final String truckOwner;

  TruckEntity({
    required this.id,
    required this.truckNumber,
    required this.truckName,
    required this.truckOwner,
  });

  factory TruckEntity.fromJson(dynamic data) {
    return TruckEntity(
      id: data["id"],
      truckName: data["truckName"],
      truckNumber: data["truckNumber"],
      truckOwner: data["truckOwner"],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "truckName": truckName,
      "truckNumber": truckNumber,
      "truckOwner": truckOwner,
    };
  }
}

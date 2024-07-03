class ServiceEntity {
  int? id;
  int? serviceId;
  int? driverId;
  int? truckId;
  int? tableId;
  String? boatName;
  String? serviceType;
  double? price;
  String? note;
  String? dateCreate;
  String? truckNumber;
  String? driverName;
  String? truckOwner;
  String? truckName;
  int? payFrom;
  bool? isInactive;

  ServiceEntity({
    this.id,
    this.driverId,
    this.truckId,
    this.tableId,
    this.serviceId,
    this.boatName,
    this.serviceType,
    this.note,
    this.price,
    this.dateCreate,
    this.truckNumber,
    this.driverName,
    this.truckOwner,
    this.payFrom,
    this.truckName,
    this.isInactive,
  });

  factory ServiceEntity.fromJson(dynamic data) {
    return ServiceEntity(
      id: data["id"],
      serviceId: data["serviceId"],
      driverId: data["driverId"],
      truckId: data["truckId"],
      tableId: data["tableId"],
      boatName: data["boatName"],
      serviceType: data["serviceType"],
      price: double.parse(data["price"].toString()),
      note: data["note"],
      payFrom: data["pay_from"],
      dateCreate: data["dateCreate"],
      truckNumber: data["truckNumber"],
      driverName: data["driverName"],
      truckOwner: data["truckOwner"],
      truckName: data["truckName"],
      isInactive: data["inactive"],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "serviceId": serviceId,
      "driverId": driverId,
      "truckId": truckId,
      "tableId": tableId,
      "boatName": boatName,
      "serviceType": serviceType,
      "price": price,
      "note": note,
      "pay_from": payFrom,
      "dateCreate": dateCreate,
      "truckNumber": truckNumber,
      "driverName": driverName,
      "truckOwner": truckOwner,
      //"truckName": truckName,
    };
  }

  Map<String, dynamic> toMapWithNoId() {
    return {
      "serviceId": serviceId,
      "driverId": driverId,
      "truckId": truckId,
      "tableId": tableId,
      "boatName": boatName,
      "serviceType": serviceType,
      "price": price,
      "note": note,
      "pay_from": payFrom,
      "dateCreate": dateCreate,
      "truckNumber": truckNumber,
      "driverName": driverName,
      "truckOwner": truckOwner,
      //"truckName": truckName,
    };
  }
}

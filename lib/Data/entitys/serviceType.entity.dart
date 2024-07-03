class ServiceTypeEntity {
  final String serviceType;

  ServiceTypeEntity(this.serviceType);

  factory ServiceTypeEntity.fromJson(dynamic data) {
    return ServiceTypeEntity(data["serviceType"]);
  }

  Map<String, dynamic> toMap() {
    return {
      "serviceType": serviceType,
    };
  }
}

class BoatNameEntity {
  final String boatName;

  BoatNameEntity(this.boatName);

  factory BoatNameEntity.fromJson(dynamic data) {
    return BoatNameEntity(data["boatName"]);
  }

  Map<String, dynamic> toMap() {
    return {
      "boatName": boatName,
    };
  }
}

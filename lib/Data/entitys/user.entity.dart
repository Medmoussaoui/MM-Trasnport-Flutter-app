class UserData {
  final int? driverId;
  final String? driverName;
  final String? username;
  final String? password;
  final String? registrationDate;
  final int? isAdmin;

  UserData({
    this.driverId,
    this.driverName,
    this.username,
    this.password,
    this.isAdmin,
    this.registrationDate,
  });

  bool get hasFullAccess => admin;

  bool get admin => isAdmin == 1;

  bool get driver => isAdmin == 0;

  factory UserData.fromJson(dynamic user) {
    return UserData(
      driverId: user["driverId"],
      driverName: user["driverName"],
      username: user["username"],
      password: user["password"],
      isAdmin: user['isAdmin'],
      registrationDate: user['registrationDate'],
    );
  }
}

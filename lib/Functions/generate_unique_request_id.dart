import 'package:mmtransport/class/user.dart';
import 'package:uuid/uuid.dart';

String generateUniqueRequestId() {
  Uuid uuid = const Uuid();
  String uid = uuid.v1();
  String username = AppUser.user.username ?? "username";
  return "$username+$uid";
}

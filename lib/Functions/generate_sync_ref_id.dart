import 'package:mmtransport/class/user.dart';

String generateSyncRefId(String syncTableName, dynamic ref) {
  String username = AppUser.user.username ?? "unknown";
  String refId = "$username+$syncTableName+ref";
  return refId;
}

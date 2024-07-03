import 'package:mmtransport/Data/entitys/user.entity.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

class AppUser {
  static late UserData user;
  static String? accessToken;

  static UserData? initial(String? accessToken) {
    if (accessToken == null || accessToken == "") return null;
    AppUser.accessToken = accessToken;
    final userJson = JwtDecoder.decode(accessToken);
    user = UserData.fromJson(userJson);
    return user;
  }

  static clear() {
    user = UserData();
    accessToken = null;
  }
}

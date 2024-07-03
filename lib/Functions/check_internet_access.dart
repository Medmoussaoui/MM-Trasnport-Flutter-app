import 'package:get/get.dart';
import 'package:mmtransport/Functions/handling_api_responce.dart';

Future<bool> checkInternetAccess() async {
  final responce = await GetConnect().get('https://www.google.com');
  return handleApiResponce(responce).isSuccess;
}

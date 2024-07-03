import 'package:mmtransport/Components/custom_internal_server_probelm_dialog.dart';
import 'package:mmtransport/class/api_connection.dart';
import 'package:mmtransport/class/snackbars.dart';

class HandleApiResponceUi {
  late StatusRequest responce;

  final Function(StatusRequest res)? onSuccess;
  final Function(StatusRequest res)? onConnectionError;
  final Function(StatusRequest res)? onRepondError;
  final Function(StatusRequest res)? onServerError;

  HandleApiResponceUi({
    this.onSuccess,
    this.onConnectionError,
    this.onRepondError,
    this.onServerError,
  });

  _onSuccess() {
    if (onSuccess != null) return onSuccess!(responce);
  }

  _onConnectionError() {
    if (onConnectionError != null) return onConnectionError!(responce);
    return AppSnackBars.noInternetAccess();
  }

  _onRepondError() {
    if (onRepondError != null) return onRepondError!(responce);
  }

  _onServerError() {
    if (onServerError != null) return onServerError!(responce);
    return customInternalServerProblemDialog();
  }

  _handle() {
    if (responce.isSuccess) return _onSuccess();
    if (responce.isConnectionError) return _onConnectionError();
    if (responce.isServerFailer) return _onServerError();
    if (responce.isRespondError) return _onRepondError();
  }

  StatusRequest handle(StatusRequest responce) {
    this.responce = responce;
    _handle();
    return responce;
  }
}

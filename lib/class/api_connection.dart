enum ConnectionStatus {
  loading,
  connectionError,
  serverFailer,
  respondError,
  success,
  none,
}

class StatusRequest<T> {
  ConnectionStatus connectionStatus;
  T? data;
  Map<String, String>? headers;

  StatusRequest({
    this.connectionStatus = ConnectionStatus.none,
    this.data,
    this.headers,
  });

  get isRespondError => connectionStatus == ConnectionStatus.respondError;

  get isConnectionError => connectionStatus == ConnectionStatus.connectionError;

  get isServerFailer => connectionStatus == ConnectionStatus.serverFailer;

  get isSuccess => connectionStatus == ConnectionStatus.success;

  bool get isLoading => connectionStatus == ConnectionStatus.loading;

  get isNone => connectionStatus == ConnectionStatus.none;

  get hasData => _hasData();

  bool _hasData() {
    if (data == null) return false;
    if (data is List) return (data as List).isNotEmpty;
    return true;
  }

  StatusRequest success() {
    connectionStatus = ConnectionStatus.success;
    return StatusRequest(
      connectionStatus: ConnectionStatus.success,
      data: data,
      headers: headers,
    );
  }

  StatusRequest loading() {
    connectionStatus = ConnectionStatus.loading;
    return StatusRequest(
      connectionStatus: ConnectionStatus.loading,
      data: data,
      headers: headers,
    );
  }

  StatusRequest serverFailer() {
    connectionStatus = ConnectionStatus.serverFailer;
    return StatusRequest(
      connectionStatus: ConnectionStatus.serverFailer,
      data: data,
      headers: headers,
    );
  }

  StatusRequest respondError() {
    connectionStatus = ConnectionStatus.respondError;
    return StatusRequest(
      connectionStatus: ConnectionStatus.respondError,
      data: data,
      headers: headers,
    );
  }

  StatusRequest connectionError() {
    connectionStatus = ConnectionStatus.connectionError;
    return StatusRequest(
      connectionStatus: ConnectionStatus.connectionError,
      data: data,
      headers: headers,
    );
  }
}

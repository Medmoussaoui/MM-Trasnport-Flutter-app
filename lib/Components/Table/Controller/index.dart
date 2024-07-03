import 'package:flutter/foundation.dart';
import 'package:mmtransport/Components/Table/Controller/filter_rows.dart';
import 'package:mmtransport/Components/Table/Controller/select_rows.dart';
import 'package:mmtransport/Data/entitys/service_entity.dart';
import 'package:mmtransport/Functions/check_connectivity.dart';
import 'package:mmtransport/class/api_connection.dart';
import 'package:mmtransport/class/snackbars.dart';

class TableDataController {
  final Future<StatusRequest> Function()? loadRowsRemotly;
  final Future<StatusRequest> Function()? loadRowsLocally;
  final Future<StatusRequest> Function()? onDeleteRows;
  final List<ServiceEntity>? initialData;

  TableDataController({
    this.loadRowsLocally,
    this.loadRowsRemotly,
    this.initialData,
    this.onDeleteRows,
  }) {
    fetchRowsRequest.data = initialData ?? [];
    onInit();
  }

  late TableFilterController filterController;
  late TableSelectRowsController selectRowsController;

  StatusRequest fetchRowsRequest = StatusRequest(data: []);

  ValueNotifier<bool> refrechColumn = ValueNotifier(false);
  ValueNotifier<bool> refrecchRows = ValueNotifier(false);

  List<ServiceEntity> get initialRows {
    if (fetchRowsRequest.data is List) return fetchRowsRequest.data as List<ServiceEntity>;
    return [];
  }

  List<ServiceEntity> tableRowsData = [];

  List<String> tableColumns = [
    "الباركو",
    "البضاعة",
    "الثمن",
    "التاريخ",
  ];

  void rebuildTableRows() {
    refrecchRows.value = !refrecchRows.value;
  }

  void rebuildTableColumn() {
    refrechColumn.value = !refrechColumn.value;
  }

  void showBottomSheetFilter(int columnIndex) async {
    filterController.onColumnPressed(columnIndex);
  }

  Future<void> fetchRows() async {
    fetchRowsRequest.loading();
    rebuildTableRows();
    fetchRowsRequest = await _fetchRows();
    tableRowsData = List.from(fetchRowsRequest.data);
    rebuildTableRows();
  }

  Future<StatusRequest> _fetchRows() async {
    bool hasConnection = await hasInternet();
    if (hasConnection && loadRowsRemotly != null) {
      final res = await loadRowsRemotly!();
      if (res.isSuccess) {
        return res;
      }
    }
    if (loadRowsLocally != null) {
      return await loadRowsLocally!();
    }
    return StatusRequest(
      data: initialData ?? <ServiceEntity>[],
      connectionStatus: ConnectionStatus.success,
    );
  }

  Future<void> refrech() async {
    fetchRowsRequest.loading();
    rebuildTableRows();
    if (loadRowsLocally != null) {
      fetchRowsRequest = await loadRowsLocally!();
    } else if (loadRowsRemotly != null) {
      fetchRowsRequest = await loadRowsRemotly!();
    } else {
      fetchRowsRequest.success();
    }
    filterController.filtring();
  }

  void disableSelectMode() {
    selectRowsController.disableSelectMode();
  }

  void removeSelectedRows() async {
    await selectRowsController.removeSelectedRows();
    filterController.disableFilterMode();
    AppSnackBars.successDeleteServices();
  }

  void editSelectedRows(List<ServiceEntity> services) {
    selectRowsController.updateSelectedRows(services);
  }

  void disableFilterMode() {
    filterController.disableFilterMode();
  }

  Future<void> initialTableRows(List<ServiceEntity> rows) async {
    rebuildTableRows();
    tableRowsData = [];
    await Future.delayed(const Duration(milliseconds: 100));
    tableRowsData = rows;
    rebuildTableRows();
  }

  void onInit() async {
    filterController = TableFilterController(this);
    selectRowsController = TableSelectRowsController(this);
    fetchRows();
  }
}

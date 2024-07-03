import 'package:get/get.dart';
import 'package:mmtransport/Components/Table/Controller/index.dart';
import 'package:mmtransport/Data/entitys/service_entity.dart';

class TableSelectRowsController {
  final TableDataController controller;

  RxList<int> selectRows = <int>[].obs;
  RxBool selectMode = false.obs;

  TableSelectRowsController(this.controller);

  bool get isAllRowsSelected => controller.tableRowsData.length == selectRows.length;

  RxInt get totalRowsSelect => selectRows.length.obs;

  selectRow(int rowIndex, bool select) {
    if (!selectMode.value) return;
    if (select) return selectRows.remove(rowIndex);
    selectRows.add(rowIndex);
  }

  selectAllRows() {
    if (isAllRowsSelected) return unSelectAll();
    selectRows.clear();
    final rows = List.generate(controller.tableRowsData.length, (index) => index).obs;
    selectRows.addAll(rows);
    controller.rebuildTableRows();
  }

  unSelectAll() {
    selectRows.clear();
    return controller.rebuildTableRows();
  }

  void onLongPress(int rowIndex) {
    if (selectMode.value) return; // Select Mode Aready Enabled
    // Enable Select mode
    selectMode.value = true;
    selectRows.add(rowIndex);
  }

  void disableSelectMode() {
    if (selectMode.value == false) return;
    selectMode.value = false;
    selectRows.clear();
    controller.rebuildTableRows();
  }

  onDoublePress(int rowsIndex) {
    // redirect To edit
  }

  bool isRowSelected(int rowIndex) {
    return selectRows.contains(rowIndex);
  }

  /// This methode will remove only the row in [tableRowsData] and [fetchRowsRequest]
  ///
  /// to make the delete chnange on the table rows view,
  ///
  Future<void> removeSelectedRows() async {
    List<ServiceEntity> rows = List.from(controller.tableRowsData);

    for (int index in selectRows) {
      ServiceEntity row = rows[index];
      controller.tableRowsData.remove(row);
      (controller.fetchRowsRequest.data as List).remove(row);
    }

    disableSelectMode();
    rows.clear();
  }

  /// This Methode will edit only the row in [tableRowsData] and [fetchRowsRequest]
  ///
  /// to make the edit change on the table rows view, the [index] Parameter should comes from
  /// [tableRowsData]
  ///
  Future<void> _editRow(int index, ServiceEntity newService) async {
    List<ServiceEntity> services = controller.fetchRowsRequest.data;

    int indexWhere = services.indexWhere((service) {
      return service.id == newService.id || service.serviceId == newService.serviceId;
    });

    controller.fetchRowsRequest.data[indexWhere] = newService;
    controller.tableRowsData[index] = newService;
  }

  void updateSelectedRows(List<ServiceEntity> rows) {
    for (int index = 0; index < selectRows.length; index++) {
      _editRow(selectRows[index], rows[index]);
    }
    controller.rebuildTableRows();
  }
}

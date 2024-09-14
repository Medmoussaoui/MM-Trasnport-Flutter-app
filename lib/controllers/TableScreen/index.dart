import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:mmtransport/Components/Dialogs/loading_dialog.dart';
import 'package:mmtransport/Components/Table/Controller/index.dart';
import 'package:mmtransport/Components/custom_bottom_sheet_generate_invoice.dart';
import 'package:mmtransport/Components/custom_confirm_delete_dialog.dart';
import 'package:mmtransport/Data/entitys/service_entity.dart';
import 'package:mmtransport/Data/entitys/table.entity.dart';
import 'package:mmtransport/Functions/show_bottom_sheet.dart';
import 'package:mmtransport/Operations/create_service.dart';
import 'package:mmtransport/Operations/edit_service.dart';
import 'package:mmtransport/Operations/get_table_services.dart';
import 'package:mmtransport/Operations/remove_service.dart';
import 'package:mmtransport/Operations/trasnfer_services.dart';
import 'package:mmtransport/View/Widgets/TableScreen/table_menu_bottom_sheet.dart';
import 'package:mmtransport/View/Widgets/TableScreen/table_select_bottom_sheet.dart';
import 'package:mmtransport/class/redirect_to.dart';
import 'package:mmtransport/class/snackbars.dart';
import 'package:mmtransport/controllers/GenerateInvoice/generate_custom_invoice.dart';
import 'package:mmtransport/controllers/GenerateInvoice/generate_table_invoice.dart';
import 'package:mmtransport/controllers/folders/index.dart';

import '../folders/delete_table.dart';

class TableScreenController extends GetxController {
  late TableDataController tableDataController;
  late TableEntity tableEntity;

  late ValueNotifier<TableEntity> table;

  Future<void> showTableMenuSheet() async {
    await customShowBottoSheet(
      TableMenuBottmSheet(
        onRename: () async {
          Get.back();
          await Future.delayed(const Duration(milliseconds: 200));
          RedirectTo.renameTableScreen(
            table: tableEntity,
            onRenameSaved: (renameTable) {
              tableInfoChange(renameTable);
            },
          );
        },
        onDelete: () => deleteTable(),
        onInvoiceStore: () async {
          Get.back();
          await Future.delayed(const Duration(milliseconds: 200));
          RedirectTo.tableInvoiceStoreScreen(
            table: table.value,
            onOut: () {
              tableDataController.fetchRows();
            },
          );
        },
        onNewInvoice: generateTableInvoice,
      ),
    );
  }

  deleteTable() async {
    await DeleteTableConfirmationController(
      table: table.value,
      onSuccess: () {
        Get.find<FoldersScreenController>().deleteTableById(table.value.id!);
        Get.back();
        AppSnackBars.successDeleteTable();
      },
    ).delete();
  }

  Future<void> showTableSelectSheet() async {
    bool oneRowSelect = tableDataController.selectRowsController.totalRowsSelect.value == 1;
    return await customShowBottoSheet(
      TableSelectBottomSheet(
        showEditItem: oneRowSelect,
        showMoreInfoItem: oneRowSelect,
        onEdit: editRow,
        onDelete: removeSelectedRows,
        onMoveItems: transferItems,
        onMoreInfo: () {
          int index = tableDataController.selectRowsController.selectRows[0];
          RedirectTo.serviceMoreInfoScreen(
            services: tableDataController.tableRowsData[index],
          );
        },
        onNewInvoice: generateCustomInvoice,
      ),
    );
  }

  generateCustomInvoice() async {
    List<int> serviceIds = [];
    List<int> rows = tableDataController.selectRowsController.selectRows;
    for (int index in rows) {
      final serviceId = tableDataController.tableRowsData[index].serviceId;
      if (serviceId == null) {
        Get.back();
        return AppSnackBars.serviceNeedSync();
      }
      serviceIds.add(serviceId);
    }
    Get.back();
    await Future.delayed(const Duration(milliseconds: 200));
    customShowBottoSheet(
      isDismissible: false,
      CustomBottomSheetGenerateInvoice(
        controller: GenerateCustomInvoiceController(
          serviceIds: serviceIds,
          tableId: table.value.tableId,
        ),
      ),
    );
  }

  generateTableInvoice() async {
    Get.back();
    await Future.delayed(const Duration(milliseconds: 200));
    if (tableDataController.tableRowsData.isEmpty) {
      AppSnackBars.emptyTable();
      return;
    }
    customShowBottoSheet(
      isDismissible: false,
      CustomBottomSheetGenerateInvoice(
        controller: GenereteTableInvoiceController(tableEntity),
      ),
    );
  }

  List<ServiceEntity> getServices() {
    List<ServiceEntity> services = [];
    for (int index in tableDataController.selectRowsController.selectRows) {
      services.add(tableDataController.tableRowsData[index]);
    }
    return services;
  }

  transferItems() async {
    Get.back();
    await Future.delayed(const Duration(milliseconds: 200));
    RedirectTo.folderTransferScreen(
      totalTransfer: tableDataController.selectRowsController.selectRows.length,
      from: tableEntity,
      onTransferCallback: (result) {
        if (result) {
          tableDataController.selectRowsController.removeSelectedRows();
          AppSnackBars.successTransferServices();
        }
      },
      transfer: (table) async {
        return await TransferTableServices(table, getServices()).transfer();
      },
    );
  }

  Future<void> removeSelectedRows() async {
    Get.back();
    customConfirmDeleteDialog(
      onAccept: () async {
        Get.back();
        customLoadingDailog(text: "جري حذف البيانات");
        bool result = await RemoveSelectedServices(tableDataController).remove();
        Get.back();
        if (result) tableDataController.removeSelectedRows();
      },
    );
  }

  void createService() {
    RedirectTo.createService(
      appBarTitle: tableEntity.tableName,
      onClose: () => tableDataController.refrech(),
      addService: (service) async {
        service.tableId = tableEntity.tableId ?? -tableEntity.id!;
        return await CreateService().create(service);
      },
    );
  }

  void initialArgements() {
    tableEntity = Get.arguments["tableEntity"];
    table = ValueNotifier(tableEntity);
  }

  void tableInfoChange(TableEntity table) {
    this.table.value = TableEntity(
      id: table.id,
      boats: table.boats,
      dateCreate: table.dateCreate,
      lastEdit: table.lastEdit,
      tableId: table.tableId,
      tableName: table.tableName,
    );
  }

  ServiceEntity getServiceRow() {
    int index = tableDataController.selectRowsController.selectRows[0];
    return tableDataController.tableRowsData[index];
  }

  void editRow() async {
    Get.back();
    await Future.delayed(const Duration(milliseconds: 200));
    RedirectTo.editService(
      editService: (service) async {
        final res = await EditService(service).edit();
        if (res.isSuccess) tableDataController.editSelectedRows([service]);
        return res;
      },
      serviceEntity: getServiceRow(),
    );
  }

  @override
  void onInit() {
    initialArgements();
    final getTableServices = GetTableServices(tableEntity);
    tableDataController = TableDataController(
      loadRowsLocally: () async => getTableServices.getDataLocally(),
      loadRowsRemotly: () async => getTableServices.getDataRemotly(),
    );
    super.onInit();
  }

  @override
  void onClose() {
    table.dispose();
    super.onClose();
  }
}

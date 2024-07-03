import 'package:get/get.dart';
import 'package:mmtransport/Components/Dialogs/loading_dialog.dart';
import 'package:mmtransport/Components/Table/Controller/index.dart';
import 'package:mmtransport/Components/custom_bottom_sheet_generate_invoice.dart';
import 'package:mmtransport/Components/custom_confirm_delete_dialog.dart';
import 'package:mmtransport/Constant/app.routes.dart';
import 'package:mmtransport/Data/entitys/service_entity.dart';
import 'package:mmtransport/Functions/show_bottom_sheet.dart';
import 'package:mmtransport/Operations/create_service.dart';
import 'package:mmtransport/Operations/edit_service.dart';
import 'package:mmtransport/Operations/get_new_services.dart';
import 'package:mmtransport/Operations/remove_service.dart';
import 'package:mmtransport/Operations/trasnfer_services.dart';
import 'package:mmtransport/View/Widgets/TableScreen/table_select_bottom_sheet.dart';
import 'package:mmtransport/View/Widgets/homeScreen/custom_menu_bottom_sheet.dart';
import 'package:mmtransport/class/log_out.dart';
import 'package:mmtransport/class/redirect_to.dart';
import 'package:mmtransport/class/snackbars.dart';
import 'package:mmtransport/controllers/GenerateInvoice/generate_custom_invoice.dart';

class HomePageController extends GetxController {
  late TableDataController tableDataController;

  void redirectToFolders() {
    Get.toNamed(AppRoutes.folders);
  }

  void createNewService() {
    RedirectTo.createService(
      addService: (service) async {
        return CreateService().create(service);
      },
      onClose: () => tableDataController.refrech(),
    );
  }

  void showSelectBottomSheet() {
    bool oneRowSelect = tableDataController.selectRowsController.totalRowsSelect.value == 1;
    customShowBottoSheet(
      TableSelectBottomSheet(
        showEditItem: oneRowSelect,
        showMoreInfoItem: oneRowSelect,
        onEdit: editRow,
        onDelete: removeSelectRows,
        onMoveItems: transferItems,
        onNewInvoice: generateInvoice,
        onMoreInfo: () {
          int index = tableDataController.selectRowsController.selectRows[0];
          RedirectTo.serviceMoreInfoScreen(
            services: tableDataController.tableRowsData[index],
          );
        },
      ),
    );
  }

  generateInvoice() async {
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
        controller: GenerateCustomInvoiceController(serviceIds: serviceIds),
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
      onTransferCallback: (result) {
        if (result) {
          tableDataController.selectRowsController.removeSelectedRows();
          AppSnackBars.successTransferServices();
        }
      },
      transfer: (table) async {
        return await TransferNewServices(table, getServices()).transfer();
      },
    );
  }

  void showMenuBottomSheet() {
    customShowBottoSheet(
      HomePageMenuBottmSheet(
        onAccountInfo: () async {
          Get.back();
          await Future.delayed(const Duration(milliseconds: 200));
          RedirectTo.accountInfoScreen();
        },
        onInvoices: () async {
          Get.back();
          await Future.delayed(const Duration(milliseconds: 200));
          RedirectTo.invoiceStoreScreen(onOut: () => tableDataController.fetchRows());
        },
        onSignOut: () async {
          Get.back();
          await Future.delayed(const Duration(milliseconds: 200));
          final logOut = AppLogOut();
          logOut.logout();
        },
        onTransfer: () async {
          Get.back();
          await Future.delayed(const Duration(milliseconds: 200));
          RedirectTo.autoTransferScreen(
            onOut: (req) {
              if (req.isSuccess) tableDataController.fetchRows();
            },
          );
        },
      ),
    );
  }

  Future<void> removeSelectRows() async {
    Get.back();
    customConfirmDeleteDialog(
      onAccept: () async {
        Get.back();
        customLoadingDailog(text: "جري حذف البيانات");
        bool success = await RemoveSelectedServices(tableDataController).remove();
        Get.back();
        if (success) tableDataController.removeSelectedRows();
      },
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
      onClose: () {},
    );
  }

  void _initialTableDataController() {
    final getServices = GetNewServices();
    tableDataController = TableDataController(
      loadRowsLocally: () async => getServices.getDataLocally(),
      loadRowsRemotly: () async => getServices.getDataRemotly(),
    );
  }

  @override
  void onInit() {
    _initialTableDataController();
    super.onInit();
  }
}

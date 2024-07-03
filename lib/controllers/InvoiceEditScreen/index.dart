import 'package:get/get.dart';
import 'package:mmtransport/Components/Table/Controller/index.dart';
import 'package:mmtransport/Data/entitys/invoice.entity.dart';
import 'package:mmtransport/Data/entitys/service_entity.dart';
import 'package:mmtransport/Functions/show_bottom_sheet.dart';
import 'package:mmtransport/View/Widgets/InvoiceEditScreen/select_rows_bottom_sheet.dart';
import 'package:mmtransport/class/redirect_to.dart';
import 'package:mmtransport/controllers/InvoiceEditScreen/create_new_service.dart';
import 'package:mmtransport/controllers/InvoiceEditScreen/delete_invoie_services.dart';
import 'package:mmtransport/controllers/InvoiceEditScreen/edit_service.dart';

class InvoiceEditScreenController extends GetxController {
  late TableDataController tableDataController;
  late Invoice invoice;
  late Function(bool edit) onEdit;

  bool isMakeChanges = false;

  createNewService() {
    RedirectTo.createService(
      addService: (service) async {
        isMakeChanges = true;
        return await InvoiceEditCreateNewService(
          controller: this,
          serviceEntity: service,
        ).create();
      },
    );
  }

  ServiceEntity getRowSelect() {
    int index = tableDataController.selectRowsController.selectRows[0];
    return tableDataController.tableRowsData[index];
  }

  editService() {
    RedirectTo.editService(
      serviceEntity: getRowSelect(),
      editService: (service) async {
        isMakeChanges = true;
        return InvoiceEditScreenEditService(this).editService(service);
      },
    );
  }

  deleteServices() async {
    Get.back();
    await Future.delayed(const Duration(milliseconds: 200));
    DeleteInvoiceServiceControler(this).delete();
  }

  showTableSelectBottomSheet() {
    bool hasOneRowSelected = tableDataController.selectRowsController.selectRows.length == 1;
    customShowBottoSheet(InvoiceEditSelectBottomSheet(
      showEditItem: hasOneRowSelected,
      showMoreInfoItem: hasOneRowSelected,
      onDelete: () => deleteServices(),
      onEdit: () => editService(),
      onMoreInfo: () async {
        Get.back();
        await Future.delayed(const Duration(milliseconds: 200));
        RedirectTo.serviceMoreInfoScreen(services: getRowSelect());
      },
    ));
  }

  initialArgs() {
    invoice = Get.arguments["invoice"];
    onEdit = Get.arguments["onEdit"];
  }

  @override
  void onClose() {
    onEdit(isMakeChanges);
    super.onClose();
  }

  List<ServiceEntity> initialInvoiceServices() {
    List<ServiceEntity> services = [];
    for (ServiceEntity service in invoice.services!) {
      if (service.isInactive != true) services.add(service);
    }
    return services;
  }

  @override
  void onInit() {
    initialArgs();
    tableDataController = TableDataController(
      initialData: initialInvoiceServices(),
    );
    super.onInit();
  }
}

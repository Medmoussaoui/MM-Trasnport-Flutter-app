import 'package:mmtransport/Components/Table/Controller/index.dart';
import 'package:mmtransport/Data/Api/services.api.dart';
import 'package:mmtransport/Data/entitys/invoice.entity.dart';
import 'package:mmtransport/Data/entitys/service_entity.dart';
import 'package:mmtransport/class/api_connection.dart';
import 'package:mmtransport/class/handle_api_responce_ui.dart';
import 'package:mmtransport/controllers/InvoiceEditScreen/index.dart';

class InvoiceEditScreenEditService {
  final InvoiceEditScreenController controller;

  InvoiceEditScreenEditService(this.controller);

  TableDataController get tableController => controller.tableDataController;

  Invoice get invoice => controller.invoice;

  int rowIndex() {
    return tableController.selectRowsController.selectRows[0];
  }

  updateRowService(ServiceEntity service) {
    int index = tableController.initialRows.indexWhere((row) => row.serviceId == service.serviceId);
    tableController.initialData![index] = service;
    tableController.refrech();
  }

  updateInvoiceService(ServiceEntity newService) {
    int index = invoice.services!.indexWhere((service) => service.serviceId == newService.serviceId);
    invoice.services![index] = newService;
  }

  Future<StatusRequest> editService(ServiceEntity newService) async {
    final res = await ServicesApi().editService(newService);
    if (res.isSuccess) {
      updateRowService(ServiceEntity.fromJson(res.data));
      updateInvoiceService(newService);
      invoice.refrechAccounting();
    }
    return HandleApiResponceUi().handle(res);
  }
}

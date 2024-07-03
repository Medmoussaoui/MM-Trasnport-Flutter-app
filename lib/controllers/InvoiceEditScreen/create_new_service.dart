import 'package:mmtransport/Data/Api/invoices.api.dart';
import 'package:mmtransport/Data/entitys/invoice.entity.dart';
import 'package:mmtransport/Data/entitys/service_entity.dart';
import 'package:mmtransport/class/api_connection.dart';
import 'package:mmtransport/class/handle_api_responce_ui.dart';
import 'package:mmtransport/controllers/InvoiceEditScreen/index.dart';

class InvoiceEditCreateNewService {
  final InvoiceEditScreenController controller;
  final ServiceEntity serviceEntity;

  Invoice get invoice => controller.invoice;

  InvoiceEditCreateNewService({
    required this.serviceEntity,
    required this.controller,
  });

  Future<StatusRequest> create() async {
    final res = await InvoicesApi().createNewService(serviceEntity, controller.invoice.invoiceId!);
    if (res.isSuccess) {
      controller.tableDataController.initialData!.add(res.data);
      controller.tableDataController.refrech();
      refrechInvoiceData(res.data);
    }
    return HandleApiResponceUi().handle(res);
  }

  refrechInvoiceData(ServiceEntity newService) {
    controller.invoice.services!.add(newService);
    controller.invoice.refrechAccounting();
  }
}

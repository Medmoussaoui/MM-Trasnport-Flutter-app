import 'package:get/get.dart';
import 'package:mmtransport/Constant/app.routes.dart';
import 'package:mmtransport/Data/entitys/invoice.entity.dart';
import 'package:mmtransport/Data/entitys/service_entity.dart';
import 'package:mmtransport/Data/entitys/table.entity.dart';
import 'package:mmtransport/class/api_connection.dart';

enum RedirectAction { to, off, offAll, until }

redirect(RedirectAction action, String routeName, Map<String, dynamic> arguments) {
  if (action == RedirectAction.to) {
    return Get.toNamed(routeName, arguments: arguments);
  }
  if (action == RedirectAction.off) {
    return Get.offNamed(routeName, arguments: arguments);
  }
  if (action == RedirectAction.offAll) {
    return Get.offAllNamed(routeName, arguments: arguments);
  }
  if (action == RedirectAction.until) {
    return Get.offNamedUntil(routeName, (route) => false, arguments: arguments);
  }
}

class RedirectTo {
  static void login({required RedirectAction action}) {
    redirect(action, AppRoutes.login, {});
  }

  static void home({required RedirectAction action}) {
    redirect(action, AppRoutes.home, {});
  }

  static void createService({
    Function? onClose,
    String? appBarTitle,
    required Future<StatusRequest> Function(ServiceEntity service) addService,
  }) {
    final arguments = {
      "onClose": onClose,
      "addService": addService,
      "appBarTitle": appBarTitle,
    };
    redirect(RedirectAction.to, AppRoutes.createServiceScreen, arguments);
  }

  static void editService({
    RedirectAction action = RedirectAction.to,
    required ServiceEntity serviceEntity,
    required Future<StatusRequest> Function(ServiceEntity serviceEntity) editService,
    Function? onClose,
  }) {
    final arguments = {
      "onClose": onClose,
      "serviceEntity": serviceEntity,
      "editService": editService,
    };
    redirect(action, AppRoutes.editServiceScreen, arguments);
  }

  static void selectTruckNumber({
    RedirectAction action = RedirectAction.to,
    required Future<StatusRequest> Function(ServiceEntity service)? onDetectCallBack,
    required Future<void> Function(ServiceEntity service) redirectTo,
    required ServiceEntity serviceEntity,
  }) {
    final arguments = {
      "onDelectCallback": onDetectCallBack,
      "serviceEntity": serviceEntity,
      "redirectTo": redirectTo,
    };

    redirect(action, AppRoutes.selectTruckScreen, arguments);
  }

  static void successCreateService({
    RedirectAction action = RedirectAction.to,
    required ServiceEntity service,
    required void Function() onClose,
  }) {
    final arguments = {"serviceEntity": service, "onClose": onClose};
    redirect(action, AppRoutes.successAddServiceScreen, arguments);
  }

  static void successEditService({
    RedirectAction action = RedirectAction.to,
    required ServiceEntity service,
    required void Function() onClose,
  }) {
    final arguments = {"serviceEntity": service, "onClose": onClose};
    redirect(action, AppRoutes.successEditServiceScreen, arguments);
  }

  /// Tables
  static void folders({RedirectAction action = RedirectAction.to}) {
    redirect(action, AppRoutes.folders, {});
  }

  static void tableScreen({
    RedirectAction action = RedirectAction.to,
    required TableEntity tableEntity,
  }) {
    final arguments = {"tableEntity": tableEntity};
    redirect(action, AppRoutes.tableScreen, arguments);
  }

  static void createTableScreen({
    RedirectAction action = RedirectAction.to,
    required void Function(TableEntity tableEntity) onCreateCallback,
    void Function(TableEntity tableEntity)? onTableCreate,
  }) {
    final arguments = {
      "onCreateCallback": onCreateCallback,
      "onTableCreate": onTableCreate,
    };
    redirect(action, AppRoutes.createTableScreen, arguments);
  }

  static void renameTableScreen({
    RedirectAction action = RedirectAction.to,
    required TableEntity table,
    required void Function(TableEntity tableEntity) onRenameSaved,
  }) {
    final arguments = {
      "onRenameSaved": onRenameSaved,
      "table": table,
    };
    redirect(action, AppRoutes.renameTableScreen, arguments);
  }

  static void folderTransferScreen({
    RedirectAction action = RedirectAction.to,
    required int totalTransfer,
    TableEntity? from,
    required void Function(bool result) onTransferCallback,
    required Future<bool> Function(TableEntity table) transfer,
  }) {
    final arguments = {
      "totalTransfer": totalTransfer,
      "onTransferCallback": onTransferCallback,
      "transfer": transfer,
      "from": from,
    };
    redirect(action, AppRoutes.foldersTransferScreen, arguments);
  }

  static void serviceMoreInfoScreen({
    RedirectAction action = RedirectAction.to,
    required ServiceEntity services,
  }) {
    final arguments = {"service": services};
    redirect(action, AppRoutes.serviceModeInfoScreen, arguments);
  }

  static void invoiceStoreScreen({
    RedirectAction action = RedirectAction.to,
    Function? onOut,
  }) {
    Map<String, dynamic> arguments = {"onOut": onOut};
    redirect(action, AppRoutes.invoiceStoreScreen, arguments);
  }

  static void invoiceScreen({
    RedirectAction action = RedirectAction.to,
    required Invoice invoice,
    Function(bool change, Invoice invoice)? onUpdated,
  }) {
    Map<String, dynamic> arguments = {
      "invoice": invoice,
      "onUpdated": onUpdated ?? (c, i) {},
    };
    redirect(action, AppRoutes.invoiceScreen, arguments);
  }

  static void tableInvoiceStoreScreen({
    RedirectAction action = RedirectAction.to,
    required TableEntity table,
    Function? onOut,
  }) {
    Map<String, dynamic> arguments = {"table": table, "onOut": onOut};
    redirect(action, AppRoutes.tableInvoicesStoreScreen, arguments);
  }

  static void findInvoiceScreen({
    RedirectAction action = RedirectAction.to,
    required Function(Invoice invoice) onInvoiceChanged,
  }) {
    Map<String, dynamic> arguments = {"onInvoiceChanged": onInvoiceChanged};
    redirect(action, AppRoutes.findInvoiceScreen, arguments);
  }

  static void invoiceSearchScreen({
    RedirectAction action = RedirectAction.to,
    required Function(List<Invoice> linkedInvoice) onInvoiceChanged,
  }) {
    Map<String, dynamic> arguments = {"onInvoiceChanged": onInvoiceChanged};
    redirect(action, AppRoutes.invoiceSearchScreen, arguments);
  }

  static void invoiceEditScreen({
    RedirectAction action = RedirectAction.to,
    required Invoice invoice,
    required Function(bool edit) onEdit,
  }) {
    Map<String, dynamic> arguments = {"invoice": invoice, "onEdit": onEdit};
    redirect(action, AppRoutes.invoiceEditScreen, arguments);
  }

  static void autoTransferScreen({
    RedirectAction action = RedirectAction.to,
    required Function(StatusRequest req) onOut,
  }) {
    Map<String, dynamic> arguments = {"onOut": onOut};
    redirect(action, AppRoutes.autoTransferDataScreen, arguments);
  }

  static void accountInfoScreen({
    RedirectAction action = RedirectAction.to,
  }) {
    Map<String, dynamic> arguments = {};
    redirect(action, AppRoutes.accountInfoScreen, arguments);
  }
}

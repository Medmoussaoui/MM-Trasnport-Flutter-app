class AppApiLinks {
  static const String uri = "https://mimoun-backend.uc.r.appspot.com"; // "http://192.168.1.101:5000"; 
  static final AccountRoutes account = AccountRoutes();
  static final ServicesRoutes services = ServicesRoutes();
  static final TablesRoutes tables = TablesRoutes();
  static final InvoicRoutes invoice = InvoicRoutes();
  static final TruckRoutes trucks = TruckRoutes();
  static final ServiceKeywords serviceKeywords = ServiceKeywords();
}

class AccountRoutes {
  final String login = "${AppApiLinks.uri}/account/login";
  final String changePassword = "${AppApiLinks.uri}/account/changepassword";
}

class ServicesRoutes {
  final String getServices = "${AppApiLinks.uri}/services/";
  final String addService = "${AppApiLinks.uri}/services/new";
  final String deleteServices = "${AppApiLinks.uri}/services/delete";
  final String editService = "${AppApiLinks.uri}/services/edit";
  final String customTransfer = "${AppApiLinks.uri}/services/transfer/custom";
  final String autoTransfer = "${AppApiLinks.uri}/services/transfer/auto";
}

class TablesRoutes {
  final String getTables = "${AppApiLinks.uri}/tables/";
  final String getServices = "${AppApiLinks.uri}/tables/services";
  final String searchOnTable = "${AppApiLinks.uri}/tables/";
  final String createTable = "${AppApiLinks.uri}/tables/createTable";
  final String renameTable = "${AppApiLinks.uri}/tables/settings/rename";
  final String deleteTable = "${AppApiLinks.uri}/tables/settings/delete";
}

class InvoicRoutes {
  final String getAllTableInvoices = "${AppApiLinks.uri}/invoices";
  final String getTableInvoices = "${AppApiLinks.uri}/invoices/table"; // tableId
  final String getInvoice = "${AppApiLinks.uri}/invoices/"; // invocieId
  final String payment = "${AppApiLinks.uri}/invoices/payment"; // invocieId
  final String generateCustomInvoice = "${AppApiLinks.uri}/invoices/generate/custom";
  final String generateTableInvoice = "${AppApiLinks.uri}/invoices/generate/table";
  final String deleteInvoices = "${AppApiLinks.uri}/invoices/delete";
  final String deleteInvoiceServices = "${AppApiLinks.uri}/invoices/services/delete";
  final String saveInvoice = "${AppApiLinks.uri}/invoices/save";
  final String linked = "${AppApiLinks.uri}/invoices/linked";
  final String search = "${AppApiLinks.uri}/invoices/search";
  final String newService = "${AppApiLinks.uri}/invoices/services/new";
  final String changeName = "${AppApiLinks.uri}/invoices/changeName";
}

class TruckRoutes {
  final String getTrucks = "${AppApiLinks.uri}/trucks";
}

class ServiceKeywords {
  final String boatName = "${AppApiLinks.uri}/keywords/boatName";
  final String serviceType = "${AppApiLinks.uri}/keywords/serviceType";
}

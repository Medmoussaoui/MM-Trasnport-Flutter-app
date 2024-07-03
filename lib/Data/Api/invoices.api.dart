import 'package:get/get.dart';
import 'package:mmtransport/Constant/app.api.dart';
import 'package:mmtransport/Data/entitys/invoice.entity.dart';
import 'package:mmtransport/Data/entitys/service_entity.dart';
import 'package:mmtransport/Functions/access_token.dart';
import 'package:mmtransport/Functions/handling_api_responce.dart';
import 'package:mmtransport/class/api_connection.dart';

class InvoicesApi extends GetConnect {
  Future<StatusRequest> getAllTableInvoices(int pageIndex) async {
    String acessToken = await getAccessToken();
    Response responce = await get(
      AppApiLinks.invoice.getAllTableInvoices,
      headers: {"access-token": acessToken, "page": "$pageIndex"},
    );
    StatusRequest res = handleApiResponce(responce);
    if (res.isSuccess) {
      List<TableInvoices> data = [];
      for (final table in res.data) {
        data.add(TableInvoices.fromJson(table));
      }
      res.data = data;
    }
    return res;
  }

  Future<StatusRequest> invoicePayment(int invoiceId, String payStatus) async {
    String accessToken = await getAccessToken();
    Response responce = await post(
      AppApiLinks.invoice.payment,
      {"invoiceId": invoiceId, "pay_status": payStatus},
      headers: {"access-token": accessToken},
    );
    final res = handleApiResponce(responce);
    if (res.isSuccess) res.data = Invoice.fromJeson(res.data);
    return res;
  }

  Future<StatusRequest> getTableInvoices(int tableId, int pageIndex) async {
    String acessToken = await getAccessToken();
    Response responce = await get(
      "${AppApiLinks.invoice.getTableInvoices}/$tableId",
      headers: {"access-token": acessToken, "page": "$pageIndex"},
    );
    StatusRequest res = handleApiResponce(responce);
    if (res.isSuccess && res.hasData) {
      List<Invoice> data = [];
      for (final item in res.data) {
        data.add(Invoice.fromJeson(item));
      }
      res.data = data;
    }
    return res;
  }

  Future<StatusRequest> generateCustomInvoice(List<int> serviceIds, {String? invoiceName, int? tableId}) async {
    String accessToken = await getAccessToken();
    Response response = await post(AppApiLinks.invoice.generateCustomInvoice, {
      "invoiceName": invoiceName,
      "serviceIds": serviceIds,
      "tableId": tableId,
    }, headers: {
      "access-token": accessToken,
    });
    final res = handleApiResponce(response);
    if (res.isSuccess) {
      res.data = Invoice.fromJeson(res.data);
    }
    return res;
  }

  Future<StatusRequest> generateTableInvoice(String invoiceName, int tableId) async {
    String accessToken = await getAccessToken();
    Response response = await post(AppApiLinks.invoice.generateTableInvoice, {
      "invoiceName": invoiceName,
      "tableId": tableId,
    }, headers: {
      "access-token": accessToken,
    });
    final res = handleApiResponce(response);
    if (res.isSuccess) {
      res.data = Invoice.fromJeson(res.data);
    }
    return res;
  }

  Future<StatusRequest> deleteInvoices(List<int> invoiceIds) async {
    String accessToken = await getAccessToken();
    Response res = await post(
      AppApiLinks.invoice.deleteInvoices,
      {"invoiceIds": invoiceIds},
      headers: {"access-token": accessToken},
    );
    return handleApiResponce(res);
  }

  Future<StatusRequest> deleteInvoiceServices(int invoiceId, List<int> serviceIds) async {
    String accessToken = await getAccessToken();
    Response res = await post(
      AppApiLinks.invoice.deleteInvoiceServices,
      {
        "serviceIds": serviceIds,
        "invoiceId": invoiceId,
      },
      headers: {"access-token": accessToken},
    );
    return handleApiResponce(res);
  }

  Future<StatusRequest> saveInvoice(int invoiceId) async {
    String accessToken = await getAccessToken();
    Response res = await put(
      "${AppApiLinks.invoice.saveInvoice}/$invoiceId",
      {},
      headers: {"access-token": accessToken},
    );
    return handleApiResponce(res);
  }

  Future<StatusRequest> getLinkedInvoices(int invoiceId) async {
    String accessToken = await getAccessToken();
    Response responce = await get(
      "${AppApiLinks.invoice.linked}/$invoiceId",
      headers: {"access-token": accessToken},
    );

    final res = handleApiResponce(responce);
    if (res.isSuccess && res.hasData) {
      List<Invoice> invoices = [];
      for (final item in res.data) {
        invoices.add(Invoice.fromJeson(item));
      }
      res.data = invoices;
    }
    return res;
  }

  Future<StatusRequest> getInvoiceById(String invoiceId) async {
    String acessToken = await getAccessToken();
    Response responce = await get(
      "${AppApiLinks.invoice.getInvoice}/$invoiceId",
      headers: {"access-token": acessToken},
    );
    StatusRequest res = handleApiResponce(responce);
    if (res.isSuccess && res.hasData) res.data = Invoice.fromJeson(res.data);
    return res;
  }

  Future<StatusRequest> search(String keyword, int pageIndex) async {
    String acessToken = await getAccessToken();
    Response responce = await get(
      "${AppApiLinks.invoice.search}/$keyword",
      headers: {
        "access-token": acessToken,
        "pageIndex": "$pageIndex",
      },
    );
    StatusRequest res = handleApiResponce(responce);
    if (res.isSuccess && res.hasData) {
      List<Invoice> invoices = [];
      for (final item in res.data) {
        invoices.add(Invoice.fromJeson(item));
      }
      res.data = invoices;
    }
    return res;
  }

  Future<StatusRequest> createNewService(ServiceEntity service, invoiceId) async {
    final body = service.toMapWithNoId();
    body["invoiceId"] = invoiceId;
    String acessToken = await getAccessToken();
    Response responce = await post(
      AppApiLinks.invoice.newService,
      body,
      headers: {"access-token": acessToken},
    );

    final res = handleApiResponce(responce);
    if (res.isSuccess) {
      res.data = ServiceEntity.fromJson(res.data);
    }
    return res;
  }

  Future<StatusRequest> changeInvoiceName(String invoiceName, int invoiceId) async {
    String acessToken = await getAccessToken();

    Response responce = await put(
      AppApiLinks.invoice.changeName,
      {"invoiceName": invoiceName, "invoiceId": invoiceId},
      headers: {"access-token": acessToken},
    );
    return handleApiResponce(responce);
  }
}

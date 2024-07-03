import 'package:mmtransport/Data/entitys/invoice.entity.dart';
import 'package:mmtransport/Data/entitys/service_entity.dart';
import 'package:mmtransport/class/Pdf/Invoice/build_table_columns.dart';
import 'package:pdf/widgets.dart';

import 'build_table_rows.dart';

class InvoiceTableData {
  InvoiceTableData(this.invoice);
  final Invoice invoice;

  List<ServiceEntity> get services => invoice.services!;

  Column tableData = Column(children: []);

  void _addRows() {
    int maxRows = 14;
    for (int index = 0; index < services.length; index++) {
      if (maxRows == index) {
        _createColumns();
        maxRows += 21;
      }
      tableData.children.add(InvoiceTableRow(services[index]).build());
    }
  }

  void _createColumns() {
    tableData.children.add(InvoiceTableColumns().build());
  }

  Widget build() {
    _createColumns();
    _addRows();
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: tableData,
    );
  }
}

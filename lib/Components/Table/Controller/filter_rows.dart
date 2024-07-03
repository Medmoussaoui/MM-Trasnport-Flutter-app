import 'package:mmtransport/Components/Table/Controller/index.dart';
import 'package:mmtransport/Components/Table/FilterBottomSheet/bottom_sheet.dart';
import 'package:mmtransport/Data/entitys/service_entity.dart';
import 'package:mmtransport/Functions/dates.dart';
import 'package:mmtransport/Functions/show_bottom_sheet.dart';

class TableFilterController {
  final TableDataController controller;

  TableFilterController(this.controller);

  late TableColumnController currentColumn;

  late List<TableColumnController> columns = [];

  bool isPrimaryColumn() {
    int index = getColumnIndex();
    return (index == 0 && columns.length > 1);
  }

  void _onBottomSheetFilterClose() {
    if (currentColumn.isAllValuesSelect) {
      if (isPrimaryColumn()) return;
      destroyColumn();
    }
  }

  void _showFilterBottomSheet() async {
    await customShowBottoSheet(TableFilterBottomSheet(controller: controller));
    _onBottomSheetFilterClose();
  }

  void newColumn(int columnIndex) {
    columns.add(TableColumnController(columnIndex));
  }

  /// Remove any column that its [isAllSelectValues] Properties Equal True
  /// To exclude column from filter becuase no filter with all values selected
  /// becuase it will give us same result if we don't use the filter
  /// from the column
  ///
  ///
  void destroyColumn() {
    columns.remove(currentColumn);
  }

  void disableFilterMode() {
    if (columns.isEmpty) return;
    columns.clear();
    controller.initialTableRows(List.from(controller.fetchRowsRequest.data));
    controller.rebuildTableColumn();
    controller.rebuildTableRows();
  }

  /// [getColumnIndex]
  /// search in [columns] on [column] that its columnIndex == spisific columnIndex
  /// to get the index position of it in columns
  ///
  ///
  int getColumnIndex({int? columnIndex}) {
    columnIndex = columnIndex ?? currentColumn.columnIndex;
    return columns.indexWhere((column) => column.columnIndex == columnIndex);
  }

  /// [getColumnInstance]
  /// return the colmun instance from columns that its columnIndex == the spisific
  /// column index we need if if no colmn found we return null value
  ///
  ///
  TableColumnController? getColumnInstance(int columnIndex) {
    int index = getColumnIndex(columnIndex: columnIndex);
    return (index == -1) ? null : columns[index];
  }

  /// [initialColumnValues]
  /// Every time we click on a column except for the primary column this
  /// method will be executed to initialize the column values to be used to
  /// filter the next result with this column
  ///
  ///
  void initialColumnValues() {
    Set<String> values = {};
    for (ServiceEntity row in controller.initialRows) {
      String? value = getColumnValue(row);
      if (value != null) values.add(value);
    }
    bool initial = currentColumn.isIniat;
    currentColumn.initialColumnValues(values: values);
    if (!initial) currentColumn.selectAll();
  }

  String? getColumnValue(ServiceEntity row) {
    int rightColumn = getColumnIndex() - 1;

    for (rightColumn; rightColumn >= 0; rightColumn--) {
      bool inFilterValues = columns[rightColumn].filter(row);
      if (!inFilterValues) return null;
    }

    return currentColumn.getColumnValue(row);
  }

  void onColumnPressed(int index) {
    TableColumnController? column = getColumnInstance(index);

    if (column == null) newColumn(index);

    currentColumn = column ?? columns.last;

    initialColumnValues();
    _showFilterBottomSheet();
  }

  selectValue(String value) {
    currentColumn.selectValue(value);
    filtring();
  }

  void selectAllValues() {
    currentColumn.selectAll();
    filtring();
  }

  void unSelectAll() {
    currentColumn.unSelectAll();
    filtring();
  }

  Future<void> filtring() async {
    List<ServiceEntity> result = [];

    for (ServiceEntity row in controller.initialRows) {
      bool find = columns.every((column) => column.filter(row));
      if (find) result.add(row);
    }

    await controller.initialTableRows(List.from(result));
    controller.rebuildTableColumn();
  }
}

class TableColumnController {
  final int columnIndex;
  final String? columnName;

  Set<String> filterWith = {};
  Set<String> columnValues = {};

  /// [filterState] if it is equal true that means the column is filtred
  /// false the column is not filtred it's  in normal state
  /// column not filtred if [filterWith.length] == [columnValues.length]
  ///
  ///
  bool get isFilterd => filterWith.length != columnValues.length;

  bool get isAllValuesSelect => filterWith.length == columnValues.length;

  bool get isIniat => columnValues.isNotEmpty || filterWith.isNotEmpty;

  TableColumnController(this.columnIndex, {this.columnName});

  /// [filter] this function check if the row with spisific column Row Value
  /// is equal any value in [FilterWith] if true this row will add it
  /// in result of filtring
  ///
  ///
  bool filter(ServiceEntity row) {
    String value = getColumnValue(row);
    return filterWith.contains(value);
  }

  /// [initialColumnValues] this function will add set of values in columnValues
  /// from [rows] in Spesific column, to show this list of values
  /// for select spisific values we need to filter rows with them
  ///
  ///
  void initialColumnValues({required Set values}) {
    columnValues = Set.from(values);
  }

  selectValue(String value) {
    bool isSelect = isValueSelected(value);
    if (isSelect) return unSelectValue(value);
    filterWith.add(value);
  }

  void unSelectValue(String value) {
    filterWith.remove(value);
  }

  void selectAll() {
    filterWith = Set.from(columnValues);
  }

  void unSelectAll() {
    filterWith.clear();
  }

  bool isValueSelected(String value) {
    return filterWith.contains(value);
  }

  String getColumnValue(ServiceEntity serviceData) {
    // this return the rowColumn value that equal current column
    if (columnIndex == 0) return serviceData.boatName.toString();
    if (columnIndex == 1) return serviceData.serviceType.toString();
    if (columnIndex == 2) return serviceData.price.toString();
    if (columnIndex == 3) return getDate(serviceData.dateCreate!);
    return "";
  }
}

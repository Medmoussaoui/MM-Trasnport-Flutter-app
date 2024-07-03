import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mmtransport/Components/Form-suggested/controller.dart';
import 'package:mmtransport/Components/custom_date_picker.dart';
import 'package:mmtransport/Data/entitys/service_entity.dart';
import 'package:mmtransport/Functions/show_bottom_sheet.dart';
import 'package:mmtransport/class/api_connection.dart';
import 'package:mmtransport/class/redirect_to.dart';
import 'package:mmtransport/controllers/CreateService/boat_name_controller.dart';
import 'package:mmtransport/controllers/CreateService/price_form_controller.dart';
import 'package:mmtransport/controllers/CreateService/service_type_controller.dart';

class EditServiceScreenController extends GetxController {
  late TextFormWithSuggestedController boatNameForm;
  late TextFormWithSuggestedController serviceTypeForm;
  late TextEditingController noteFormController;
  late PriceFormController priceFormController;
  final GlobalKey<FormState> formStateKey = GlobalKey();

  late final void Function() onCloseScreen;
  late final Future<StatusRequest> Function(ServiceEntity service) editService;

  late ValueNotifier<DateTime> dateTime;

  DateTime get date => dateTime.value;

  RxInt serviceStatus = 0.obs;
  ServiceEntity service = ServiceEntity();

  /// when we send save request or wen we in save process
  /// [onSaving] Well be true to make the edit screen disable before save
  /// opearation done
  ///
  ///
  RxBool onSaving = false.obs;

  ServiceEntity initialNewService({String? truckNumber}) {
    return ServiceEntity(
      id: service.id,
      serviceId: service.serviceId,
      tableId: service.tableId,
      driverId: service.driverId,
      boatName: boatNameForm.textController.text.trim(),
      serviceType: serviceTypeForm.textController.text.trim(),
      price: double.parse(priceFormController.price.value),
      note: noteFormController.text,
      dateCreate: setDateCreate(),
      payFrom: setServiceStatus(),
      truckNumber: truckNumber ?? service.truckNumber,
      driverName: service.driverName,
      truckId: service.truckId,
      truckOwner: service.truckOwner,
    );
  }

  String setDateCreate() {
    final old = DateTime.parse(service.dateCreate!);
    final newDate = old.copyWith(
      year: dateTime.value.year,
      month: dateTime.value.month,
      day: dateTime.value.day,
    );
    return newDate.toString();
  }

  void showDatePickert() {
    customShowBottoSheet(
      CustomDatePicker(
        date: date,
        onSave: saveDatePicker,
        onChange: (date) {},
      ),
    );
  }

  void saveDatePicker(DateTime datePick) {
    dateTime.value = datePick;
    Get.back();
  }

  void _toFixRTLTextProblem() {
    noteFormController.addListener(() {
      noteFormController.selection = TextSelection.fromPosition(
        TextPosition(offset: noteFormController.text.length),
      );
    });
  }

  bool validationForms() {
    final bool isAllValid = formStateKey.currentState!.validate();
    if (!isAllValid) formStateKey.currentState!.save();
    bool isPriceValid = priceFormController.validate();
    return isAllValid && isPriceValid;
  }

  void saveServiceButton() async {
    if (onSaving.value) return;
    bool isFormsValid = validationForms();

    if (!isFormsValid) return;
    final newService = initialNewService();
    bool makeChange = isMakeChange(newService);
    if (!makeChange) return Get.back();

    onSaving.value = true;

    final res = await saveService(newService);
    onSaving.value = false;
    if (res.isSuccess) successEditService(newService);
  }

  int? setServiceStatus() {
    if (service.payFrom != null && serviceStatus.value == 1) {
      return service.payFrom;
    }
    return (serviceStatus.value == 0) ? null : -1;
  }

  ServiceEntity initial() {
    initialAgruments();
    serviceTypeForm = ServiceTypeController(service.serviceType);
    boatNameForm = BoatNameController(service.boatName);
    noteFormController = TextEditingController(text: service.note);
    priceFormController = PriceFormController(service.price.toString());
    serviceStatus.value = (service.payFrom != null) ? 1 : 0;
    dateTime = ValueNotifier(initialDate());
    return service;
  }

  DateTime initialDate() {
    return DateTime.parse(service.dateCreate!);
  }

  Future<StatusRequest> saveService(ServiceEntity newService) async {
    return await editService(newService);
  }

  bool isMakeChange(ServiceEntity newService) {
    if (newService.boatName != service.boatName) return true;
    if (newService.serviceType != service.serviceType) return true;
    if (newService.price != service.price) return true;
    if (newService.truckNumber != service.truckNumber) return true;
    if (newService.dateCreate != service.dateCreate) return true;
    if (newService.note != service.note) return true;
    if (newService.payFrom != service.payFrom) return true;
    return false;
  }

  void selectTruckNumber() {
    bool isFormValid = validationForms();
    if (!isFormValid) return;
    final newService = initialNewService();
    RedirectTo.selectTruckNumber(
      redirectTo: (service) async {
        RedirectTo.successEditService(
          action: RedirectAction.off,
          service: service,
          onClose: () async => Get.back(),
        );
      },
      onDetectCallBack: editService,
      serviceEntity: newService,
    );
  }

  void successEditService(ServiceEntity newService) {
    RedirectTo.successEditService(
      action: RedirectAction.off,
      service: newService,
      onClose: () async {},
    );
  }

  void initialAgruments() {
    onCloseScreen = Get.arguments['onClose'] ?? () {};
    editService = Get.arguments['editService'];
    service = Get.arguments["serviceEntity"];
  }

  @override
  void onClose() {
    boatNameForm.dispose();
    serviceTypeForm.dispose();
    noteFormController.dispose();
    onCloseScreen();
    super.onClose();
  }

  @override
  void onInit() {
    initial();
    _toFixRTLTextProblem();
    super.onInit();
  }
}

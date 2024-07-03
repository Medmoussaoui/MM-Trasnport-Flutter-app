import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mmtransport/Components/Form-suggested/controller.dart';
import 'package:mmtransport/Data/entitys/service_entity.dart';
import 'package:mmtransport/class/api_connection.dart';
import 'package:mmtransport/class/redirect_to.dart';
import 'package:mmtransport/controllers/CreateService/boat_name_controller.dart';
import 'package:mmtransport/controllers/CreateService/price_form_controller.dart';
import 'package:mmtransport/controllers/CreateService/service_type_controller.dart';

class CreateServiceController extends GetxController {
  late final String appBarTitle;
  late TextFormWithSuggestedController boatNameForm;
  late TextFormWithSuggestedController serviceTypeForm;
  late TextEditingController noteFormController;
  late PriceFormController priceFormController;
  final GlobalKey<FormState> formStateKey = GlobalKey();

  late final void Function() onScreenClose;
  late final Future<StatusRequest> Function(ServiceEntity service) addService;

  late ValueNotifier<DateTime> dateTime;

  DateTime get date => dateTime.value;

  RxInt serviceStatus = 0.obs;
  ServiceEntity service = ServiceEntity();

  void rebuildPriceForm() {
    update(["price"]);
  }

  void rebuildServiceTypeForm() {
    update(["ServiceType"]);
  }

  void saveDatePicker(DateTime datePick) {
    dateTime.value = datePick;
    Get.back();
  }

  void _toFixRTLTextProblem() {
    noteFormController.addListener(() {
      noteFormController.selection = TextSelection.fromPosition(TextPosition(offset: noteFormController.text.length));
    });
  }

  bool validationForms() {
    final bool isAllValid = formStateKey.currentState!.validate();
    if (!isAllValid) formStateKey.currentState!.save();
    bool isPriceValid = priceFormController.validate();
    if (!isPriceValid) rebuildPriceForm();
    return isAllValid && isPriceValid;
  }

  void addServiceButton() {
    bool isFormsValid = validationForms();
    if (!isFormsValid) return;
    // Go To Scan QR Code ...
    initialService();
    selectTruckNumber();
  }

  void selectTruckNumber() {
    RedirectTo.selectTruckNumber(
      redirectTo: (service) async => RedirectTo.successCreateService(
        onClose: () async {
          clearForms();
        },
        service: service,
        action: RedirectAction.off,
      ),
      onDetectCallBack: addService,
      serviceEntity: service,
    );
  }

  void successCreateService() {
    RedirectTo.successCreateService(
      onClose: () async {
        clearForms();
      },
      action: RedirectAction.off,
      service: service,
    );
  }

  void clearForms() {
    boatNameForm.textController.clear();
    serviceTypeForm.textController.clear();
    noteFormController.clear();
    serviceStatus.value = 0;
    priceFormController.defaultState();
    dateTime.value = DateTime.now();
    service = ServiceEntity();
    rebuildPriceForm();
  }

  int? setServiceStatus() {
    return (serviceStatus.value == 0) ? null : -1;
  }

  ServiceEntity initialService() {
    service.boatName = boatNameForm.textFormValue.trim();
    service.serviceType = serviceTypeForm.textFormValue.trim();
    service.price = double.parse(priceFormController.price.value);
    service.note = noteFormController.text;
    service.dateCreate = setDateCreate();
    service.payFrom = setServiceStatus();
    return service;
  }

  void setTruckNumber(String truckNumber) {
    service.truckNumber = truckNumber;
  }

  void initialArguments() {
    onScreenClose = Get.arguments["onClose"] ?? () {};
    addService = Get.arguments["addService"];
    appBarTitle = Get.arguments["appBarTitle"] ?? "انشاء خدمة جديدة";
  }

  @override
  void onClose() {
    boatNameForm.dispose();
    serviceTypeForm.dispose();
    noteFormController.dispose();
    onScreenClose();
    super.onClose();
  }

  String setDateCreate() {
    final now = DateTime.now().toLocal();
    final newDate = date
        .copyWith(
          hour: now.hour,
          minute: now.minute,
          second: now.second,
          millisecond: now.millisecond,
          microsecond: now.microsecond,
        )
        .toString();
    return newDate;
  }

  initialDate() {
    return DateTime.now().toLocal();
  }

  @override
  void onInit() {
    initialArguments();
    serviceTypeForm = ServiceTypeController(null);
    boatNameForm = BoatNameController(null);
    noteFormController = TextEditingController();
    priceFormController = PriceFormController(null);
    _toFixRTLTextProblem();
    dateTime = ValueNotifier(initialDate());
    super.onInit();
  }
}

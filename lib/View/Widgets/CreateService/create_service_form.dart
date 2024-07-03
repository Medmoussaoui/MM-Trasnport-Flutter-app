import 'package:flutter/material.dart';
import 'package:mmtransport/Components/Form-suggested/controller.dart';
import 'package:mmtransport/Components/Form-suggested/index.dart';
import 'package:mmtransport/Functions/validation_required_form.dart';
import 'package:mmtransport/View/Widgets/CreateService/custom_date_from.dart';
import 'package:mmtransport/View/Widgets/CreateService/custom_price_form.dart';
import 'package:mmtransport/View/Widgets/CreateService/service_type_form.dart';
import 'package:mmtransport/controllers/CreateService/price_form_controller.dart';

class CustomCreateServiceForm extends StatelessWidget {
  final TextFormWithSuggestedController boatNameController;
  final TextFormWithSuggestedController serviceTypeController;
  final PriceFormController priceFormController;
  final void Function(DateTime) saveDatePicker;
  final ValueNotifier<DateTime> initialDate;

  const CustomCreateServiceForm({
    required this.boatNameController,
    required this.serviceTypeController,
    required this.priceFormController,
    required this.saveDatePicker,
    required this.initialDate,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 25),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Column(
        children: [
          CustomTextFormWithSuggestedValues(
            textFaildValidater: requiredFormValidation,
            hintText: "اسم القارب",
            controller: boatNameController,
          ),
          ServiceTypeForm(
            controller: serviceTypeController,
          ),
          Row(
            textDirection: TextDirection.ltr,
            children: [
              Expanded(
                child: CustomCreateServiceDateForm(
                  date: initialDate,
                  onChange: (date) {},
                  onSave: saveDatePicker,
                ),
              ),
              const SizedBox(width: 15),
              Expanded(
                child: CustomCreateServicePriceForm(
                  fromController: priceFormController,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

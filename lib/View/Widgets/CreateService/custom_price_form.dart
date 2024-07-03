import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mmtransport/Components/custom_large_title.dart';
import 'package:mmtransport/Constant/app.color.dart';
import 'package:mmtransport/controllers/CreateService/price_form_controller.dart';

class CustomCreateServicePriceForm extends StatefulWidget {
  final PriceFormController fromController;

  const CustomCreateServicePriceForm({
    Key? key,
    required this.fromController,
  }) : super(key: key);

  @override
  State<CustomCreateServicePriceForm> createState() => _CustomCreateServicePriceFormState();
}

class _CustomCreateServicePriceFormState extends State<CustomCreateServicePriceForm> {
  bool clickEffect = false;

  runClickEffect() async {
    setState(() => clickEffect = true);
    await Future.delayed(const Duration(milliseconds: 100));
    setState(() => clickEffect = false);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        FocusManager.instance.primaryFocus?.unfocus();
        await Future.delayed(const Duration(milliseconds: 200));
        widget.fromController.onTap();
        runClickEffect();
      },
      child: ValueListenableBuilder(
        valueListenable: widget.fromController.priceValidState,
        builder: (dsds, bool isFormValid, child) {
          return AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeOut,
            padding: const EdgeInsets.symmetric(horizontal: 15),
            height: 60,
            decoration: BoxDecoration(
              border: Border.all(color: isFormValid ? AppColors.gey : Colors.red),
              borderRadius: BorderRadius.circular(15),
              color: clickEffect ? AppColors.gey : AppColors.gey.withOpacity(0.15),
            ),
            child: Row(
              textDirection: TextDirection.ltr,
              children: [
                const CustomLargeTitle(
                  title: "درهم",
                  color: AppColors.secondColor,
                  size: 16.0,
                ),
                const SizedBox(width: 7.0),
                Expanded(
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Obx(() {
                      final price = widget.fromController.price.value;
                      return FittedBox(
                        child: CustomLargeTitle(
                          title: price.isEmpty ? "0.0" : price,
                          color: price.isEmpty ? Colors.black54 : widget.fromController.color,
                        ),
                      );
                    }),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

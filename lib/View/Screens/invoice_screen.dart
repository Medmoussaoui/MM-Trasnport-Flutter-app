import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mmtransport/Components/custom_large_title.dart';
import 'package:mmtransport/Constant/app.color.dart';
import 'package:mmtransport/Constant/app.images.dart';
import 'package:mmtransport/View/Widgets/InvoiceScreen/icons_bar.dart';
import 'package:mmtransport/View/Widgets/InvoiceScreen/invoice_previews.dart';
import 'package:mmtransport/View/Widgets/InvoiceScreen/invoice_state.dart';
import 'package:mmtransport/controllers/InvoiceScreen/index.dart';

class InvoiceScreen extends StatefulWidget {
  const InvoiceScreen({super.key});

  @override
  State<InvoiceScreen> createState() => _InvoiceScreenState();
}

class _InvoiceScreenState extends State<InvoiceScreen> with SingleTickerProviderStateMixin {
  late InvoiceScreenController controller;
  late AnimationController _controller;
  late Animation<double> _opacity;
  late Animation<double> _dy;

  @override
  void initState() {
    _controller = AnimationController(vsync: this, duration: const Duration(milliseconds: 700));
    _opacity = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 1.0, curve: Curves.easeOut),
      ),
    )..addListener(() {
        setState(() {});
      });

    _dy = Tween<double>(
      begin: -20,
      end: 0.0,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 1.0, curve: Curves.easeOut),
      ),
    )..addListener(() {
        setState(() {});
      });
    _controller.forward();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    controller = Get.put(InvoiceScreenController());
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: AppColors.backgroundColor,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black87),
        centerTitle: true,
        title: const CustomLargeTitle(title: "الفاتورة"),
      ),
      body: WillPopScope(
        onWillPop: () async {
          await controller.onOut();
          return true;
        },
        child: ListView(
          physics: const BouncingScrollPhysics(),
          children: [
            Opacity(
              opacity: _opacity.value,
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  child: Image.asset(AppImages.invoice, height: 70),
                ),
              ),
            ),
            Opacity(
              opacity: _opacity.value,
              child: const InvoiceScreenCustomIconsBar(),
            ),
            Transform.translate(
              offset: Offset(0.0, _dy.value),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                child: CustomInvoiceState(
                  active: controller.canChangeInvoiceState(),
                  groupValue: controller.payStatus,
                  onChange: (value) async {
                    controller.onInvoicePayStatusChange(value);
                  },
                ),
              ),
            ),
            Hero(
              tag: controller.invoice.invoiceId.toString(),
              child: Transform.translate(
                offset: Offset(0.0, _dy.value.abs()),
                child: Opacity(
                  opacity: _opacity.value,
                  child: CustomInvoicePreview(
                    invoice: controller.invoice,
                    refrech: controller.refrechInvoice,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 25),
          ],
        ),
      ),
    );
  }
}

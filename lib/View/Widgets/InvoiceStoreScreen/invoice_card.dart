import 'package:flutter/material.dart';
import 'package:mmtransport/Constant/app.color.dart';
import 'package:mmtransport/Data/entitys/invoice.entity.dart';
import 'package:mmtransport/View/Widgets/InvoiceStoreScreen/accounting.dart';
import 'package:mmtransport/View/Widgets/InvoiceStoreScreen/invoice_card_date.dart';
import 'package:mmtransport/View/Widgets/InvoiceStoreScreen/invoice_card_header.dart';
import 'package:mmtransport/View/Widgets/InvoiceStoreScreen/invoice_card_service.dart';
import 'package:mmtransport/View/Widgets/InvoiceStoreScreen/invoice_card_table_header.dart';

class CustomInvoiceCard extends StatefulWidget {
  final Invoice invoice;
  final Function(Invoice invoice) onPresss;
  final Function(Invoice invoice) onLongPresss;
  final ValueNotifier<bool> selectMode;
  final Function(Invoice invoice) onSelect;
  final bool Function(Invoice invoice) isSelect;

  const CustomInvoiceCard({
    super.key,
    required this.invoice,
    required this.onPresss,
    required this.onSelect,
    required this.onLongPresss,
    required this.selectMode,
    required this.isSelect,
  });

  @override
  State<CustomInvoiceCard> createState() => _CustomInvoiceCardState();
}

class _CustomInvoiceCardState extends State<CustomInvoiceCard> {
  bool isSelect = false;

  bool _isSelect() {
    return widget.isSelect(widget.invoice);
  }

  @override
  Widget build(BuildContext context) {
    isSelect = _isSelect();
    return GestureDetector(
      onTap: () {
        if (widget.selectMode.value) {
          widget.onSelect(widget.invoice);
          setState(() {});
          return;
        }
        widget.onPresss(widget.invoice);
      },
      onLongPress: () {
        widget.onLongPresss(widget.invoice);
        setState(() {});
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
        height: 240,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Colors.white,
          border: isSelect ? Border.all(color: AppColors.secondColor, width: 1.5) : null,
        ),
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    child: InvoiceCardCustomNameAndState(invoice: widget.invoice),
                  ),
                  const InvoiceCardTableHeader(),
                  Expanded(
                    child: InvoiceCardServices(invoice: widget.invoice),
                  ),
                ],
              ),
            ),
            InvoiceCardInfo(invoice: widget.invoice, select: isSelect),
            CustomCardCheckSelect(select: isSelect),
          ],
        ),
      ),
    );
  }
}

class CustomCardCheckSelect extends StatelessWidget {
  final bool select;

  const CustomCardCheckSelect({
    super.key,
    required this.select,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOut,
      height: 20,
      width: 25,
      padding: const EdgeInsets.all(2.0),
      decoration: BoxDecoration(
        color: select ? AppColors.secondColor : Colors.white,
        border: Border.all(color: select ? AppColors.secondColor : Colors.white),
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(10),
          bottomRight: Radius.circular(10),
        ),
      ),
      child: const FittedBox(
        child: Center(
          child: Icon(
            Icons.done_rounded,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}

class InvoiceCardInfo extends StatelessWidget {
  final Invoice invoice;
  final bool select;

  const InvoiceCardInfo({
    super.key,
    required this.invoice,
    required this.select,
  });

  Widget _divider() {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOut,
      width: double.infinity,
      height: 1.5,
      color: select ? AppColors.primaryColor : Colors.white,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        height: 90,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              blurRadius: 5.0,
              spreadRadius: 2.5,
              offset: const Offset(0.0, -10),
            ),
          ],
          borderRadius: const BorderRadius.vertical(
            bottom: Radius.circular(10),
          ),
        ),
        child: Column(
          children: [
            _divider(),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  children: [
                    InvocieCardDate(date: invoice.dateCreate!),
                    const Divider(color: AppColors.gey, height: 0.0),
                    const Spacer(flex: 2),
                    InvoiceCardTotaPayingOff(payingOff: invoice.totalPayingOff!),
                    const SizedBox(height: 3),
                    InvoiceCardFinalTotal(total: invoice.finalTotal!),
                    const Spacer(),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

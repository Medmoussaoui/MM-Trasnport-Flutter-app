import 'package:flutter/material.dart';
import 'package:mmtransport/Components/custom_bottom_sheet_item.dart';
import 'package:mmtransport/Components/custom_bottom_sheet_slider.dart';
import 'package:mmtransport/Components/custom_progress_indicator.dart';
import 'package:mmtransport/Components/custom_secondry_button.dart';
import 'package:mmtransport/Constant/app.color.dart';
import 'package:mmtransport/class/user.dart';
import 'package:mmtransport/controllers/auto_transfer_screen_controller.dart';

class HomePageMenuBottmSheet extends StatelessWidget {
  final Function onTransfer;
  final Function onInvoices;
  final Function onAccountInfo;
  final Function onSignOut;

  const HomePageMenuBottmSheet({
    Key? key,
    required this.onTransfer,
    required this.onInvoices,
    required this.onAccountInfo,
    required this.onSignOut,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isAdmin = AppUser.user.hasFullAccess;
    return Container(
      padding: const EdgeInsets.only(right: 20, left: 20, bottom: 20),
      decoration: const BoxDecoration(
        color: AppColors.bottomSheetColor,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const CustomBottomSheetSlider(),
          const SizedBox(height: 15),
          TransferDataButton(onTransfer: onTransfer),
          CustomBottomSheetItem(
            icon: Icons.receipt_long_rounded,
            title: "الفواتير",
            active: isAdmin,
            onTap: () => onInvoices(),
          ),
          CustomBottomSheetItem(
            icon: Icons.account_circle_outlined,
            title: "المعلومات الشخصية",
            onTap: () => onAccountInfo(),
          ),
          CustomBottomSheetItem(
            icon: Icons.logout_rounded,
            title: "تسجيل الخروج",
            color: Colors.red,
            onTap: () => onSignOut(),
          ),
        ],
      ),
    );
  }
}

class TransferDataButton extends StatefulWidget {
  const TransferDataButton({
    super.key,
    required this.onTransfer,
  });

  final Function onTransfer;

  @override
  State<TransferDataButton> createState() => _TransferDataButtonState();
}

class _TransferDataButtonState extends State<TransferDataButton> {
  bool checking = false;
  bool hasData = false;

  checkToTransfer() async {
    checking = true;
    setState(() {});
    await Future.delayed(const Duration(milliseconds: 500));
    final data = await AutoTransferDataScreenController.getTransferData();
    hasData = data.isNotEmpty;
    checking = false;
    setState(() {});
  }

  @override
  void initState() {
    checkToTransfer();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CustomSecondaryyButton(
      title: "نقل البيانات",
      icon: Icons.drive_file_move_outlined,
      color: AppColors.secondColor,
      elevation: 1.0,
      bottomPadding: 12,
      onPressed: hasData ? () => widget.onTransfer() : null,
      child: checking ? const CustomProgressIndicator(color: Colors.black) : null,
    );
  }
}

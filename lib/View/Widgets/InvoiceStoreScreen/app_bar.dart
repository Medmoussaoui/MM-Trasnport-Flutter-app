import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mmtransport/Components/custom_large_title.dart';
import 'package:mmtransport/Constant/app.color.dart';
import 'package:mmtransport/Data/entitys/invoice.entity.dart';
import 'package:mmtransport/View/Widgets/InvoiceStoreScreen/navigation_bar.dart';
import 'package:mmtransport/View/Widgets/InvoiceStoreScreen/select_mode_app_bar.dart';
import 'package:mmtransport/class/redirect_to.dart';

class InvoiceCustomSliverAppBar extends SliverPersistentHeaderDelegate {
  final void Function(int) onNavigate;
  final double expandedHeight;
  final RxInt navBarGroupValue;
  final String? shrinkAppBarTite;
  final String? expandAppBarTite;
  final CustomInvoiceStoreSelectModeAppBar selectModeAppBar;

  /// onInvoiceChanged the use can get invoice by scan inoice barcode
  /// or from the search screen an then the user can make invoice paid
  /// or cancel the paid of invoice that is Aready paid
  ///
  ///
  final Function(Invoice invoice) onScanInvoiceChnaged;
  final Function(List<Invoice> lined) onSearchInvoiceChanged;

  InvoiceCustomSliverAppBar({
    required this.expandedHeight,
    required this.onNavigate,
    required this.navBarGroupValue,
    this.expandAppBarTite,
    this.shrinkAppBarTite,
    required this.selectModeAppBar,
    required this.onScanInvoiceChnaged,
    required this.onSearchInvoiceChanged,
  });

  Widget showNavBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ValueListenableBuilder(
            valueListenable: selectModeAppBar.selectMode,
            builder: (_, bool val, child) {
              if (val) return selectModeAppBar;
              return CustomInvoiceStoreAppBar(
                title: expandAppBarTite,
                onScanInvoiceChnaged: onScanInvoiceChnaged,
                onSearchInvoiceChanged: onSearchInvoiceChanged,
              );
            },
          ),
          const Spacer(flex: 2),
          SizedBox(
            height: 45,
            child: InvoiceStoreCustomNavigationBar(
              groupValue: navBarGroupValue.value,
              items: const [
                "الكل",
                "المدفوعة",
                "الغير مدفوعة",
              ],
              onNavigate: onNavigate,
            ),
          ),
          const Spacer(),
        ],
      ),
    );
  }

  Widget showAppBarWithTitle() {
    return AppBar(
      iconTheme: const IconThemeData(color: Colors.black87),
      title: CustomLargeTitle(title: shrinkAppBarTite ?? "الفواتير"),
      centerTitle: true,
      elevation: 2.0,
      backgroundColor: AppColors.backgroundColor,
    );
  }

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      decoration: const BoxDecoration(
        color: AppColors.backgroundColor,
      ),
      child: AnimatedSwitcher(
        duration: const Duration(milliseconds: 400),
        switchInCurve: Curves.easeIn,
        child: shrinkOffset < 10 ? showNavBar() : showAppBarWithTitle(),
      ),
    );
  }

  @override
  double get maxExtent => expandedHeight;

  @override
  double get minExtent => kToolbarHeight;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}

class CustomInvoiceStoreAppBar extends StatelessWidget {
  final String? title;

  /// onInvoiceChanged the use can get invoice by scan inoice barcode
  /// or from the search screen an then the user can make invoice paid
  /// or cancel the paid of invoice that is Aready paid
  ///
  ///F
  final Function(Invoice invoice) onScanInvoiceChnaged;

  final Function(List<Invoice> linked) onSearchInvoiceChanged;

  const CustomInvoiceStoreAppBar({
    super.key,
    this.title,
    required this.onScanInvoiceChnaged,
    required this.onSearchInvoiceChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15),
      child: Row(
        children: [
          CustomInvoiceStoreAppBarIcon(
            icon: const Icon(Icons.search_rounded),
            ontap: () {
              RedirectTo.invoiceSearchScreen(onInvoiceChanged: onSearchInvoiceChanged);
            },
          ),
          const SizedBox(width: 12),
          CustomInvoiceStoreAppBarIcon(
            icon: const Icon(Icons.barcode_reader),
            ontap: () {
              RedirectTo.findInvoiceScreen(onInvoiceChanged: onScanInvoiceChnaged);
            },
          ),
          Expanded(
            child: Align(
              alignment: Alignment.centerRight,
              child: FittedBox(
                child: CustomLargeTitle(title: title ?? "مخزن الفواتير", size: 22),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CustomInvoiceStoreAppBarIcon extends StatefulWidget {
  final Function ontap;
  final Icon icon;

  const CustomInvoiceStoreAppBarIcon({
    super.key,
    required this.icon,
    required this.ontap,
  });

  @override
  State<CustomInvoiceStoreAppBarIcon> createState() => _CustomInvoiceStoreAppBarIconState();
}

class _CustomInvoiceStoreAppBarIconState extends State<CustomInvoiceStoreAppBarIcon> {
  bool clicked = false;

  _onTap() async {
    setState(() => clicked = true);
    await Future.delayed(const Duration(milliseconds: 200));
    setState(() => clicked = false);
    widget.ontap();
  }

  Icon _icon() {
    if (clicked) {
      return Icon(
        widget.icon.icon,
        color: Colors.green[500],
        size: widget.icon.size,
      );
    }
    return widget.icon;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _onTap();
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeOut,
        padding: const EdgeInsets.all(13),
        decoration: BoxDecoration(
          color: clicked ? Colors.green[100] : Colors.white,
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: FittedBox(child: _icon()),
      ),
    );
  }
}

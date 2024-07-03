import 'package:flutter/material.dart';
import 'package:mmtransport/Components/custom_large_title.dart';
import 'package:mmtransport/Constant/app.color.dart';
import 'package:mmtransport/Constant/app.images.dart';

class InvoiceSearchCustomDefaultBody extends StatelessWidget {
  const InvoiceSearchCustomDefaultBody({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(
            AppImages.invoice,
            height: 70,
            color: AppColors.geyDeep,
          ),
          const Padding(
            padding: EdgeInsets.only(top: 15, bottom: 10),
            child: CustomLargeTitle(
              title: "البحث عن الفواتير",
              size: 17.0,
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 30),
            child: Text(
              "سيتم جلب كل الفواتير التي تطابق كلمة البحث من خلال اسم الفاتورة",
              style: TextStyle(
                color: AppColors.geyDeep,
                fontSize: 14.5,
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}

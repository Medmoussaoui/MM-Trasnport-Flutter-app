import 'package:flutter/material.dart';
import 'package:mmtransport/Components/custom_large_title.dart';
import 'package:mmtransport/Components/custom_secondry_button.dart';
import 'package:mmtransport/Constant/app.color.dart';

class PrintTicketButton extends StatelessWidget {
  const PrintTicketButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(25),
          topRight: Radius.circular(25),
          bottomLeft: Radius.circular(15),
          bottomRight: Radius.circular(15),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 5,
            spreadRadius: 2.5,
            offset: const Offset(0.0, 3.0),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: const [
              Expanded(
                child: FittedBox(
                  child: CustomLargeTitle(
                    title: "طلب تذكرة",
                    size: 16,
                  ),
                ),
              ),
              SizedBox(width: 5.0),
              Expanded(
                flex: 3,
                child: FittedBox(
                  child: Text(
                    "لطباعة هذه التذكرة قم بالضغط على",
                    style: TextStyle(fontSize: 16, color: AppColors.geyDeep),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          CustomSecondaryyButton(
            bottomPadding: 0.0,
            topPadding: 0.0,
            title: "طلب تذكرة",
            icon: Icons.print,
            onPressed: () {},
          )
        ],
      ),
    );
  }
}

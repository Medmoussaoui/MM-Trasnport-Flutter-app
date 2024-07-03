import 'package:flutter/material.dart';
import 'package:mmtransport/Components/Form-suggested/sugggested_value_item.dart';
import 'package:mmtransport/Components/custom_progress_indicator.dart';
import 'package:mmtransport/Constant/app.color.dart';
import 'package:mmtransport/class/api_connection.dart';

class SuggestedValues extends StatelessWidget {
  final Function(String value)? onSelect;
  final StatusRequest statusRequest;
  final bool show;

  const SuggestedValues({
    this.onSelect,
    this.show = true,
    required this.statusRequest,
    Key? key,
  }) : super(key: key);

  bool _canShow() {
    if (!show) return false;
    return statusRequest.isLoading || (statusRequest.isSuccess && statusRequest.hasData); // can show
  }

  Widget _buildSuggestedValues() {
    List<String> data = statusRequest.data;
    return Column(
      children: List.generate(
        data.length, // max Limit to 3 count
        (index) {
          return SuggestedValueItem(
            onTap: onSelect,
            value: data[index],
          );
        },
      ),
    );
  }

  EdgeInsetsGeometry? _padding() {
    if (_canShow()) {
      return const EdgeInsets.symmetric(vertical: 12, horizontal: 12);
    }
    return null;
  }

  EdgeInsetsGeometry? _margin() {
    return EdgeInsets.only(top: _canShow() ? 5.0 : 0.0, bottom: 15);
  }

  BoxBorder? _boxBordr() {
    if (_canShow()) {
      return Border.all(
        color: AppColors.secondColor,
        width: 0.5,
      );
    }
    return null;
  }

  Widget _child() {
    if (!_canShow()) return const SizedBox.shrink();
    if (statusRequest.isLoading) {
      return const Align(
        alignment: Alignment.centerRight,
        child: CustomProgressIndicator(
          color: AppColors.primaryColor,
        ),
      );
    }
    return _buildSuggestedValues();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedSize(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOut,
      child: Container(
        margin: _margin(),
        padding: _padding(),
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white54,
          borderRadius: BorderRadius.circular(7.0),
          border: _boxBordr(),
        ),
        child: _child(),
      ),
    );
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:mmtransport/Components/custom_bottom_container.dart';
import 'package:mmtransport/Components/custom_primary_button.dart';
import 'package:mmtransport/Constant/app.color.dart';

class CustomSelectTableButton extends StatelessWidget {
  /// if visible equal true the bottom button will be up from down
  /// to be visibile other ways down from up to be unVisible
  ///
  ///
  final ValueNotifier<bool> visible;

  final void Function() onPressed;

  const CustomSelectTableButton({
    super.key,
    required this.visible,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return KeyboardVisibilityBuilder(
      builder: (context, isVisible) {
        if (isVisible) return const SizedBox.shrink();
        return CustomAnimatedBottomContainer(
          color: AppColors.black,
          visible: visible,
          child: CustomPrimaryButton(
            buttonText: "فتح الجدول",
            topPadding: 0,
            bottomPadding: 0,
            onPressed: onPressed,
          ),
        );
      },
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:mmtransport/Constant/app.images.dart';
import '../Constant/app.color.dart';
import 'custom_form_faild.dart';
import 'custom_primary_button.dart';

class HighSecurityConfirmation extends StatelessWidget {
  final Function(bool remove) callback;
  final String name;
  final String? title;
  final String subTitle;
  final String hintText;
  final GlobalKey<FormState>? formTextKey;

  const HighSecurityConfirmation({
    Key? key,
    required this.callback,
    required this.name,
    this.formTextKey,
    this.title,
    required this.subTitle,
    required this.hintText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final formKey = formTextKey ?? GlobalKey<FormState>();
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: ListView(
          physics: const BouncingScrollPhysics(),
          shrinkWrap: true,
          children: [
            _buildMessageCard(),
            const SizedBox(height: 25),
            _buildHintText(),
            _buildForm(formKey),
            _buildDeleteButton(formKey),
          ],
        ),
      ),
    );
  }

  Widget _buildMessageCard() {
    int animationDelay = 0;

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
      decoration: BoxDecoration(
        color: Colors.red.withOpacity(0.07),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const WarningPicture(),
          const SizedBox(height: 12),
          _buildTitle(),
          const SizedBox(height: 7),
          _buildSubTitle(),
        ].map((widget) {
          animationDelay += 100;
          return widget.animate(delay: animationDelay.ms).fade(duration: 300.ms).effect();
        }).toList(),
      ),
    )
        .animate()
        .moveY(
          begin: 100,
          end: 0,
          duration: 650.ms,
          curve: Curves.fastLinearToSlowEaseIn,
        )
        .fade(duration: 300.ms);
  }

  Widget _buildHintText() {
    return Align(
      alignment: Alignment.centerRight,
      child: EnterConfirmValueHint(value: name),
    )
        .animate(delay: 200.ms)
        .moveY(
          begin: 100,
          end: 0,
          duration: 650.ms,
          curve: Curves.fastLinearToSlowEaseIn,
        )
        .fade(duration: 300.ms);
  }

  Widget _buildForm(GlobalKey<FormState> formKey) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Form(
        key: formKey,
        child: CustomTextFormFaild(
          style: const TextStyle(
            height: 1,
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
          validator: (input) {
            if (input != name) return "الادخال غير متطابق";
            return null;
          },
          hintText: hintText,
        ),
      ),
    )
        .animate(delay: 300.ms)
        .moveY(
          begin: 100,
          end: 0,
          duration: 650.ms,
          curve: Curves.fastLinearToSlowEaseIn,
        )
        .fade(duration: 300.ms);
  }

  Widget _buildDeleteButton(GlobalKey<FormState> formKey) {
    return CustomPrimaryButton(
      elevation: 0.5,
      buttonText: "تاكيد الحذف",
      color: Colors.red,
      onPressed: () {
        callback(formKey.currentState!.validate());
      },
    )
        .animate(delay: 300.ms)
        .moveY(
          begin: 100,
          end: 0,
          duration: 1000.ms,
          curve: Curves.elasticOut,
        )
        .fade(duration: 300.ms);
  }

  Widget _buildTitle() {
    return Center(
      child: Text(
        title ?? "تحذير من عملية الحذف",
        style: TextStyle(
          fontWeight: FontWeight.w600,
          height: 1,
          fontSize: 18,
          color: const Color(0xffad220c).withOpacity(0.9),
        ),
      ),
    );
  }

  Widget _buildSubTitle() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Center(
        child: Text(
          subTitle,
          textAlign: TextAlign.center,
          style: TextStyle(
            height: 1,
            fontWeight: FontWeight.w500,
            fontSize: 16,
            color: const Color(0xffad220c).withOpacity(0.7),
          ),
        ),
      ),
    );
  }
}

class EnterConfirmValueHint extends StatelessWidget {
  final String value;

  const EnterConfirmValueHint({
    Key? key,
    required this.value,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const style = TextStyle(
      fontWeight: FontWeight.w500,
      height: 1.1,
      fontSize: 14,
      color: AppColors.black,
    );

    final texts = "لتأكيد عملية الحذف أدخل -".tr.split("-");
    return RichText(
      text: TextSpan(
        style: style,
        children: [
          TextSpan(text: texts[0]),
          TextSpan(
            text: '"$value"',
            style: style.copyWith(fontWeight: FontWeight.bold),
          ),
          TextSpan(text: texts[1]),
        ],
      ),
    );
  }
}

class WarningPicture extends StatelessWidget {
  const WarningPicture({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Image.asset(
        AppImages.error,
        height: 30,
        color: const Color(0xffad220c),
      ),
    );
  }
}

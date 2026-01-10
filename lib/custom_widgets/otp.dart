import 'package:flutter/material.dart';

class OtpFields extends StatefulWidget {
  final void Function(String otp) onCompleted;

  const OtpFields({
    super.key,
    required this.onCompleted,
  });

  @override
  State<OtpFields> createState() => _OtpFieldsState();
}

class _OtpFieldsState extends State<OtpFields> {
  final List<TextEditingController> controllers =
  List.generate(4, (_) => TextEditingController());

  final List<FocusNode> focusNodes =
  List.generate(4, (_) => FocusNode());

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(4, (index) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 6),
          child: _buildOtpBox(index),
        );
      }),
    );
  }

  Widget _buildOtpBox(int index) {
    return SizedBox(
      width: 50,
      height: 55,
      child: TextField(
        controller: controllers[index],
        focusNode: focusNodes[index],
        keyboardType: TextInputType.number,
        textAlign: TextAlign.center,
        maxLength: 1,
        textDirection: TextDirection.ltr,

        style: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),

        decoration: InputDecoration(
          counterText: "",
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(
              color: Color(0xff2D9F5D),
              width: 2,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(
              color: Color(0xff2D9F5D),
              width: 3,
            ),
          ),
        ),

        onChanged: (value) {
          if (value.isNotEmpty && index < 3) {
            FocusScope.of(context).requestFocus(focusNodes[index + 1]);
          }
          if (value.isEmpty && index > 0) {
            FocusScope.of(context).requestFocus(focusNodes[index - 1]);
          }

          if (_allFilled()) {
            final otp = controllers.map((e) => e.text).join();
            widget.onCompleted(otp);
          }
        },
      ),
    );
  }

  bool _allFilled() {
    return controllers.every((c) => c.text.isNotEmpty);
  }
}

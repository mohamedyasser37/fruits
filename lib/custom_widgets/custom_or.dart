import 'package:flutter/material.dart';
import 'package:fruits/helper/app_text_styles.dart';

class CustomOr extends StatelessWidget {
  const CustomOr({super.key});

  @override
  Widget build(BuildContext context) {
    return  SizedBox(
      width: double.infinity,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Divider(
              color: Color(0xffDDDFDF),
              thickness: 1,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18.0),
            child: Text("أو", style: TextStyles.semiBold16),
          ),
          Expanded(
            child: Divider(
              color: Color(0xffDDDFDF),
              thickness: 1,
            ),
          ),

        ],
      ),
    );
  }
}

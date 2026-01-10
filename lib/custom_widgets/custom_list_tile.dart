import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fruits/helper/app_text_styles.dart';

class CustomListTile extends StatelessWidget {
  const CustomListTile({super.key, required this.image, required this.title, required this.onTap});
final String image;
final String title;
final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      shape: RoundedRectangleBorder(
        side: BorderSide(color: Color(0xffDDDFDF)),
        borderRadius: BorderRadius.circular(16),
      ),
      leading: SvgPicture.asset(image),
      onTap: onTap,
      title: Text(
        title,
        textAlign: TextAlign.center,
        style: TextStyles.semiBold16.copyWith(color: Color(0xff0C0D0D)),
      ),
    );
  }
}

import 'package:flutter/material.dart';

import '../common/color_extension.dart';

enum RoundButtonType { bgPrimary, textPrimary }

class RoundButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String title;
  final RoundButtonType type;
  final double fontSize;

  const RoundButton({
    Key? key, // Provide Key? key instead of super.key
    required this.title,
    required this.onPressed,
    this.fontSize = 16,
    this.type = RoundButtonType.bgPrimary,
  }) : super(key: key); // Use Key? key here

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        height: 56,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          border: type == RoundButtonType.bgPrimary ? null : Border.all(color: TColor.primary, width: 1),
          color: type == RoundButtonType.bgPrimary ? TColor.primary : TColor.white,
          borderRadius: BorderRadius.circular(28),
        ),
        child: Text(
          title,
          style: TextStyle(
            color: type == RoundButtonType.bgPrimary ? TColor.white : TColor.primary,
            fontSize: fontSize,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}

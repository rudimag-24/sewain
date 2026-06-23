import 'package:flutter/material.dart';
import '../constants/colors.dart';

enum ButtonStyleType { filled, outlined }

class Button extends StatelessWidget {
  const Button.filled({
    super.key,
    required this.onPressed,
    required this.label,
    this.style = ButtonStyleType.filled,
    this.color = AppColors.primary,
    this.textColor = Colors.white,
    this.width = double.infinity,
    this.height = 54.0,
    this.borderRadius = 8.0,
    this.icon,
    this.suffixIcon,
    this.disabled = false,
    this.fontSize = 14.0,
    this.fontWeight = FontWeight.w600,
    this.mainAxisAlignment = MainAxisAlignment.center,
    this.padding,
  });

  const Button.outlined({
    super.key,
    required this.onPressed,
    required this.label,
    this.style = ButtonStyleType.outlined,
    this.color = Colors.transparent,
    this.textColor = AppColors.black,
    this.width = double.infinity,
    this.height = 54.0,
    this.borderRadius = 8.0,
    this.icon,
    this.suffixIcon,
    this.disabled = false,
    this.fontSize = 14.0,
    this.fontWeight = FontWeight.w600,
    this.mainAxisAlignment = MainAxisAlignment.center,
    this.padding,
  });

  final VoidCallback onPressed;
  final String label;
  final ButtonStyleType style;
  final Color color;
  final Color textColor;
  final double? width;
  final double height;
  final double borderRadius;
  final Widget? icon;
  final Widget? suffixIcon;
  final bool disabled;
  final double fontSize;
  final FontWeight fontWeight;
  final MainAxisAlignment mainAxisAlignment;
  final EdgeInsetsGeometry? padding;

  static const Color _disabledBackground = Color(0xffE2E8F0); // AppColors.stroke
  static const Color _disabledText = Color(0xff94A3B8);

  @override
  Widget build(BuildContext context) {
    final effectiveBackgroundColor = disabled ? _disabledBackground : color;
    final effectiveTextColor = disabled ? _disabledText : textColor;

    return SizedBox(
      height: height,
      width: width,
      child: style == ButtonStyleType.filled
          ? ElevatedButton(
              onPressed: disabled ? null : onPressed,
              style: ElevatedButton.styleFrom(
                padding: padding,
                backgroundColor: effectiveBackgroundColor,
                disabledBackgroundColor: _disabledBackground,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(borderRadius),
                ),
              ),
              child: Row(
                mainAxisAlignment: mainAxisAlignment,
                children: [
                  if (icon != null && label.isNotEmpty) ...[
                    icon ?? const SizedBox.shrink(),
                    const SizedBox(width: 10.0),
                  ],
                  Text(
                    label,
                    style: TextStyle(
                      color: effectiveTextColor,
                      fontSize: fontSize,
                      fontWeight: fontWeight,
                    ),
                  ),
                  if (suffixIcon != null && label.isNotEmpty) ...[
                    const SizedBox(width: 10.0),
                    suffixIcon ?? const SizedBox.shrink(),
                  ],
                ],
              ),
            )
          : OutlinedButton(
              onPressed: disabled ? null : onPressed,
              style: OutlinedButton.styleFrom(
                padding: padding,
                backgroundColor: effectiveBackgroundColor,
                disabledBackgroundColor: color,
                side: BorderSide(
                  color: disabled ? _disabledBackground : AppColors.stroke,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(borderRadius),
                ),
              ),
              child: Row(
                mainAxisAlignment: mainAxisAlignment,
                children: [
                  if (icon != null && label.isNotEmpty) ...[
                    icon ?? const SizedBox.shrink(),
                    const SizedBox(width: 10.0),
                  ],
                  Text(
                    label,
                    style: TextStyle(
                      color: effectiveTextColor,
                      fontSize: fontSize,
                      fontWeight: fontWeight,
                    ),
                  ),
                  if (suffixIcon != null && label.isNotEmpty) ...[
                    const SizedBox(width: 10.0),
                    suffixIcon ?? const SizedBox.shrink(),
                  ],
                ],
              ),
            ),
    );
  }
}
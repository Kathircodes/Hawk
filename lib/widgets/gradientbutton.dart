import 'package:flutter/material.dart';
import 'package:hawk/appgradient.dart';
import 'package:hawk/widgets/gradientstack.dart';

class GradientButton extends StatelessWidget {
  final void Function()? onPressed;
  final Widget? child;
  final EdgeInsetsGeometry padding;

  const GradientButton({
    super.key,
    this.onPressed,
    this.child,
    this.padding = const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: GradientStack(
        gradients: AppGradients.cardBg,
        child: ConstrainedBox(
          constraints: const BoxConstraints(
            minWidth: 170,
          ),
          child: InkWell(
            onTap: onPressed,
            child: Padding(
              padding: padding,
              child: Center(
                child: child,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
